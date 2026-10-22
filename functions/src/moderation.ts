import {createHash} from "node:crypto";

type Json = Record<string, unknown>;

// Cloud Vision SafeSearch likelihoods, weakest first.
export const LIKELIHOODS = [
  "UNKNOWN",
  "VERY_UNLIKELY",
  "UNLIKELY",
  "POSSIBLE",
  "LIKELY",
  "VERY_LIKELY",
] as const;
export const CATEGORIES = ["adult", "racy", "violence", "medical", "spoof"] as const;
export const USER_PHOTO_FOLDERS = ["pets", "reports", "emergencies"] as const;
export const QUARANTINE_FOLDER = "quarantine";
export const PURGE_AFTER_DAYS = 7;
export const MAX_ATTEMPTS = 5;

export type Likelihood = (typeof LIKELIHOODS)[number];
export type Category = (typeof CATEGORIES)[number];
export type Scores = Record<Category, Likelihood>;
export type Result = "clear" | "review" | "blocked";

export interface ModerationLimits {
  blockAdult: Likelihood;
  reviewAdult: Likelihood;
  reviewRacy: Likelihood;
  reviewViolence: Likelihood;
}

// Photos of injured animals are legitimate, so violence is never blocked outright.
export const DEFAULT_MODERATION_LIMITS: ModerationLimits = {
  blockAdult: "VERY_LIKELY",
  reviewAdult: "POSSIBLE",
  reviewRacy: "LIKELY",
  reviewViolence: "VERY_LIKELY",
};

function rank(value: Likelihood): number {
  return LIKELIHOODS.indexOf(value);
}

function likelihoodOf(value: unknown): Likelihood | null {
  return typeof value === "string" && (LIKELIHOODS as readonly string[]).includes(value) ?
    value as Likelihood :
    null;
}

// Read from `config/moderation`, so limits can change without a deploy. "UNKNOWN" would flag everything.
export function moderationLimitsOf(data: Json | undefined): ModerationLimits {
  const pick = (key: keyof ModerationLimits) => {
    const value = likelihoodOf(data?.[key]);
    return value && value !== "UNKNOWN" ? value : DEFAULT_MODERATION_LIMITS[key];
  };
  return {
    blockAdult: pick("blockAdult"),
    reviewAdult: pick("reviewAdult"),
    reviewRacy: pick("reviewRacy"),
    reviewViolence: pick("reviewViolence"),
  };
}

export function readScores(annotation: unknown): Scores | null {
  if (typeof annotation !== "object" || annotation === null) return null;
  const data = annotation as Json;
  const scores = {} as Scores;
  for (const category of CATEGORIES) {
    scores[category] = likelihoodOf(data[category]) ?? "UNKNOWN";
  }
  return scores;
}

export interface Verdict {
  result: Result;
  reason: Category | null;
  level: Likelihood | null;
}

export function classify(scores: Scores, limits: ModerationLimits): Verdict {
  const reaches = (category: Category, limit: Likelihood) => rank(scores[category]) >= rank(limit);
  if (reaches("adult", limits.blockAdult)) {
    return {result: "blocked", reason: "adult", level: scores.adult};
  }
  const checks: [Category, Likelihood][] = [
    ["adult", limits.reviewAdult],
    ["racy", limits.reviewRacy],
    ["violence", limits.reviewViolence],
  ];
  for (const [category, limit] of checks) {
    if (reaches(category, limit)) return {result: "review", reason: category, level: scores[category]};
  }
  return {result: "clear", reason: null, level: null};
}

// `pets/{uid}/{petId}/{file}` or `reports/{uid}/{reportId}/{file}`, as written by the app.
export function photoOwnerOf(path: string): {folder: string; ownerId: string} | null {
  const parts = path.split("/");
  if (parts.length < 3 || parts.some((p) => p.length === 0)) return null;
  const [folder, ownerId] = parts;
  if (!(USER_PHOTO_FOLDERS as readonly string[]).includes(folder)) return null;
  return {folder, ownerId};
}

export function quarantinePathOf(path: string): string {
  return `${QUARANTINE_FOLDER}/${path}`;
}

export function checkIdOf(path: string): string {
  return createHash("sha256").update(path).digest("hex").slice(0, 40);
}

// Firebase download links look like `.../o/pets%2Fuid%2Fname.jpg?alt=media&token=...`.
export function pathOfUrl(url: unknown): string | null {
  if (typeof url !== "string") return null;
  const match = /\/o\/([^?#]+)/.exec(url);
  if (!match) return null;
  try {
    return decodeURIComponent(match[1]);
  } catch {
    return null;
  }
}

export function downloadUrlOf(bucket: string, path: string, tokens: unknown): string | null {
  const token = typeof tokens === "string" ? tokens.split(",")[0].trim() : "";
  if (!token) return null;
  return `https://firebasestorage.googleapis.com/v0/b/${bucket}/o/${encodeURIComponent(path)}?alt=media&token=${token}`;
}

export function withoutPath(urls: unknown, path: string): string[] | null {
  if (!Array.isArray(urls)) return null;
  const kept = urls.filter((url) => pathOfUrl(url) !== path);
  return kept.length === urls.length ? null : kept;
}
