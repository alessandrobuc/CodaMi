import {distanceBetween} from "geofire-common";

type Json = Record<string, unknown>;

export const EMERGENCY_TYPES = ["injured", "danger", "abandoned", "urgent_found", "intervention", "other"] as const;
export const EMERGENCY_STATUSES = ["open", "helping", "resolved", "closed", "false_alarm"] as const;
export const CONTACT_KINDS = ["vet", "association", "public_service", "other"] as const;
export const ACTIVE_STATUSES = ["open", "helping"] as const;

export type EmergencyType = (typeof EMERGENCY_TYPES)[number];
export type EmergencyStatus = (typeof EMERGENCY_STATUSES)[number];
export type ContactKind = (typeof CONTACT_KINDS)[number];

export interface EmergencyConfig {
  // Users are alerted in growing circles until enough people are reached.
  ringsKm: number[];
  minRecipients: number;
  maxRecipients: number;
  autoCloseHours: number;
  defaultAreaKm: number;
  maxSuggested: number;
  weightRecommended: number;
  weightVerified: number;
  weight24h: number;
  weightPerKm: number;
  emailEnabled: boolean;
}

export const DEFAULT_EMERGENCY_CONFIG: EmergencyConfig = {
  ringsKm: [5, 10, 25],
  minRecipients: 20,
  maxRecipients: 300,
  autoCloseHours: 72,
  defaultAreaKm: 30,
  maxSuggested: 5,
  weightRecommended: 20,
  weightVerified: 10,
  weight24h: 5,
  weightPerKm: 1,
  emailEnabled: false,
};

const LIMITS: Record<Exclude<keyof EmergencyConfig, "ringsKm" | "emailEnabled">, [number, number]> = {
  minRecipients: [1, 10_000],
  maxRecipients: [1, 10_000],
  autoCloseHours: [1, 24 * 30],
  defaultAreaKm: [1, 500],
  maxSuggested: [1, 20],
  weightRecommended: [0, 1000],
  weightVerified: [0, 1000],
  weight24h: [0, 1000],
  weightPerKm: [0, 100],
};

function numberIn(value: unknown, [min, max]: [number, number]): number | null {
  return typeof value === "number" && Number.isFinite(value) && value >= min && value <= max ? value : null;
}

// Read from `config/emergency`, editable in the admin panel.
export function emergencyConfigOf(data: Json | undefined): EmergencyConfig {
  const config = {...DEFAULT_EMERGENCY_CONFIG};
  for (const [key, range] of Object.entries(LIMITS) as [keyof typeof LIMITS, [number, number]][]) {
    config[key] = numberIn(data?.[key], range) ?? DEFAULT_EMERGENCY_CONFIG[key];
  }
  const rings = Array.isArray(data?.ringsKm) ?
    (data.ringsKm as unknown[]).map((r) => numberIn(r, [0.5, 500])).filter((r): r is number => r !== null) :
    [];
  config.ringsKm = rings.length > 0 ? [...new Set(rings)].sort((a, b) => a - b).slice(0, 6) : DEFAULT_EMERGENCY_CONFIG.ringsKm;
  config.maxRecipients = Math.max(config.maxRecipients, config.minRecipients);
  config.emailEnabled = data?.emailEnabled === true;
  return config;
}

export interface Contact {
  id: string;
  name: string;
  kind: ContactKind;
  phones: string[];
  email: string | null;
  address: string | null;
  lat: number;
  lng: number;
  areaKm: number | null;
  types: EmergencyType[];
  open24h: boolean;
  hours: string | null;
  verified: boolean;
  recommended: boolean;
  active: boolean;
  isTest: boolean;
}

function oneOf<T extends string>(values: readonly T[], value: unknown): T | null {
  return typeof value === "string" && (values as readonly string[]).includes(value) ? value as T : null;
}

function text(value: unknown, max: number): string | null {
  return typeof value === "string" && value.trim() ? value.trim().slice(0, max) : null;
}

