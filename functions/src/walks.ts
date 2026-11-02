type Json = Record<string, unknown>;

export const WALK_GROUPS = {
  dogParks: ["dog_park"],
  parks: ["park", "national_park", "state_park"],
  green: ["garden", "botanical_garden"],
  trails: ["hiking_area"],
} as const;

export type WalkGroup = keyof typeof WALK_GROUPS;

export const GROUP_NAMES = Object.keys(WALK_GROUPS) as WalkGroup[];

export const RADIUS_OPTIONS_KM = [1, 3, 5, 10, 25];

export const LANGUAGES = ["en", "it", "de", "fr", "es", "pt", "ru", "zh", "ar", "hi"];

export interface WalksConfig {
  enabled: boolean;
  defaultRadiusKm: number;
  groups: Record<WalkGroup, boolean>;
  hiddenPlaceIds: string[];
  dailySearches: number;
  dailyDetails: number;
}

export const DEFAULT_WALKS: WalksConfig = {
  enabled: false,
  defaultRadiusKm: 5,
  groups: {dogParks: true, parks: true, green: true, trails: true},
  hiddenPlaceIds: [],
  dailySearches: 40,
  dailyDetails: 60,
};

function intIn(value: unknown, min: number, max: number, fallback: number): number {
  return typeof value === "number" && Number.isInteger(value) && value >= min && value <= max ?
    value :
    fallback;
}

export function walksConfigOf(data: Json | undefined): WalksConfig {
  const groups = (data?.groups ?? {}) as Json;
  return {
    enabled: data?.enabled === true,
    defaultRadiusKm: RADIUS_OPTIONS_KM.includes(data?.defaultRadiusKm as number) ?
      (data!.defaultRadiusKm as number) :
      DEFAULT_WALKS.defaultRadiusKm,
    groups: Object.fromEntries(
      GROUP_NAMES.map((g) => [g, groups[g] !== false]),
    ) as Record<WalkGroup, boolean>,
    hiddenPlaceIds: Array.isArray(data?.hiddenPlaceIds) ?
      (data!.hiddenPlaceIds as unknown[]).filter((id): id is string => typeof id === "string") :
      [],
    dailySearches: intIn(data?.dailySearches, 1, 1000, DEFAULT_WALKS.dailySearches),
    dailyDetails: intIn(data?.dailyDetails, 1, 1000, DEFAULT_WALKS.dailyDetails),
  };
}

// Dog parks get their own search, so nearby ordinary parks never push them out
// of Google's 20-result limit.
export function searchTypeSets(config: WalksConfig): string[][] {
  const sets: string[][] = [];
  if (config.groups.dogParks) sets.push([...WALK_GROUPS.dogParks]);
  const others = GROUP_NAMES
    .filter((g) => g !== "dogParks" && config.groups[g])
    .flatMap((g) => [...WALK_GROUPS[g]]);
  if (others.length > 0) sets.push(others);
  return sets;
}

export function nearbyBody(
  lat: number,
  lng: number,
  radiusKm: number,
  types: string[],
  language: string,
): Json {
  return {
    includedTypes: types,
    maxResultCount: 20,
    rankPreference: "DISTANCE",
    languageCode: language,
    locationRestriction: {
      circle: {center: {latitude: lat, longitude: lng}, radius: radiusKm * 1000},
    },
  };
}

export const NEARBY_FIELDS = [
  "places.id",
  "places.displayName",
  "places.formattedAddress",
  "places.location",
  "places.primaryType",
  "places.types",
].join(",");

export const DETAIL_FIELDS = [
  "id",
  "displayName",
  "formattedAddress",
  "location",
  "rating",
  "userRatingCount",
  "currentOpeningHours.openNow",
  "regularOpeningHours.weekdayDescriptions",
  "nationalPhoneNumber",
  "websiteUri",
  "googleMapsUri",
  "allowsDogs",
  "photos",
].join(",");

export interface WalkPlace {
  id: string;
  name: string;
  address: string;
  lat: number;
  lng: number;
  group: WalkGroup;
}

export function groupOf(types: string[]): WalkGroup | null {
  for (const g of GROUP_NAMES) {
    if (types.some((t) => (WALK_GROUPS[g] as readonly string[]).includes(t))) return g;
  }
  return null;
}

function text(value: unknown): string {
  if (typeof value === "string") return value;
  const t = (value as Json | null | undefined)?.text;
  return typeof t === "string" ? t : "";
}

