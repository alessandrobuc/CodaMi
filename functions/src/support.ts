type Json = Record<string, unknown>;

export const CASE_KINDS = ["chat", "ticket"] as const;
export const CASE_CATEGORIES = ["account", "listing", "app", "other"] as const;
export const CASE_STATUSES = ["open", "in_progress", "waiting_user", "resolved", "closed"] as const;

export type CaseKind = (typeof CASE_KINDS)[number];
export type CaseCategory = (typeof CASE_CATEGORIES)[number];
export type CaseStatus = (typeof CASE_STATUSES)[number];
export type Sender = "user" | "staff";

export const FIRST_CASE_NUMBER = 1001;
export const MAX_ACTIVE_CASES = 3;
export const MESSAGE_MAX_LENGTH = 2000;
export const SUBJECT_MAX_LENGTH = 120;
export const PREVIEW_LENGTH = 140;
// Staff count as online while the admin side keeps sending heartbeats.
export const PRESENCE_TIMEOUT_MS = 5 * 60_000;

export function caseReference(number: number): string {
  return `CM-${number}`;
}

export function isActive(status: CaseStatus): boolean {
  return status !== "resolved" && status !== "closed";
}

export function oneOf<T extends string>(values: readonly T[], value: unknown): T | null {
  return typeof value === "string" && (values as readonly string[]).includes(value) ?
    value as T :
    null;
}

export function preview(text: string): string {
  const flat = text.replace(/\s+/g, " ").trim();
  return flat.length > PREVIEW_LENGTH ? `${flat.slice(0, PREVIEW_LENGTH - 1)}…` : flat;
}

export interface SupportLimits {
  chatReplyMinutes: number;
  ticketReplyHours: number;
  autoCloseDays: number;
}

export const DEFAULT_LIMITS: SupportLimits = {
  chatReplyMinutes: 5,
  ticketReplyHours: 24,
  autoCloseDays: 7,
};

// Read from `config/support`, so the client can change limits without a deploy.
export function limitsOf(data: Json | undefined): SupportLimits {
  const pick = (key: keyof SupportLimits, max: number) => {
    const value = data?.[key];
    return typeof value === "number" && value > 0 && value <= max ?
      value :
      DEFAULT_LIMITS[key];
  };
  return {
    chatReplyMinutes: pick("chatReplyMinutes", 24 * 60),
    ticketReplyHours: pick("ticketReplyHours", 30 * 24),
    autoCloseDays: pick("autoCloseDays", 365),
  };
}

export function replyLimitMs(kind: CaseKind, limits: SupportLimits): number {
  return kind === "chat" ?
    limits.chatReplyMinutes * 60_000 :
    limits.ticketReplyHours * 3_600_000;
}

export function isOverdue(
  kind: CaseKind,
  awaitingSince: number | null,
  now: number,
  limits: SupportLimits,
): boolean {
  return awaitingSince !== null && now - awaitingSince >= replyLimitMs(kind, limits);
}

export function shouldAutoClose(resolvedAt: number | null, now: number, limits: SupportLimits): boolean {
  return resolvedAt !== null && now - resolvedAt >= limits.autoCloseDays * 86_400_000;
}

export function secondsBetween(from: number | null, to: number): number {
  return from === null ? 0 : Math.max(0, Math.round((to - from) / 1000));
}

// The parts of a case the server logic needs, with times in milliseconds.
export interface CaseState {
  kind: CaseKind;
  status: CaseStatus;
  userId: string;
  assignedTo: string | null;
  awaitingSince: number | null;
  firstResponseAt: number | null;
  workStartedAt: number | null;
  resolvedAt: number | null;
}

export function millisOf(value: unknown): number | null {
  if (value instanceof Date) return value.getTime();
  if (typeof value === "object" && value !== null && "toMillis" in value) {
    return (value as {toMillis: () => number}).toMillis();
  }
  return null;
}

export function readCase(data: Json | undefined): CaseState | null {
  const status = oneOf(CASE_STATUSES, data?.status);
  const kind = oneOf(CASE_KINDS, data?.kind);
  const userId = data?.userId;
  if (!status || !kind || typeof userId !== "string") return null;
  return {
    kind,
    status,
    userId,
    assignedTo: typeof data?.assignedTo === "string" ? data.assignedTo : null,
    awaitingSince: millisOf(data?.awaitingSince),
    firstResponseAt: millisOf(data?.firstResponseAt),
    workStartedAt: millisOf(data?.workStartedAt),
    resolvedAt: millisOf(data?.resolvedAt),
  };
}

