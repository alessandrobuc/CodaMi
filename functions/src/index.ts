import "./options";

import {initializeApp} from "firebase-admin/app";
import {getAuth} from "firebase-admin/auth";
import {FieldValue, getFirestore, type QueryDocumentSnapshot} from "firebase-admin/firestore";
import {getStorage} from "firebase-admin/storage";
import {onDocumentCreated, onDocumentUpdated, onDocumentWritten} from "firebase-functions/firestore";
import {HttpsError, onCall, type CallableRequest} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";
import {defineString} from "firebase-functions/params";

import {
  SAFE_ID_PATTERN,
  parseCityDetails,
  parseReverseGeocode,
  parseStreetDetails,
  cityQuery,
  mentionsCity,
  parseSuggestions,
  placeLocality,
  readCoordinate,
  suggestionsInCity,
  readString,
} from "./places";
import {
  alertTypeOf,
  becameResolved,
  chunk,
  languageOf,
  newReportContent,
  pushSettingsOf,
  readReport,
  resolvedContent,
  type NotificationContent,
  type PushSettings,
  type ReportSummary,
} from "./notifications";
import {pathOfUrl} from "./moderation";
import {deleteEmergencyData, homeGeohashOf} from "./emergencyFunctions";
import {deleteModerationData, isCleared} from "./moderationFunctions";
import {deletePointsData} from "./pointsFunctions";
import {sendToTokens, tokensOf, type PushToken} from "./push";
import {releaseCasesOf} from "./supportFunctions";
import {searchFieldsOf} from "./users";

initializeApp();

const placesApiKey = defineString("PLACES_API_KEY");

const PLACES_URL = "https://places.googleapis.com/v1";
const ITALY_BIAS = {
  rectangle: {
    low: {latitude: 35.4, longitude: 6.6},
    high: {latitude: 47.1, longitude: 18.6},
  },
};
const LANGUAGE = "it";
const STREET_SEARCH_RADIUS = 15_000;
const PUBLIC_AREA_RADIUS = 100;

function requireAuth(request: CallableRequest): void {
  if (!request.auth) {
    throw new HttpsError(
      "unauthenticated",
      "Please sign in to search for your city.",
    );
  }
}

async function callPlaces(
  path: string,
  init: {method: "GET" | "POST"; body?: string; headers?: Record<string, string>},
): Promise<Record<string, unknown>> {
  let response: Response;
  try {
    response = await fetch(`${PLACES_URL}${path}`, {
      method: init.method,
      body: init.body,
      headers: {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": placesApiKey.value(),
        ...init.headers,
      },
      signal: AbortSignal.timeout(10_000),
    });
  } catch (error) {
    logger.error("Places API unreachable", error);
    throw new HttpsError("unavailable", "City search is temporarily unavailable.");
  }

  const body = (await response.json().catch(() => ({}))) as Record<string, unknown>;
  if (!response.ok) {
    logger.error("Places API error", {status: response.status, error: body.error});
    throw new HttpsError(
      response.status >= 500 ? "unavailable" : "failed-precondition",
      "City search is temporarily unavailable.",
    );
  }
  return body;
}

export const searchCities = onCall(async (request) => {
  requireAuth(request);
  const input = readString(request.data, "input", {min: 2, max: 100});
  const sessionToken = readString(request.data, "sessionToken", {
    min: 8,
    max: 64,
    pattern: SAFE_ID_PATTERN,
  });

  const body = await callPlaces("/places:autocomplete", {
    method: "POST",
    body: JSON.stringify({
      input,
      sessionToken,
      includedPrimaryTypes: ["(cities)"],
      locationBias: ITALY_BIAS,
      languageCode: LANGUAGE,
    }),
  });
  return {suggestions: parseSuggestions(body)};
});

export const getCityDetails = onCall(async (request) => {
  requireAuth(request);
  const placeId = readString(request.data, "placeId", {
    min: 3,
    max: 300,
    pattern: SAFE_ID_PATTERN,
  });
  const sessionToken = readString(request.data, "sessionToken", {
    min: 8,
    max: 64,
    pattern: SAFE_ID_PATTERN,
  });

  const query = new URLSearchParams({sessionToken, languageCode: LANGUAGE});
  const body = await callPlaces(`/places/${placeId}?${query}`, {
    method: "GET",
    headers: {"X-Goog-FieldMask": "id,location,addressComponents"},
  });

  const city = parseCityDetails(body);
  if (!city) {
    throw new HttpsError(
      "not-found",
      "We couldn't find that city. Please pick another one.",
    );
  }
  return city;
});

