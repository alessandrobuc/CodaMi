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

export interface StreetDetails {
  placeId: string;
  label: string;
  lat: number;
  lng: number;
}

const ADDRESS_TYPES = ["route", "street_address", "premise", "subpremise"];

export function normalizePlaceName(value: string): string {
  return value
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, " ")
    .trim();
}

export function mentionsCity(text: string, city: string): boolean {
  const target = normalizePlaceName(city);
  if (!target) return true;
  return ` ${normalizePlaceName(text)} `.includes(` ${target} `);
}

export function cityQuery(input: string, city: string): string {
  return mentionsCity(input, city) ? input : `${input}, ${city}`;
}

export function suggestionsInCity(
  suggestions: CitySuggestion[],
  city: string,
): CitySuggestion[] {
  return suggestions.filter(
    (s) => mentionsCity(s.secondaryText, city) || mentionsCity(s.mainText, city),
  );
}

export function placeLocality(body: Json): string | null {
  const components = (
    Array.isArray(body.addressComponents) ? body.addressComponents : []
  ) as Json[];
  const find = (type: string) =>
    components.find((c) => Array.isArray(c.types) && c.types.includes(type));
  const locality = find("locality") ?? find("administrative_area_level_3");
  return typeof locality?.longText === "string" ? locality.longText : null;
}

export function readCoordinate(data: unknown, field: string, limit: number): number {
  const value = (data as Json | null | undefined)?.[field];
  if (typeof value !== "number" || !Number.isFinite(value) || Math.abs(value) > limit) {
    throw new HttpsError("invalid-argument", `"${field}" is not valid.`);
  }
  return value;
}

export function parseStreetDetails(body: Json): StreetDetails | null {
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
  const route = components.find(
    (c) => Array.isArray(c.types) && c.types.includes("route"),
  );
  const street = typeof route?.longText === "string" ? route.longText : "";
  const name = textOf(body.displayName);
  const types = Array.isArray(body.types) ? (body.types as string[]) : [];
  const isAddress = types.some((t) => ADDRESS_TYPES.includes(t));

  const label = withoutHouseNumber(isAddress ? street || name : name || street);
  if (!label) return null;

  return {
    placeId: typeof body.id === "string" ? body.id : "",
    label,
    lat: location.latitude,
    lng: location.longitude,
  };
}

export function withoutHouseNumber(text: string): string {
  return text
    .replace(/[\s,]+(n\.?\s*)?\d+[a-zA-Z]?(\/\w+)?$/, "")
    .trim()
    .slice(0, 80);
}

export interface ReverseGeocode {
  label: string | null;
  city: string | null;
}

export function parseReverseGeocode(body: Json): ReverseGeocode {
  const results = (Array.isArray(body.results) ? body.results : []) as Json[];
  let label: string | null = null;
  let city: string | null = null;
  for (const result of results) {
    const components = (
      Array.isArray(result.address_components) ? result.address_components : []
    ) as Json[];
    const find = (type: string) =>
      components.find((c) => Array.isArray(c.types) && c.types.includes(type));
    const name = (c: Json | undefined) =>
      typeof c?.long_name === "string" ? c.long_name : null;
    label ??= name(find("route")) ?? name(find("park")) ?? name(find("point_of_interest"));
    city ??= name(find("locality")) ?? name(find("administrative_area_level_3"));
    if (label && city) break;
  }
  return {label: label ? withoutHouseNumber(label) || null : null, city};
}