export interface MessageEffect {
  // Field values; `null` means the field is removed.
  update: Record<string, number | string | boolean | null>;
  // How long the user waited for this staff reply, if it answered them.
  responseSeconds: number | null;
  reopened: boolean;
}

// How a new message changes its case. Times in the update are milliseconds.
export function applyMessage(state: CaseState, by: Sender, at: number, text: string): MessageEffect {
  const update: MessageEffect["update"] = {
    lastMessageAt: at,
    lastMessageBy: by,
    lastMessageText: preview(text),
  };
  let responseSeconds: number | null = null;
  let reopened = false;

  if (by === "user") {
    update.lastUserMessageAt = at;
    if (state.awaitingSince === null) {
      update.awaitingStaff = true;
      update.awaitingSince = at;
    }
    if (state.status === "resolved") {
      reopened = true;
      update.status = state.assignedTo ? "in_progress" : "open";
      update.resolvedAt = null;
      if (state.assignedTo) update.workStartedAt = at;
    } else if (state.status === "waiting_user") {
      update.status = "in_progress";
    }
  } else {
    update.lastStaffMessageAt = at;
    if (state.firstResponseAt === null) update.firstResponseAt = at;
    if (state.awaitingSince !== null) {
      responseSeconds = secondsBetween(state.awaitingSince, at);
      update.awaitingStaff = false;
      update.awaitingSince = null;
      update.overdue = false;
    }
    if (state.status === "open" || state.status === "in_progress") {
      update.status = "waiting_user";
    }
  }
  return {update, responseSeconds, reopened};
}

export type Actor = "user" | "assignee" | "admin" | "support";

export function canSetStatus(actor: Actor, from: CaseStatus, to: CaseStatus): boolean {
  if (from === to || from === "closed") return false;
  if (actor === "user") return to === "resolved";
  if (actor === "support") return false;
  return to !== "open";
}

export interface StatusEffect {
  update: Record<string, number | string | boolean | null>;
  // Time the assignee worked on the case, counted when work stops.
  handlingSeconds: number;
  resolved: boolean;
}

export function applyStatus(state: CaseState, to: CaseStatus, now: number): StatusEffect {
  const update: StatusEffect["update"] = {status: to};
  let handlingSeconds = 0;
  const stopsWork = !isActive(to) && isActive(state.status);

  if (stopsWork) {
    handlingSeconds = secondsBetween(state.workStartedAt, now);
    update.workStartedAt = null;
    update.awaitingSince = null;
    update.awaitingStaff = false;
    update.overdue = false;
  }
  if (to === "resolved") update.resolvedAt = now;
  if (to === "closed") update.closedAt = now;
  if (state.status === "resolved" && isActive(to)) {
    update.resolvedAt = null;
    if (state.assignedTo) update.workStartedAt = now;
  }
  return {update, handlingSeconds, resolved: to === "resolved" && state.status !== "resolved"};
}

export interface NewCaseInput {
  kind: CaseKind;
  category: CaseCategory;
  subject: string;
  message: string;
}

export function readNewCase(data: unknown): NewCaseInput | null {
  const input = (data ?? {}) as Json;
  const kind = oneOf(CASE_KINDS, input.kind);
  const category = oneOf(CASE_CATEGORIES, input.category);
  const subject = typeof input.subject === "string" ? input.subject.trim() : "";
  const message = typeof input.message === "string" ? input.message.trim() : "";
  if (!kind || !category) return null;
  if (subject.length < 3 || subject.length > SUBJECT_MAX_LENGTH) return null;
  if (message.length < 1 || message.length > MESSAGE_MAX_LENGTH) return null;
  return {kind, category, subject, message};
}

export interface StatusNotice {
  recipient: "user" | "assignee";
  title: "resolvedTitle" | "closedTitle" | "userSolvedTitle";
}

// Only finishing a request is worth a push; nobody hears about their own action.
export function statusNotice(
  actor: Actor,
  to: CaseStatus,
  assignedTo: string | null,
  by: string,
): StatusNotice | null {
  if (actor === "user") {
    return to === "resolved" && assignedTo && assignedTo !== by ?
      {recipient: "assignee", title: "userSolvedTitle"} :
      null;
  }
  if (to === "resolved") return {recipient: "user", title: "resolvedTitle"};
  if (to === "closed") return {recipient: "user", title: "closedTitle"};
  return null;
}
