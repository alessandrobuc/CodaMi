import {HttpsError, onCall, type CallableRequest} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";
import {setGlobalOptions} from "firebase-functions/options";
import {defineString} from "firebase-functions/params";

import {
  SAFE_ID_PATTERN,
  parseCityDetails,
  parseSuggestions,
  readString,
} from "./places";

const placesApiKey = defineString("PLACES_API_KEY");

const PLACES_URL = "https://places.googleapis.com/v1";
const ITALY_BIAS = {
  rectangle: {
    low: {latitude: 35.4, longitude: 6.6},
    high: {latitude: 47.1, longitude: 18.6},
  },
};
const LANGUAGE = "it";

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
