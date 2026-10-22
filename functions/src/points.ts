import {randomInt} from "node:crypto";

type Json = Record<string, unknown>;

// Every way to earn points. Future features add a name here and a value in `config/points`.
export const POINT_ACTIONS = [
  "daily_checkin",
  "daily_active",
  "streak_bonus",
  "referral_qualified",
  "referral_welcome",
  "level_bonus",
  "manual",
] as const;
export type PointAction = (typeof POINT_ACTIONS)[number];

export const DAILY_TASKS = ["checkin", "active"] as const;
export type DailyTask = (typeof DAILY_TASKS)[number];

export const LEVEL_IDS = ["supporter", "ambassador", "super_ambassador", "champion"] as const;
export type LevelId = (typeof LEVEL_IDS)[number];

export interface Level {
  id: LevelId;
  minFriends: number;
  bonus: number;
}

export interface PointsConfig {
  dailyCheckin: number;
  dailyActive: number;
  activeMinutes: number;
  streakDays: number;
  streakBonus: number;
  referralQualified: number;
  referralWelcome: number;
  qualifyDays: number;
  qualifyWithinDays: number;
  codeEntryDays: number;
  maxQualifiedPerDay: number;
  levels: Level[];
}

export const DEFAULT_POINTS_CONFIG: PointsConfig = {
  dailyCheckin: 5,
  dailyActive: 10,
  activeMinutes: 3,
  streakDays: 7,
  streakBonus: 25,
  referralQualified: 50,
  referralWelcome: 0,
  qualifyDays: 3,
  qualifyWithinDays: 14,
  codeEntryDays: 7,
  maxQualifiedPerDay: 10,
  levels: [
    {id: "supporter", minFriends: 1, bonus: 10},
    {id: "ambassador", minFriends: 5, bonus: 50},
    {id: "super_ambassador", minFriends: 15, bonus: 150},
    {id: "champion", minFriends: 30, bonus: 300},
  ],
};

// Limits keep a typo in the admin panel from breaking the system.
const LIMITS: Record<Exclude<keyof PointsConfig, "levels">, [number, number]> = {
  dailyCheckin: [0, 1000],
  dailyActive: [0, 1000],
  activeMinutes: [1, 120],
  streakDays: [2, 365],
  streakBonus: [0, 10_000],
  referralQualified: [0, 10_000],
  referralWelcome: [0, 10_000],
  qualifyDays: [1, 60],
  qualifyWithinDays: [1, 365],
  codeEntryDays: [1, 365],
  maxQualifiedPerDay: [1, 1000],
};

function intIn(value: unknown, [min, max]: [number, number]): number | null {
  return typeof value === "number" && Number.isInteger(value) && value >= min && value <= max ?
    value :
    null;
}

// Read from `config/points`, editable in the admin panel.
export function pointsConfigOf(data: Json | undefined): PointsConfig {
  const config = {...DEFAULT_POINTS_CONFIG};
  for (const [key, range] of Object.entries(LIMITS) as [keyof typeof LIMITS, [number, number]][]) {
    config[key] = intIn(data?.[key], range) ?? DEFAULT_POINTS_CONFIG[key];
  }
  const levels = data?.levels;
  config.levels = DEFAULT_POINTS_CONFIG.levels.map((level) => {
    const entry = typeof levels === "object" && levels !== null ? (levels as Json)[level.id] : undefined;
    const custom = typeof entry === "object" && entry !== null ? entry as Json : {};
    return {
      id: level.id,
      minFriends: intIn(custom.minFriends, [1, 100_000]) ?? level.minFriends,
      bonus: intIn(custom.bonus, [0, 100_000]) ?? level.bonus,
    };
  }).sort((a, b) => a.minFriends - b.minFriends);
  return config;
}

export function taskPoints(config: PointsConfig, task: DailyTask): number {
  return task === "checkin" ? config.dailyCheckin : config.dailyActive;
}

// Days are calendar days in Italy, where CodaMi runs.
export function dayKey(at: number): string {
  return new Intl.DateTimeFormat("en-CA", {
    timeZone: "Europe/Rome",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).format(new Date(at));
}

export function previousDay(day: string): string {
  const date = new Date(`${day}T12:00:00Z`);
  date.setUTCDate(date.getUTCDate() - 1);
  return date.toISOString().slice(0, 10);
}

export interface Streak {
  lastDay: string | null;
  count: number;
}

// The first claim of a day moves the streak; a missed day starts it again.
export function nextStreak(current: Streak, today: string): Streak {
  if (current.lastDay === today) return current;
  const count = current.lastDay === previousDay(today) ? current.count + 1 : 1;
  return {lastDay: today, count};
}

export function earnsStreakBonus(previous: Streak, next: Streak, config: PointsConfig): boolean {
  return next.lastDay !== previous.lastDay && next.count > 0 && next.count % config.streakDays === 0;
}

// Levels reached when the qualified friends go from `before` to `after`.
export function levelsReached(before: number, after: number, config: PointsConfig): Level[] {
  return config.levels.filter((level) => before < level.minFriends && after >= level.minFriends);
}

export function levelFor(friends: number, config: PointsConfig): LevelId | null {
  let current: LevelId | null = null;
  for (const level of config.levels) if (friends >= level.minFriends) current = level.id;
  return current;
}

// Without 0/O and 1/I, so codes are easy to read aloud and type.
const CODE_ALPHABET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
export const CODE_LENGTH = 6;

export function newInviteCode(): string {
  let code = "";
  for (let i = 0; i < CODE_LENGTH; i++) code += CODE_ALPHABET[randomInt(CODE_ALPHABET.length)];
  return code;
}

export function normalizeCode(value: unknown): string | null {
  if (typeof value !== "string") return null;
  const code = value.trim().toUpperCase();
  return code.length === CODE_LENGTH && [...code].every((c) => CODE_ALPHABET.includes(c)) ? code : null;
}

export type FraudFlag = "same_device_as_inviter" | "device_used_before" | "burst";

// Signals only send a referral to an admin; nothing is rejected automatically.
export function deviceFlags(
  installHash: string | null,
  inviterHashes: string[],
  usedByOtherInvitee: boolean,
): FraudFlag[] {
  const flags: FraudFlag[] = [];
  if (installHash && inviterHashes.includes(installHash)) flags.push("same_device_as_inviter");
  if (installHash && usedByOtherInvitee) flags.push("device_used_before");
  return flags;
}

export type ReferralStatus = "pending" | "qualified" | "review" | "rejected" | "expired";

export interface ReferralProgress {
  activeDays: number;
  hasCity: boolean;
  joinedAt: number;
  now: number;
}

export function referralOutcome(
  progress: ReferralProgress,
  config: PointsConfig,
): "wait" | "qualify" | "expire" {
  const deadline = progress.joinedAt + config.qualifyWithinDays * 86_400_000;
  if (progress.activeDays >= config.qualifyDays && progress.hasCity) {
    return progress.now <= deadline ? "qualify" : "expire";
  }
  return progress.now > deadline ? "expire" : "wait";
}
