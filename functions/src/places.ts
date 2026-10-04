import {HttpsError} from "firebase-functions/https";

type Json = Record<string, unknown>;

export const SAFE_ID_PATTERN = /^[A-Za-z0-9_-]+$/;

export interface CitySuggestion {
  placeId: string;
  mainText: string;
  secondaryText: string;
}

export interface CityDetails {
  placeId: string;
  city: string;
  province: string | null;
  region: string | null;
  country: string;
  countryName: string;
  lat: number;
  lng: number;
}

export function readString(
  data: unknown,
  field: string,
  rules: {min: number; max: number; pattern?: RegExp},
): string {
  const value = (data as Json | null | undefined)?.[field];
  if (typeof value !== "string") {
    throw new HttpsError("invalid-argument", `"${field}" must be a string.`);
  }
  const trimmed = value.trim();
  if (
    trimmed.length < rules.min ||
    trimmed.length > rules.max ||
    (rules.pattern && !rules.pattern.test(trimmed))
  ) {
    throw new HttpsError("invalid-argument", `"${field}" is not valid.`);
  }
  return trimmed;
}

function textOf(value: unknown): string {
  const text = (value as Json | undefined)?.text;
  return typeof text === "string" ? text : "";
}

export function parseSuggestions(body: Json): CitySuggestion[] {
  const suggestions = Array.isArray(body.suggestions) ? body.suggestions : [];
  return suggestions.flatMap((suggestion) => {
    const prediction = (suggestion as Json)?.placePrediction as Json | undefined;
    if (!prediction || typeof prediction.placeId !== "string") return [];
    const format = (prediction.structuredFormat ?? {}) as Json;
    return [{
      placeId: prediction.placeId,
      mainText: textOf(format.mainText) || textOf(prediction.text),
      secondaryText: textOf(format.secondaryText),
    }];
  });
}

export function parseCityDetails(body: Json): CityDetails | null {
  const location = (body.location ?? {}) as Json;
  if (
    typeof location.latitude !== "number" ||
    typeof location.longitude !== "number"
  ) {
    return null;
  }

  const components = (
    Array.isArray(body.addressComponents) ? body.addressComponents : []
  ) as Json[];
  const find = (type: string) =>
    components.find((c) => Array.isArray(c.types) && c.types.includes(type));
  const read = (c: Json | undefined, key: "longText" | "shortText") =>
    typeof c?.[key] === "string" ? (c[key] as string) : null;

  const locality = find("locality") ?? find("administrative_area_level_3");
  const country = find("country");

  return {
    placeId: typeof body.id === "string" ? body.id : "",
    city: read(locality, "longText") ?? "",
    province: read(find("administrative_area_level_2"), "shortText"),
    region: read(find("administrative_area_level_1"), "longText"),
    country: (read(country, "shortText") ?? "").toUpperCase(),
    countryName: read(country, "longText") ?? "",
    lat: location.latitude,
    lng: location.longitude,
  };
}