export const searchStreets = onCall(async (request) => {
  requireAuth(request);
  const input = readString(request.data, "input", {min: 2, max: 100});
  const sessionToken = readString(request.data, "sessionToken", {
    min: 8,
    max: 64,
    pattern: SAFE_ID_PATTERN,
  });
  const lat = readCoordinate(request.data, "lat", 90);
  const lng = readCoordinate(request.data, "lng", 180);
  const city = readString(request.data, "city", {min: 1, max: 100});
  const rawCountry = (request.data as {country?: unknown} | null)?.country;
  const country =
    typeof rawCountry === "string" && /^[A-Za-z]{2}$/.test(rawCountry)
      ? rawCountry.toLowerCase()
      : null;

  const body = await callPlaces("/places:autocomplete", {
    method: "POST",
    body: JSON.stringify({
      input: cityQuery(input, city),
      sessionToken,
      ...(country ? {includedRegionCodes: [country]} : {}),
      locationRestriction: {
        circle: {
          center: {latitude: lat, longitude: lng},
          radius: STREET_SEARCH_RADIUS,
        },
      },
      languageCode: LANGUAGE,
    }),
  });
  return {suggestions: suggestionsInCity(parseSuggestions(body), city)};
});

export const getStreetDetails = onCall(async (request) => {
  requireAuth(request);
  const placeId = readString(request.data, "placeId", {
    min: 3,
    max: 300,
    pattern: SAFE_ID_PATTERN,
  });
  const sessionToken = readString(request.data, "sessionToken", {
    min: 8,
    max: 64,
    pattern: SAFE_ID_PATTERN,
  });
  const city = readString(request.data, "city", {min: 1, max: 100});

  const query = new URLSearchParams({sessionToken, languageCode: LANGUAGE});
  const body = await callPlaces(`/places/${placeId}?${query}`, {
    method: "GET",
    headers: {"X-Goog-FieldMask": "id,location,addressComponents,displayName,types"},
  });

  const locality = placeLocality(body);
  if (locality && !mentionsCity(locality, city)) {
    throw new HttpsError(
      "out-of-range",
      `That place is not in ${city}. Please pick one in ${city}.`,
    );
  }

  const street = parseStreetDetails(body);
  if (!street) {
    throw new HttpsError(
      "not-found",
      "We couldn't find that place. Please pick another one.",
    );
  }
  return {...street, radius: PUBLIC_AREA_RADIUS};
});

const TRIGGER_REGION = "us-central1";

async function notifyCity(
  report: ReportSummary,
  contentFor: (lang: string) => NotificationContent,
): Promise<void> {
  const db = getFirestore();
  const users = await db
    .collection("users")
    .where("cityKey", "==", report.cityKey)
    .get();
  const recipients = users.docs.filter(
    (d) => d.id !== report.ownerId && !hasBlocked(d, report.ownerId),
  );
  if (recipients.length === 0) return;

  const byLanguage = new Map<string, typeof recipients>();
  for (const user of recipients) {
    const lang = languageOf(user.get("language"));
    byLanguage.set(lang, [...(byLanguage.get(lang) ?? []), user]);
  }

  for (const [lang, group] of byLanguage) {
    await notifyGroup(report, contentFor(lang), group);
  }
}

function hasBlocked(user: QueryDocumentSnapshot, ownerId: string): boolean {
  const blocked = user.get("blockedUsers");
  return typeof blocked === "object" && blocked !== null && ownerId in blocked;
}

