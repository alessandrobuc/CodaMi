import {MESSAGES, type MessageKey} from "./messages";

type Json = Record<string, unknown>;

export type NotificationKind = "new_report" | "report_resolved";

export interface ReportSummary {
  id: string;
  ownerId: string;
  type: "lost" | "found";
  petName: string;
  city: string;
  cityKey: string;
  placeDetail: string | null;
  photoUrl: string | null;
  status: string;
}

export interface NotificationContent {
  kind: NotificationKind;
  title: string;
  body: string;
}

// Same keys as `notificationPrefs` on the user profile (see notification_prefs.dart).
export type AlertType = "lost" | "found" | "resolved";

export const DEFAULT_CHANNEL = "codami_alerts";
const BUNDLED_SOUNDS = new Set(["chime", "bell", "bright", "soft"]);
const CHANNEL_PATTERN = /^[a-z]+_\d{1,16}$/;

export interface PushSettings {
  enabled: boolean;
  channelId: string;
  // null means silent.
  iosSound: string | null;
}

export function alertTypeOf(kind: NotificationKind, reportType: "lost" | "found"): AlertType {
  return kind === "report_resolved" ? "resolved" : reportType;
}

export function pushSettingsOf(prefs: unknown, type: AlertType): PushSettings {
  const entry = typeof prefs === "object" && prefs !== null ?
    (prefs as Json)[type] :
    undefined;
  const data = typeof entry === "object" && entry !== null ? entry as Json : {};
  const channel = data.channel;
  const value = data.soundValue;
  let iosSound: string | null = "default";
  if (data.sound === "silent") iosSound = null;
  if (data.sound === "bundled" && typeof value === "string" && BUNDLED_SOUNDS.has(value)) {
    iosSound = `${value}.wav`;
  }
  return {
    enabled: data.enabled !== false,
    channelId: typeof channel === "string" && CHANNEL_PATTERN.test(channel) ?
      channel :
      DEFAULT_CHANNEL,
    iosSound,
  };
}

export function readReport(id: string, data: Json | undefined): ReportSummary | null {
  if (!data) return null;
  const text = (key: string) =>
    typeof data[key] === "string" && (data[key] as string).trim()
      ? (data[key] as string).trim()
      : null;
  const ownerId = text("ownerId");
  const cityKey = text("cityKey");
  if (!ownerId || !cityKey) return null;
  const photos = Array.isArray(data.photoUrls) ? data.photoUrls : [];
  return {
    id,
    ownerId,
    type: data.type === "found" ? "found" : "lost",
    petName: text("petName") ?? "A pet",
    city: text("city") ?? "",
    cityKey,
    placeDetail: text("placeDetail"),
    photoUrl: typeof photos[0] === "string" ? photos[0] : null,
    status: text("status") ?? "open",
  };
}

export function languageOf(value: unknown): string {
  return typeof value === "string" && value in MESSAGES ? value : "en";
}

function text(lang: string, key: MessageKey, vars: Record<string, string>): string {
  return MESSAGES[languageOf(lang)][key].replace(
    /\{(\w+)\}/g,
    (match, name: string) => vars[name] ?? match,
  );
}

export function newReportContent(report: ReportSummary, lang = "en"): NotificationContent {
  const vars = {
    pet: report.petName,
    city: report.city,
    street: report.placeDetail ?? "",
  };
  const near = report.placeDetail !== null;
  return report.type === "lost"
    ? {
      kind: "new_report",
      title: text(lang, "notifLostTitle", vars),
      body: text(lang, near ? "notifLostBodyNear" : "notifLostBodyIn", vars),
    }
    : {
      kind: "new_report",
      title: text(lang, "notifFoundTitle", vars),
      body: text(lang, near ? "notifFoundBodyNear" : "notifFoundBodyIn", vars),
    };
}

export function resolvedContent(report: ReportSummary, lang = "en"): NotificationContent {
  const vars = {pet: report.petName, city: report.city};
  return report.type === "lost"
    ? {
      kind: "report_resolved",
      title: text(lang, "notifBackHomeTitle", vars),
      body: text(lang, "notifBackHomeBody", vars),
    }
    : {
      kind: "report_resolved",
      title: text(lang, "notifReunitedTitle", vars),
      body: text(lang, "notifReunitedBody", vars),
    };
}

export function becameResolved(before: Json | undefined, after: Json | undefined): boolean {
  return before?.status === "open" && after?.status === "resolved";
}

export function chunk<T>(items: T[], size: number): T[][] {
  const out: T[][] = [];
  for (let i = 0; i < items.length; i += size) out.push(items.slice(i, i + size));
  return out;
}
