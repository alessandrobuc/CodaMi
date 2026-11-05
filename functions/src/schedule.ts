type Json = Record<string, unknown>;

// Minutes before the event. Must match remindOptions in lib/features/schedule/domain/schedule.dart.
export const REMIND_OPTIONS = [0, 15, 60, 1440, 10080];
// A reminder later than this is dropped, never sent late.
export const LATE_MS = 30 * 60 * 1000;

export interface PlannedReminder {
  at: number;
  title: string;
  body: string;
}

// The texts are written on the phone in the user's language; only clean them here.
export function remindersOf(value: unknown): PlannedReminder[] {
  if (!Array.isArray(value)) return [];
  const list: PlannedReminder[] = [];
  for (const r of value.slice(0, 60)) {
    if (typeof r !== "object" || r === null) continue;
    const {at, title, body} = r as Json;
    const ms = typeof (at as {toMillis?: unknown})?.toMillis === "function"
      ? (at as {toMillis: () => number}).toMillis()
      : null;
    if (ms === null || typeof title !== "string" || !title.trim()) continue;
    list.push({at: ms, title: title.slice(0, 120), body: typeof body === "string" ? body.slice(0, 200) : ""});
  }
  return list.sort((a, b) => a.at - b.at);
}

export interface ReminderStep {
  // Sent now; only the latest due one, so a late sweep never sends a burst.
  send: PlannedReminder | null;
  rest: PlannedReminder[];
}

export function stepReminders(reminders: PlannedReminder[], now: number): ReminderStep {
  const due = reminders.filter((r) => r.at <= now);
  const latest = due.length > 0 ? due[due.length - 1] : null;
  return {
    send: latest && now - latest.at <= LATE_MS ? latest : null,
    rest: reminders.filter((r) => r.at > now),
  };
}