async function notifyGroup(
  report: ReportSummary,
  content: NotificationContent,
  recipients: QueryDocumentSnapshot[],
): Promise<void> {
  const db = getFirestore();
  for (const group of chunk(recipients, 400)) {
    const batch = db.batch();
    for (const user of group) {
      batch.set(user.ref.collection("notifications").doc(), {
        kind: content.kind,
        title: content.title,
        body: content.body,
        reportId: report.id,
        reportType: report.type,
        photoUrl: report.photoUrl,
        petName: report.petName,
        city: report.city,
        placeDetail: report.placeDetail,
        read: false,
        createdAt: FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
  }

  const type = alertTypeOf(content.kind, report.type);
  const byPayload = new Map<string, {settings: PushSettings; tokens: PushToken[]}>();
  for (const user of recipients) {
    const settings = pushSettingsOf(user.get("notificationPrefs"), type);
    if (!settings.enabled) continue;
    const key = `${settings.channelId}|${settings.iosSound}`;
    const group = byPayload.get(key) ?? {settings, tokens: []};
    group.tokens.push(...tokensOf(user));
    byPayload.set(key, group);
  }

  for (const {settings, tokens} of byPayload.values()) {
    await sendPush(report, content, settings, tokens);
  }
}

async function sendPush(
  report: ReportSummary,
  content: NotificationContent,
  settings: PushSettings,
  tokens: PushToken[],
): Promise<void> {
  if (tokens.length === 0) return;
  const result = await sendToTokens(tokens, {
    notification: {title: content.title, body: content.body},
    data: {reportId: report.id, kind: content.kind},
    android: {
      priority: "high",
      notification: {
        channelId: settings.channelId,
        color: report.type === "lost" ? "#C2410C" : "#1F6F5B",
        ...(report.photoUrl ? {imageUrl: report.photoUrl} : {}),
      },
    },
    apns: {payload: {aps: settings.iosSound ? {sound: settings.iosSound} : {}}},
  });
  logger.info("Report notification sent", {
    reportId: report.id,
    kind: content.kind,
    channel: settings.channelId,
    ...result,
  });
}

// New photos are checked by `onPhotoUploaded` at the same time, so wait a little for the result.
async function withCheckedPhoto(report: ReportSummary, waitMs: number): Promise<ReportSummary> {
  const path = pathOfUrl(report.photoUrl);
  const deadline = Date.now() + waitMs;
  for (;;) {
    if (await isCleared(path)) return report;
    if (Date.now() >= deadline) return {...report, photoUrl: null};
    await new Promise((resolve) => setTimeout(resolve, 1_500));
  }
}

export const onReportCreated = onDocumentCreated(
  {document: "reports/{reportId}", region: TRIGGER_REGION},
  async (event) => {
    const found = readReport(event.params.reportId, event.data?.data());
    if (!found || found.status !== "open") return;
    const report = await withCheckedPhoto(found, 15_000);
    await notifyCity(report, (lang) => newReportContent(report, lang));
  },
);

export const onReportResolved = onDocumentUpdated(
  {document: "reports/{reportId}", region: TRIGGER_REGION},
  async (event) => {
    const before = event.data?.before.data();
    const after = event.data?.after.data();
    if (!becameResolved(before, after)) return;
    const found = readReport(event.params.reportId, after);
    if (!found) return;
    const report = await withCheckedPhoto(found, 0);
    await notifyCity(report, (lang) => resolvedContent(report, lang));
  },
);

export const reverseGeocode = onCall(async (request) => {
  requireAuth(request);
  const lat = readCoordinate(request.data, "lat", 90);
  const lng = readCoordinate(request.data, "lng", 180);

  const query = new URLSearchParams({
    latlng: `${lat},${lng}`,
    language: LANGUAGE,
    key: placesApiKey.value(),
  });
  try {
    const response = await fetch(
      `https://maps.googleapis.com/maps/api/geocode/json?${query}`,
      {signal: AbortSignal.timeout(10_000)},
    );
    const body = (await response.json()) as Record<string, unknown>;
    if (body.status !== "OK" && body.status !== "ZERO_RESULTS") {
      logger.warn("Geocoding API error", {status: body.status, error: body.error_message});
      return {label: null, city: null};
    }
    return parseReverseGeocode(body);
  } catch (error) {
    logger.error("Geocoding API unreachable", error);
    return {label: null, city: null};
  }
});

const RECENT_LOGIN_SECONDS = 5 * 60;

export const deleteAccount = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "Please sign in again.");
  }
  const uid = request.auth.uid;
  const token = request.auth.token;
  const signedInAgo = Date.now() / 1000 - token.auth_time;
  if (token.firebase.sign_in_provider === "password" && signedInAgo > RECENT_LOGIN_SECONDS) {
    throw new HttpsError("failed-precondition", "Please confirm your password again.");
  }
  try {
    await deleteUserData(uid);
  } catch (error) {
    logger.error("Account deletion failed", {uid, error});
    throw new HttpsError("internal", "Couldn't delete your account. Please try again.");
  }
  logger.info("Account deleted", {uid});
  return {deleted: true};
});

async function deleteUserData(uid: string): Promise<void> {
  const db = getFirestore();
  for (const name of ["reports", "pets"]) {
    const owned = await db.collection(name).where("ownerId", "==", uid).get();
    for (const group of chunk(owned.docs, 400)) {
      const batch = db.batch();
      group.forEach((doc) => batch.delete(doc.ref));
      await batch.commit();
    }
  }
  const cases = await db.collection("supportCases").where("userId", "==", uid).get();
  for (const doc of cases.docs) await db.recursiveDelete(doc.ref);
  await db.recursiveDelete(db.collection("users").doc(uid));
  await deleteModerationData(uid);
  await deletePointsData(uid);
  await deleteEmergencyData(uid);

  const bucket = getStorage().bucket();
  await Promise.all(
    ["reports", "pets"].map((folder) =>
      bucket.deleteFiles({prefix: `${folder}/${uid}/`}),
    ),
  );

  await getAuth().deleteUser(uid).catch((error) => {
    if (error?.code !== "auth/user-not-found") throw error;
  });
}

