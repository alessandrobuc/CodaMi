import "./options";

import {applicationDefault} from "firebase-admin/app";
import {FieldValue, Timestamp, getFirestore} from "firebase-admin/firestore";
import {getStorage} from "firebase-admin/storage";
import {HttpsError, onCall} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";
import {onSchedule} from "firebase-functions/scheduler";
import {onObjectFinalized} from "firebase-functions/storage";

import {
  MAX_ATTEMPTS,
  PURGE_AFTER_DAYS,
  USER_PHOTO_FOLDERS,
  checkIdOf,
  classify,
  downloadUrlOf,
  moderationLimitsOf,
  photoOwnerOf,
  quarantinePathOf,
  readScores,
  withoutPath,
  type Scores,
} from "./moderation";
import {moderationText, type ModerationMessageKey} from "./moderationMessages";
import {DEFAULT_CHANNEL, languageOf, pushSettingsOf} from "./notifications";
import {SAFE_ID_PATTERN, readString} from "./places";
import {sendToTokens, tokensOf} from "./push";
import {oneOf} from "./support";
import {requireStaff, staffToAlert} from "./supportFunctions";

// Storage triggers must run in the bucket's region.
const STORAGE_REGION = "us-east1";
const VISION_URL = "https://vision.googleapis.com/v1/images:annotate";
const BACKFILL_PAGE_SIZE = 100;

const db = () => getFirestore();
const bucket = () => getStorage().bucket();
const checksRef = () => db().collection("photoChecks");

type Outcome = "clear" | "pending" | "error" | "missing" | "known";

async function safeSearch(path: string): Promise<Scores> {
  const file = bucket().file(path);
  // Vision does not run in the emulator, so tests put the expected result on the file.
  if (process.env.FUNCTIONS_EMULATOR === "true") {
    const [meta] = await file.getMetadata();
    const fake = meta.metadata?.fakeSafeSearch;
    return readScores(typeof fake === "string" ? JSON.parse(fake) : {})!;
  }

  const [bytes] = await file.download();
  const {access_token: token} = await applicationDefault().getAccessToken();
  const response = await fetch(VISION_URL, {
    method: "POST",
    headers: {"Authorization": `Bearer ${token}`, "Content-Type": "application/json"},
    body: JSON.stringify({
      requests: [{
        image: {content: bytes.toString("base64")},
        features: [{type: "SAFE_SEARCH_DETECTION"}],
      }],
    }),
    signal: AbortSignal.timeout(30_000),
  });
  const body = (await response.json().catch(() => ({}))) as {
    error?: unknown;
    responses?: {safeSearchAnnotation?: unknown; error?: unknown}[];
  };
  const first = body.responses?.[0];
  if (!response.ok || first?.error) {
    throw new Error(`Vision failed (${response.status}): ${JSON.stringify(body.error ?? first?.error)}`);
  }
  const scores = readScores(first?.safeSearchAnnotation);
  if (!scores) throw new Error("Vision returned no SafeSearch result");
  return scores;
}

