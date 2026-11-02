import "./options";

import {getFirestore} from "firebase-admin/firestore";
import {HttpsError, onCall, type CallableRequest} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";
import {defineString} from "firebase-functions/params";

import {SAFE_ID_PATTERN, readString} from "./places";
import {dayKey} from "./points";
import {
  DETAIL_FIELDS,
  LANGUAGES,
  NEARBY_FIELDS,
  RADIUS_OPTIONS_KM,
  cacheKey,
  mergePlaces,
  nearbyBody,
  nextUsage,
  parseDetails,
  roundedCenter,
  searchTypeSets,
  walksConfigOf,
  type WalkDetails,
  type WalkPlace,
  type WalksConfig,
} from "./walks";

const placesApiKey = defineString("PLACES_API_KEY");
const PLACES_URL = "https://places.googleapis.com/v1";
const CACHE_MS = 30 * 60 * 1000;
const CACHE_SIZE = 300;

const db = () => getFirestore();

// Kept only in this server instance's memory, for a short time.
const searchCache = new Map<string, {at: number; places: WalkPlace[]}>();
const detailCache = new Map<string, {at: number; details: WalkDetails & {photoUrl: string | null}}>();

function remember<T>(cache: Map<string, {at: number} & T>, key: string, value: {at: number} & T): void {
  if (cache.size >= CACHE_SIZE) cache.delete(cache.keys().next().value!);
  cache.set(key, value);
}

function requireUid(request: CallableRequest): string {
  if (!request.auth) throw new HttpsError("unauthenticated", "Please sign in again.");
  return request.auth.uid;
}

// Admins can try the section before it's switched on for users.
async function requireOpen(uid: string, config: WalksConfig): Promise<void> {
  if (config.enabled) return;
  const role = (await db().collection("users").doc(uid).get()).get("role");
  if (role !== "admin") throw new HttpsError("failed-precondition", "Places to walk is off.");
}

async function loadConfig(): Promise<WalksConfig> {
  return walksConfigOf((await db().collection("config").doc("walks").get()).data());
}

function readNumber(data: unknown, field: string, min: number, max: number): number {
  const value = (data as Record<string, unknown> | null)?.[field];
  if (typeof value !== "number" || !Number.isFinite(value) || value < min || value > max) {
    throw new HttpsError("invalid-argument", `"${field}" is not valid.`);
  }
  return value;
}

function readLanguage(data: unknown): string {
  const value = (data as Record<string, unknown> | null)?.language;
  return typeof value === "string" && LANGUAGES.includes(value) ? value : "it";
}

async function countUse(uid: string, kind: "searches" | "details", limit: number): Promise<void> {
  const ref = db().collection("walkUsage").doc(uid);
  const allowed = await db().runTransaction(async (tx) => {
    const next = nextUsage((await tx.get(ref)).data(), dayKey(Date.now()), kind, limit);
    if (next) tx.set(ref, next);
    return next !== null;
  });
  if (!allowed) {
    throw new HttpsError("resource-exhausted", "Daily limit reached. Please try again tomorrow.");
  }
}

async function callPlaces(
  path: string,
  init: {method: "GET" | "POST"; body?: string; fieldMask?: string},
): Promise<Record<string, unknown>> {
  let response: Response;
  try {
    response = await fetch(`${PLACES_URL}${path}`, {
      method: init.method,
      body: init.body,
      headers: {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": placesApiKey.value(),
        ...(init.fieldMask ? {"X-Goog-FieldMask": init.fieldMask} : {}),
      },
      signal: AbortSignal.timeout(10_000),
    });
  } catch (error) {
    logger.error("Places API unreachable", error);
    throw new HttpsError("unavailable", "Places search is temporarily unavailable.");
  }
  const body = (await response.json().catch(() => ({}))) as Record<string, unknown>;
  if (!response.ok) {
    logger.error("Places API error", {path, status: response.status, error: body.error});
    throw new HttpsError("unavailable", "Places search is temporarily unavailable.");
  }
  return body;
}

export const findWalkPlaces = onCall(async (request) => {
  const uid = requireUid(request);
  const lat = readNumber(request.data, "lat", -90, 90);
  const lng = readNumber(request.data, "lng", -180, 180);
  const radiusKm = readNumber(request.data, "radiusKm", 1, 25);
  if (!RADIUS_OPTIONS_KM.includes(radiusKm)) {
    throw new HttpsError("invalid-argument", "\"radiusKm\" is not valid.");
  }
  const language = readLanguage(request.data);
  const config = await loadConfig();
  await requireOpen(uid, config);

  const sets = searchTypeSets(config);
  if (sets.length === 0) return {places: []};
  const key = cacheKey(lat, lng, radiusKm, language, sets);
  const hit = searchCache.get(key);
  let places: WalkPlace[];
  if (hit && Date.now() - hit.at < CACHE_MS) {
    places = hit.places;
  } else {
    await countUse(uid, "searches", config.dailySearches);
    const [cLat, cLng] = roundedCenter(lat, lng);
    const bodies = await Promise.all(
      sets.map((types) =>
        callPlaces("/places:searchNearby", {
          method: "POST",
          body: JSON.stringify(nearbyBody(cLat, cLng, radiusKm, types, language)),
          fieldMask: NEARBY_FIELDS,
        }),
      ),
    );
    places = mergePlaces(bodies, []);
    remember(searchCache, key, {at: Date.now(), places});
    logger.info("Walk places searched", {radiusKm, found: places.length, searches: sets.length});
  }
  const hidden = new Set(config.hiddenPlaceIds);
  return {places: places.filter((p) => !hidden.has(p.id))};
});

export const walkPlaceDetails = onCall(async (request) => {
  const uid = requireUid(request);
  const placeId = readString(request.data, "placeId", {min: 3, max: 300, pattern: SAFE_ID_PATTERN});
  const language = readLanguage(request.data);
  const config = await loadConfig();
  await requireOpen(uid, config);

  const key = `${placeId},${language}`;
  const hit = detailCache.get(key);
  if (hit && Date.now() - hit.at < CACHE_MS) return hit.details;

  await countUse(uid, "details", config.dailyDetails);
  const details = parseDetails(
    await callPlaces(`/places/${placeId}?languageCode=${language}`, {method: "GET", fieldMask: DETAIL_FIELDS}),
  );
  let photoUrl: string | null = null;
  if (details.photoName) {
    try {
      const media = await callPlaces(
        `/${details.photoName}/media?maxWidthPx=900&skipHttpRedirect=true`,
        {method: "GET"},
      );
      photoUrl = typeof media.photoUri === "string" ? media.photoUri : null;
    } catch {
      photoUrl = null;
    }
  }
  const result = {...details, photoUrl};
  remember(detailCache, key, {at: Date.now(), details: result});
  return result;
});