export function readContact(id: string, data: Json | undefined): Contact | null {
  if (!data) return null;
  const lat = data.lat;
  const lng = data.lng;
  const name = text(data.name, 120);
  if (!name || typeof lat !== "number" || typeof lng !== "number") return null;
  const phones = Array.isArray(data.phones) ?
    data.phones.map((p) => text(p, 30)).filter((p): p is string => p !== null) :
    [];
  const types = Array.isArray(data.types) ?
    data.types.map((t) => oneOf(EMERGENCY_TYPES, t)).filter((t): t is EmergencyType => t !== null) :
    [];
  return {
    id,
    name,
    kind: oneOf(CONTACT_KINDS, data.kind) ?? "other",
    phones,
    email: text(data.email, 120),
    address: text(data.address, 200),
    lat,
    lng,
    areaKm: numberIn(data.areaKm, [0.5, 1000]),
    types,
    open24h: data.open24h === true,
    hours: text(data.hours, 200),
    verified: data.verified === true,
    recommended: data.recommended === true,
    active: data.active !== false,
    isTest: data.isTest === true,
  };
}

export interface RankedContact extends Contact {
  distanceKm: number;
  inArea: boolean;
  score: number;
}

// Nearest suitable contacts first; recommended and verified ones can come before nearer ones.
// With nobody covering the place, the nearest contacts are still shown so the user can call someone.
export function rankContacts(
  contacts: Contact[],
  type: EmergencyType,
  at: {lat: number; lng: number},
  config: EmergencyConfig,
): RankedContact[] {
  const ranked = contacts
    .filter((c) => c.active && (c.types.length === 0 || c.types.includes(type)))
    .map((c) => {
      const distanceKm = Math.round(distanceBetween([c.lat, c.lng], [at.lat, at.lng]) * 10) / 10;
      const score =
        (c.recommended ? config.weightRecommended : 0) +
        (c.verified ? config.weightVerified : 0) +
        (c.open24h ? config.weight24h : 0) -
        distanceKm * config.weightPerKm;
      return {...c, distanceKm, inArea: distanceKm <= (c.areaKm ?? config.defaultAreaKm), score};
    });
  const inArea = ranked.filter((c) => c.inArea).sort((a, b) => b.score - a.score || a.distanceKm - b.distanceKm);
  if (inArea.length > 0) return inArea.slice(0, config.maxSuggested);
  return ranked.sort((a, b) => a.distanceKm - b.distanceKm).slice(0, config.maxSuggested);
}

// The smallest circle that reaches enough people, given how many live within each one.
export function ringFor(countsByRing: number[], config: EmergencyConfig): number {
  for (let i = 0; i < countsByRing.length; i++) {
    if (countsByRing[i] >= config.minRecipients) return i;
  }
  return config.ringsKm.length - 1;
}

export function isStale(lastActivityAt: number, now: number, config: EmergencyConfig): boolean {
  return now - lastActivityAt >= config.autoCloseHours * 3_600_000;
}

export type EmergencyAction = "helping" | "resolved" | "closed" | "false_alarm" | "reopen" | "report_false";

export interface Actor {
  isOwner: boolean;
  isStaff: boolean;
}

// Anyone can offer help or report a false alarm; only the reporter or staff close it.
export function nextStatus(
  status: EmergencyStatus,
  action: EmergencyAction,
  actor: Actor,
): EmergencyStatus | null {
  const active = (ACTIVE_STATUSES as readonly string[]).includes(status);
  switch (action) {
    case "helping":
      return status === "open" ? "helping" : null;
    case "resolved":
    case "closed":
      return active && (actor.isOwner || actor.isStaff) ? action : null;
    case "false_alarm":
      return status !== "false_alarm" && actor.isStaff ? "false_alarm" : null;
    case "reopen":
      return !active && (actor.isOwner || actor.isStaff) ? "open" : null;
    case "report_false":
      return status;
  }
}

export interface ContactSnapshot {
  id: string;
  name: string;
  kind: ContactKind;
  phones: string[];
  email: string | null;
  address: string | null;
  lat: number;
  lng: number;
  open24h: boolean;
  hours: string | null;
  verified: boolean;
  isTest: boolean;
  distanceKm: number;
  inArea: boolean;
}

// Saved on the emergency, so it shows the same list even if the directory changes later.
export function snapshotOf(contact: RankedContact): ContactSnapshot {
  return {
    id: contact.id,
    name: contact.name,
    kind: contact.kind,
    phones: contact.phones,
    email: contact.email,
    address: contact.address,
    lat: contact.lat,
    lng: contact.lng,
    open24h: contact.open24h,
    hours: contact.hours,
    verified: contact.verified,
    isTest: contact.isTest,
    distanceKm: contact.distanceKm,
    inArea: contact.inArea,
  };
}