function placeOf(raw: Json): WalkPlace | null {
  const id = raw.id;
  const loc = raw.location as Json | undefined;
  const lat = loc?.latitude;
  const lng = loc?.longitude;
  if (typeof id !== "string" || typeof lat !== "number" || typeof lng !== "number") return null;
  const types = [
    ...(typeof raw.primaryType === "string" ? [raw.primaryType] : []),
    ...(Array.isArray(raw.types) ? (raw.types as unknown[]).filter((t): t is string => typeof t === "string") : []),
  ];
  const group = groupOf(types);
  if (!group) return null;
  return {id, name: text(raw.displayName), address: text(raw.formattedAddress), lat, lng, group};
}

// Merges the searches, drops places the admin hid and keeps each place once.
export function mergePlaces(bodies: Json[], hidden: string[]): WalkPlace[] {
  const hide = new Set(hidden);
  const seen = new Map<string, WalkPlace>();
  for (const body of bodies) {
    for (const raw of (Array.isArray(body.places) ? body.places : []) as Json[]) {
      const place = placeOf(raw);
      if (place && !hide.has(place.id) && !seen.has(place.id)) seen.set(place.id, place);
    }
  }
  return [...seen.values()];
}

export interface WalkDetails {
  id: string;
  name: string;
  address: string;
  lat: number | null;
  lng: number | null;
  rating: number | null;
  ratingCount: number | null;
  openNow: boolean | null;
  hours: string[];
  phone: string;
  website: string;
  mapsUrl: string;
  allowsDogs: boolean | null;
  photoName: string | null;
  photoAuthor: string;
}

export function parseDetails(raw: Json): WalkDetails {
  const loc = raw.location as Json | undefined;
  const photo = (Array.isArray(raw.photos) ? raw.photos[0] : undefined) as Json | undefined;
  const author = (Array.isArray(photo?.authorAttributions) ? photo!.authorAttributions[0] : undefined) as
    | Json
    | undefined;
  const num = (v: unknown) => (typeof v === "number" ? v : null);
  const hours = (raw.regularOpeningHours as Json | undefined)?.weekdayDescriptions;
  return {
    id: typeof raw.id === "string" ? raw.id : "",
    name: text(raw.displayName),
    address: text(raw.formattedAddress),
    lat: num(loc?.latitude),
    lng: num(loc?.longitude),
    rating: num(raw.rating),
    ratingCount: num(raw.userRatingCount),
    openNow: typeof (raw.currentOpeningHours as Json | undefined)?.openNow === "boolean" ?
      ((raw.currentOpeningHours as Json).openNow as boolean) :
      null,
    hours: Array.isArray(hours) ? hours.filter((h): h is string => typeof h === "string") : [],
    phone: typeof raw.nationalPhoneNumber === "string" ? raw.nationalPhoneNumber : "",
    website: typeof raw.websiteUri === "string" ? raw.websiteUri : "",
    mapsUrl: typeof raw.googleMapsUri === "string" ? raw.googleMapsUri : "",
    allowsDogs: typeof raw.allowsDogs === "boolean" ? raw.allowsDogs : null,
    photoName: typeof photo?.name === "string" ? photo.name : null,
    photoAuthor: typeof author?.displayName === "string" ? author.displayName : "",
  };
}

// Searches from points about 1 km apart share one cache entry.
export function cacheKey(lat: number, lng: number, radiusKm: number, language: string, sets: string[][]): string {
  return [lat.toFixed(2), lng.toFixed(2), radiusKm, language, sets.map((s) => s.join("+")).join("|")].join(",");
}

export function roundedCenter(lat: number, lng: number): [number, number] {
  return [Math.round(lat * 100) / 100, Math.round(lng * 100) / 100];
}

export interface Usage {
  day: string;
  searches: number;
  details: number;
}

// Returns the usage after one more search or detail view, or null when the
// daily limit is already reached.
export function nextUsage(
  previous: Json | undefined,
  day: string,
  kind: "searches" | "details",
  limit: number,
): Usage | null {
  const base: Usage = previous?.day === day ?
    {
      day,
      searches: typeof previous.searches === "number" ? previous.searches : 0,
      details: typeof previous.details === "number" ? previous.details : 0,
    } :
    {day, searches: 0, details: 0};
  if (base[kind] >= limit) return null;
  return {...base, [kind]: base[kind] + 1};
}