// Checks a user photo once. Held photos move to quarantine, so every link to them stops working.
async function checkPhoto(path: string, {alertStaff = true} = {}): Promise<Outcome> {
  const owner = photoOwnerOf(path);
  if (!owner) return "known";
  const ref = checksRef().doc(checkIdOf(path));
  const existing = await ref.get();
  if (existing.exists && existing.get("status") !== "error") return "known";

  const [exists] = await bucket().file(path).exists();
  if (!exists) return "missing";

  let scores: Scores;
  try {
    scores = await safeSearch(path);
  } catch (error) {
    logger.error("Photo check failed", {path, error});
    await ref.set({
      path,
      ...owner,
      status: "error",
      attempts: FieldValue.increment(1),
      updatedAt: FieldValue.serverTimestamp(),
    }, {merge: true});
    return "error";
  }

  const limits = moderationLimitsOf((await db().collection("config").doc("moderation").get()).data());
  const verdict = classify(scores, limits);
  logger.info("Photo checked", {path, result: verdict.result, ...scores});
  if (verdict.result === "clear") {
    await ref.set({path, ...owner, scores, result: "clear", status: "clear", checkedAt: FieldValue.serverTimestamp()});
    return "clear";
  }

  // Saved before the move: the app may still be asking for the link of a photo it just uploaded.
  const [meta] = await bucket().file(path).getMetadata();
  const user = await db().collection("users").doc(owner.ownerId).get();
  await ref.set({
    path,
    ...owner,
    url: downloadUrlOf(bucket().name, path, meta.metadata?.firebaseStorageDownloadTokens),
    ownerName: user.get("name") ?? user.get("email") ?? "",
    scores,
    ...verdict,
    status: "pending",
    createdAt: FieldValue.serverTimestamp(),
    checkedAt: FieldValue.serverTimestamp(),
  });
  await bucket().file(path).move(quarantinePathOf(path));
  logger.info("Photo held for review", {path, ...verdict});

  if (verdict.result === "blocked") {
    await pushTo([owner.ownerId], "hiddenTitle", "hiddenBody", {kind: "photo_hidden"}, false);
  }
  if (alertStaff) await alertReviewers();
  return "pending";
}

async function alertReviewers(): Promise<void> {
  const pending = await checksRef().where("status", "==", "pending").count().get();
  await pushTo(
    await staffToAlert(),
    "reviewTitle",
    "reviewBody",
    {kind: "photo_review"},
    true,
    {count: String(pending.data().count)},
  );
}

// Staff hear about reviews like support requests; owners get a plain account notice.
async function pushTo(
  uids: string[],
  title: ModerationMessageKey,
  body: ModerationMessageKey,
  data: Record<string, string>,
  staff: boolean,
  vars: Record<string, string> = {},
): Promise<void> {
  if (uids.length === 0) return;
  try {
    const users = await db().getAll(...uids.map((uid) => db().collection("users").doc(uid)));
    for (const user of users) {
      const tokens = tokensOf(user);
      const settings = staff ?
        pushSettingsOf(user.get("notificationPrefs"), "support") :
        {enabled: true, channelId: DEFAULT_CHANNEL, iosSound: "default"};
      if (!user.exists || !settings.enabled || tokens.length === 0) continue;
      const lang = languageOf(user.get("language"));
      const result = await sendToTokens(tokens, {
        notification: {title: moderationText(lang, title, vars), body: moderationText(lang, body, vars)},
        data,
        android: {
          priority: "high",
          notification: {channelId: settings.channelId, ...(staff ? {tag: "photo_review"} : {})},
        },
        apns: {payload: {aps: settings.iosSound ? {sound: settings.iosSound} : {}}},
      });
      logger.info("Moderation notification sent", {uid: user.id, kind: data.kind, ...result});
    }
  } catch (error) {
    logger.error("Moderation push failed", {kind: data.kind, error});
  }
}

// Takes a removed photo out of the owner's pets and listings.
async function removeLinks(ownerId: string, path: string): Promise<number> {
  let changed = 0;
  for (const name of USER_PHOTO_FOLDERS) {
    const owned = await db().collection(name).where("ownerId", "==", ownerId).get();
    for (const doc of owned.docs) {
      const kept = withoutPath(doc.get("photoUrls"), path);
      if (!kept) continue;
      await doc.ref.update({photoUrls: kept});
      changed++;
    }
  }
  return changed;
}

export const onPhotoUploaded = onObjectFinalized(
  {region: STORAGE_REGION, memory: "512MiB", timeoutSeconds: 120},
  async (event) => {
    const {name, contentType} = event.data;
    if (!name || !contentType?.startsWith("image/") || !photoOwnerOf(name)) return;
    await checkPhoto(name);
  },
);