// Admins can manage ordinary users and support staff, never themselves or other admins.
async function requireAdminTarget(request: CallableRequest): Promise<string> {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "Please sign in again.");
  }
  const db = getFirestore();
  const caller = await db.collection("users").doc(request.auth.uid).get();
  if (caller.get("role") !== "admin") {
    throw new HttpsError("permission-denied", "Only admins can do this.");
  }
  const uid = readString(request.data, "uid", {min: 1, max: 128, pattern: SAFE_ID_PATTERN});
  if (uid === request.auth.uid) {
    throw new HttpsError("failed-precondition", "You can't change your own account here.");
  }
  const target = await db.collection("users").doc(uid).get();
  if (target.get("role") === "admin") {
    throw new HttpsError("permission-denied", "Admins can't be changed from the app.");
  }
  return uid;
}

const HIDDEN_BY_DISABLE = "disable";

export const adminSetUserDisabled = onCall(async (request) => {
  const uid = await requireAdminTarget(request);
  const disabled = (request.data as {disabled?: unknown} | null)?.disabled;
  if (typeof disabled !== "boolean") {
    throw new HttpsError("invalid-argument", "Missing disabled flag.");
  }
  const db = getFirestore();

  await getAuth().updateUser(uid, {disabled});
  if (disabled) await getAuth().revokeRefreshTokens(uid);
  await db.collection("users").doc(uid).set(
    {disabled, updatedAt: FieldValue.serverTimestamp()},
    {merge: true},
  );

  // Disabling hides the user's open reports; enabling brings back only those.
  const reports = disabled ?
    await db.collection("reports").where("ownerId", "==", uid).where("status", "==", "open").get() :
    await db.collection("reports").where("ownerId", "==", uid).where("hiddenBy", "==", HIDDEN_BY_DISABLE).get();
  for (const group of chunk(reports.docs, 400)) {
    const batch = db.batch();
    group.forEach((doc) =>
      batch.update(doc.ref, disabled ?
        {status: "hidden", hiddenBy: HIDDEN_BY_DISABLE, updatedAt: FieldValue.serverTimestamp()} :
        {status: "open", hiddenBy: FieldValue.delete(), updatedAt: FieldValue.serverTimestamp()}),
    );
    await batch.commit();
  }

  logger.info("User disabled flag changed", {
    uid,
    disabled,
    by: request.auth?.uid,
    reports: reports.size,
  });
  return {disabled};
});

export const adminDeleteUser = onCall(async (request) => {
  const uid = await requireAdminTarget(request);
  try {
    await deleteUserData(uid);
  } catch (error) {
    logger.error("Admin account deletion failed", {uid, error});
    throw new HttpsError("internal", "Couldn't delete this account. Please try again.");
  }
  logger.info("Account deleted by admin", {uid, by: request.auth?.uid});
  return {deleted: true};
});

// Keeps the search fields and home geohash current and frees the cases of removed staff.
export const onUserWritten = onDocumentWritten(
  {document: "users/{uid}", region: TRIGGER_REGION},
  async (event) => {
    const before = event.data?.before.data();
    const after = event.data?.after.data();
    const uid = event.params.uid;

    const wasStaff = before?.role === "support" || before?.role === "admin";
    const isStaff = after?.role === "support" || after?.role === "admin";
    if (wasStaff && !isStaff) {
      const released = await releaseCasesOf(uid);
      logger.info("Staff removed, cases back in the queue", {uid, released});
    }

    if (!after) return;
    const update: Record<string, unknown> = {...searchFieldsOf(after)};
    const geohash = homeGeohashOf(after);
    if (geohash && after.homeGeohash !== geohash) update.homeGeohash = geohash;
    if (Object.keys(update).length > 0) await event.data!.after.ref.update(update);
  },
);

export * from "./supportFunctions";
export {moderatePhoto, moderationSweep, onPhotoUploaded} from "./moderationFunctions";
export {
  adminAdjustPoints,
  adminReviewReferral,
  claimDailyTask,
  getInviteCode,
  pointsSweep,
  redeemInviteCode,
  registerVisit,
  submitFeedback,
} from "./pointsFunctions";
export {emergencySweep, onEmergencyCreated, seedTestContacts, updateEmergency} from "./emergencyFunctions";
