import {initializeApp} from "firebase-admin/app";
import {FieldValue, getFirestore} from "firebase-admin/firestore";
import {getMessaging} from "firebase-admin/messaging";
import {onDocumentCreated, onDocumentUpdated} from "firebase-functions/firestore";
import {HttpsError, onCall, type CallableRequest} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";
import {setGlobalOptions} from "firebase-functions/options";
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
  becameResolved,
  chunk,
  newReportContent,
  readReport,
  resolvedContent,
  type NotificationContent,
  type ReportSummary,
} from "./notifications";

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

setGlobalOptions({region: "europe-west1", maxInstances: 10});

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
const INVALID_TOKEN_CODES = new Set([
  "messaging/registration-token-not-registered",
  "messaging/invalid-registration-token",
  "messaging/invalid-argument",
]);

async function notifyCity(
  report: ReportSummary,
  content: NotificationContent,
): Promise<void> {
  const db = getFirestore();
  const users = await db
    .collection("users")
    .where("cityKey", "==", report.cityKey)
    .get();
  const recipients = users.docs.filter((d) => d.id !== report.ownerId);
  if (recipients.length === 0) return;

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
        read: false,
        createdAt: FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
  }

  const tokens = recipients.flatMap((user) => {
    const list = user.get("fcmTokens");
    return Array.isArray(list) ?
      list.filter((t): t is string => typeof t === "string").map((token) => ({user, token})) :
      [];
  });

  for (const group of chunk(tokens, 500)) {
    const response = await getMessaging().sendEachForMulticast({
      tokens: group.map((t) => t.token),
      notification: {title: content.title, body: content.body},
      data: {reportId: report.id, kind: content.kind},
      android: {
        priority: "high",
        notification: {
          channelId: "codami_alerts",
          color: report.type === "lost" ? "#C2410C" : "#1F6F5B",
          ...(report.photoUrl ? {imageUrl: report.photoUrl} : {}),
        },
      },
      apns: {payload: {aps: {sound: "default"}}},
    });

    const stale = response.responses.flatMap((r, i) =>
      !r.success && INVALID_TOKEN_CODES.has(r.error?.code ?? "") ? [group[i]] : [],
    );
    await Promise.all(
      stale.map(({user, token}) =>
        user.ref.update({fcmTokens: FieldValue.arrayRemove(token)}),
      ),
    );
    logger.info("Report notification sent", {
      reportId: report.id,
      kind: content.kind,
      success: response.successCount,
      failed: response.failureCount,
      removedTokens: stale.length,
    });
  }
}

export const onReportCreated = onDocumentCreated(
  {document: "reports/{reportId}", region: TRIGGER_REGION},
  async (event) => {
    const report = readReport(event.params.reportId, event.data?.data());
    if (!report || report.status !== "open") return;
    await notifyCity(report, newReportContent(report));
  },
);

export const onReportResolved = onDocumentUpdated(
  {document: "reports/{reportId}", region: TRIGGER_REGION},
  async (event) => {
    const before = event.data?.before.data();
    const after = event.data?.after.data();
    if (!becameResolved(before, after)) return;
    const report = readReport(event.params.reportId, after);
    if (!report) return;
    await notifyCity(report, resolvedContent(report));
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