export const moderatePhoto = onCall(async (request) => {
  const staff = await requireStaff(request);
  const checkId = readString(request.data, "checkId", {min: 1, max: 64, pattern: SAFE_ID_PATTERN});
  const action = oneOf(["approve", "remove"] as const, (request.data as {action?: unknown} | null)?.action);
  if (!action) throw new HttpsError("invalid-argument", "Unknown action.");

  const ref = checksRef().doc(checkId);
  const check = await db().runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    if (!snap.exists) throw new HttpsError("not-found", "This photo no longer exists.");
    if (snap.get("status") !== "pending") {
      throw new HttpsError("failed-precondition", "This photo was already reviewed.");
    }
    tx.update(ref, {
      status: action === "approve" ? "approved" : "removed",
      reviewedBy: staff.uid,
      reviewedByName: staff.name,
      reviewedAt: FieldValue.serverTimestamp(),
      ...(action === "remove" ?
        {purgeAt: Timestamp.fromMillis(Date.now() + PURGE_AFTER_DAYS * 86_400_000)} :
        {}),
    });
    return snap.data()!;
  });

  const path = check.path as string;
  const ownerId = check.ownerId as string;
  if (action === "approve") {
    // The copy keeps its download token, so the old links work again.
    await bucket().file(quarantinePathOf(path)).move(path).catch((error) =>
      logger.warn("Approved photo is gone", {path, error}));
    if (check.result === "blocked") {
      await pushTo([ownerId], "restoredTitle", "restoredBody", {kind: "photo_restored"}, false);
    }
  } else {
    const changed = await removeLinks(ownerId, path);
    await pushTo([ownerId], "removedTitle", "removedBody", {kind: "photo_removed"}, false);
    logger.info("Photo removed", {path, by: staff.uid, changed});
  }
  return {status: action === "approve" ? "approved" : "removed"};
});

// Retries failed checks, deletes old removed photos and checks photos uploaded before moderation existed.
export const moderationSweep = onSchedule("every 30 minutes", async () => {
  const failed = await checksRef().where("status", "==", "error").limit(50).get();
  for (const doc of failed.docs) {
    if ((doc.get("attempts") ?? 0) >= MAX_ATTEMPTS) continue;
    await checkPhoto(doc.get("path"));
  }

  const due = await checksRef().where("purgeAt", "<=", Timestamp.now()).limit(100).get();
  for (const doc of due.docs) {
    await bucket().file(quarantinePathOf(doc.get("path"))).delete({ignoreNotFound: true});
    await doc.ref.update({purgeAt: FieldValue.delete(), fileDeleted: true});
  }

  const stateRef = db().collection("config").doc("moderationBackfill");
  const state = (await stateRef.get()).data() ?? {};
  let held = 0;
  if (state.backfillDone !== true) {
    const [files, next] = await bucket().getFiles({
      autoPaginate: false,
      maxResults: BACKFILL_PAGE_SIZE,
      ...(typeof state.pageToken === "string" ? {pageToken: state.pageToken} : {}),
    });
    for (const file of files) {
      if (!file.metadata.contentType?.startsWith("image/") || !photoOwnerOf(file.name)) continue;
      if (await checkPhoto(file.name, {alertStaff: false}) === "pending") held++;
    }
    const pageToken = (next as {pageToken?: string} | null)?.pageToken;
    await stateRef.set(pageToken ? {pageToken} : {backfillDone: true, pageToken: FieldValue.delete()}, {merge: true});
    if (held > 0) await alertReviewers();
  }

  logger.info("Moderation sweep", {retried: failed.size, purged: due.size, backfillHeld: held});
});

// Used by account deletion.
export async function deleteModerationData(uid: string): Promise<void> {
  const checks = await checksRef().where("ownerId", "==", uid).get();
  await Promise.all(checks.docs.map((doc) => doc.ref.delete()));
  await Promise.all(
    USER_PHOTO_FOLDERS.map((folder) =>
      bucket().deleteFiles({prefix: quarantinePathOf(`${folder}/${uid}/`)}),
    ),
  );
}

// The cover of a new listing only goes into the push once it passed the check.
export async function isCleared(path: string | null): Promise<boolean> {
  if (!path || !photoOwnerOf(path)) return false;
  const check = await checksRef().doc(checkIdOf(path)).get();
  return ["clear", "approved"].includes(check.get("status"));
}
