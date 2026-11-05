import "./options";

import {FieldValue, getFirestore} from "firebase-admin/firestore";
import {getStorage} from "firebase-admin/storage";
import {HttpsError, onCall, onRequest} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";

import {pathOfUrl} from "./moderation";
import {markShared} from "./shareRemindersFunctions";
import {dayKey} from "./points";
import {
  SITE, isBot, pageLangOf, pageReportOf, renderReportPage, reportIdOfPath, shareInputOf, viewSourceOf,
} from "./sharing";

const db = () => getFirestore();

async function count(reportId: string, ownerId: unknown, field: "shares" | "views", map: "byTarget" | "viewsBy", key: string) {
  const inc = FieldValue.increment(1);
  const batch = db().batch();
  batch.set(db().collection("reportShares").doc(reportId), {
    ...(typeof ownerId === "string" ? {ownerId} : {}),
    [field]: inc,
    [map]: {[key]: inc},
  }, {merge: true});
  batch.set(db().collection("shareStats").doc(dayKey(Date.now())), {[field]: inc, [map]: {[key]: inc}}, {merge: true});
  await batch.commit();
}

// Counted here, so the numbers can't be changed from the app.
export const logReportShare = onCall(async (request) => {
  if (!request.auth) throw new HttpsError("unauthenticated", "Please sign in again.");
  const input = shareInputOf(request.data);
  if (!input) throw new HttpsError("invalid-argument", "Unknown share.");
  const report = await db().collection("reports").doc(input.reportId).get();
  if (!report.exists || report.get("status") === "hidden") throw new HttpsError("not-found", "Report not found.");
  await count(input.reportId, report.get("ownerId"), "shares", "byTarget", input.target);
  await markShared(request.auth.uid);
  return {counted: true};
});

// Photos held by moderation are moved away, so only files still there are shown.
async function visiblePhotos(urls: unknown): Promise<string[]> {
  if (!Array.isArray(urls)) return [];
  const bucket = getStorage().bucket();
  const checks = await Promise.all(urls.slice(0, 5).map(async (url) => {
    const path = pathOfUrl(url);
    if (!path || typeof url !== "string") return null;
    const [exists] = await bucket.file(path).exists().catch(() => [false]);
    return exists ? url : null;
  }));
  return checks.filter((u): u is string => u !== null);
}

// The public page a shared link opens (/r/<id>), with a preview for chat apps.
export const reportPage = onRequest({maxInstances: 10}, async (req, res) => {
  const lang = pageLangOf(req.query.l, req.get("accept-language"));
  const id = reportIdOfPath(req.path);
  const url = id ? `${SITE}/r/${id}?l=${lang}` : SITE;
  try {
    const [report, version] = await Promise.all([
      id ? db().collection("reports").doc(id).get() : Promise.resolve(null),
      db().collection("config").doc("appVersion").get(),
    ]);
    const data = report?.exists ? report.data() : undefined;
    const page = id ? pageReportOf(id, data, data ? await visiblePhotos(data.photoUrls) : []) : null;
    const storeId = version.get("appStoreId");
    if (page && !isBot(req.get("user-agent"))) {
      await count(page.id, data?.ownerId, "views", "viewsBy", viewSourceOf(req.query.s)).catch((error) =>
        logger.warn("Report view not counted", {id, error}));
    }
    res.set("Cache-Control", "private, max-age=60");
    res.status(page ? 200 : 404).send(renderReportPage(page, {
      lang,
      url,
      appStoreId: typeof storeId === "string" && /^\d{5,15}$/.test(storeId) ? storeId : null,
    }));
  } catch (error) {
    logger.error("Report page failed", {id, error});
    res.status(500).send(renderReportPage(null, {lang, url, appStoreId: null}));
  }
});

export async function deleteReportShares(reportIds: string[]): Promise<void> {
  for (let i = 0; i < reportIds.length; i += 400) {
    const batch = db().batch();
    reportIds.slice(i, i + 400).forEach((id) => batch.delete(db().collection("reportShares").doc(id)));
    await batch.commit();
  }
}
