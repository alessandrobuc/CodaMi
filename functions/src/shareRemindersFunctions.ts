import "./options";

import {getAuth} from "firebase-admin/auth";
import {FieldValue, getFirestore} from "firebase-admin/firestore";
import {HttpsError, onCall} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";
import {onSchedule} from "firebase-functions/scheduler";

import {pushSettingsOf} from "./notifications";
import {dayKey, isDayKey} from "./points";
import {
  NEVER, SHARE_EVENTS, decideReminder, firstReminderDay, reminderText, shareReminderConfigOf, type ShareReminderConfig,
} from "./shareReminders";
import {requireStaff} from "./supportFunctions";
import {pushToUsers} from "./userPush";

const db = () => getFirestore();
const reminders = () => db().collection("shareReminders");
const loadConfig = async (): Promise<ShareReminderConfig> =>
  shareReminderConfigOf((await db().collection("config").doc("shareReminders").get()).data());

async function stat(field: "sent" | "opened" | "shares"): Promise<void> {
  await db().collection("shareReminderStats").doc(dayKey(Date.now()))
    .set({[field]: FieldValue.increment(1)}, {merge: true});
}

// Called from registerVisit: plans the first reminder once per user.
export async function ensureShareReminder(uid: string): Promise<void> {
  try {
    const ref = reminders().doc(uid);
    if (isDayKey((await ref.get()).get("next"))) return;
    const [config, account] = await Promise.all([loadConfig(), getAuth().getUser(uid)]);
    const created = Date.parse(account.metadata.creationTime);
    const today = dayKey(Date.now());
    const signup = Number.isNaN(created) ? today : dayKey(created);
    await ref.set({next: firstReminderDay(signup, today, config), count: 0}, {merge: true});
  } catch (error) {
    logger.warn("Share reminder not planned", {uid, error});
  }
}

// Any share (a report or the app) pauses the reminders for a while.
export async function markShared(uid: string): Promise<void> {
  await reminders().doc(uid).set({lastSharedDay: dayKey(Date.now())}, {merge: true});
}

async function send(uid: string, variant: number): Promise<boolean> {
  const sent = await pushToUsers([uid], {
    title: (lang) => reminderText(lang, variant).title,
    body: (lang) => reminderText(lang, variant).body,
  }, {kind: "share_reminder"}, "share");
  return sent > 0;
}

// Every evening; at most one reminder per user each time.
export const shareReminderSweep = onSchedule(
  {schedule: "every day 18:00", timeZone: "Europe/Rome"},
  async () => {
    const config = await loadConfig();
    if (!config.enabled) return;
    const today = dayKey(Date.now());
    const counts = {sent: 0, skipped: 0, stopped: 0};
    for (let round = 0; round < 30; round++) {
      const due = await reminders().where("next", "<=", today).limit(200).get();
      if (due.empty) break;
      const users = await db().getAll(...due.docs.map((d) => db().collection("users").doc(d.id)));
      for (const [i, doc] of due.docs.entries()) {
        const user = users[i];
        const decision = decideReminder(
          {next: doc.get("next"), count: doc.get("count") ?? 0, lastSharedDay: doc.get("lastSharedDay") ?? null},
          {
            exists: user.exists,
            disabled: user.get("disabled") === true,
            optedOut: !pushSettingsOf(user.get("notificationPrefs"), "share").enabled,
            lastActiveDay: user.get("activity")?.lastDay ?? null,
          },
          today,
          config,
        );
        switch (decision.action) {
          case "delete":
            await doc.ref.delete();
            break;
          case "stop":
            await doc.ref.update({next: NEVER});
            counts.stopped++;
            break;
          case "skip":
            await doc.ref.update({next: decision.next});
            counts.skipped++;
            break;
          case "send":
            await doc.ref.update({next: decision.next, count: decision.count, lastSentDay: today});
            if (await send(doc.id, decision.variant)) {
              counts.sent++;
              await stat("sent");
            }
        }
      }
      if (due.size < 200) break;
    }
    logger.info("Share reminders", {today, ...counts});
  },
);

// The app reports when a reminder was opened and when the user shared.
export const shareReminderEvent = onCall(async (request) => {
  if (!request.auth) throw new HttpsError("unauthenticated", "Please sign in again.");
  const data = (request.data ?? {}) as {event?: unknown; fromReminder?: unknown};
  const event = typeof data.event === "string" && SHARE_EVENTS.includes(data.event) ? data.event : null;
  if (!event) throw new HttpsError("invalid-argument", "Unknown event.");
  const fromReminder = data.fromReminder === true;
  if (event === "shared") await markShared(request.auth.uid);
  if (fromReminder) await stat(event === "opened" ? "opened" : "shares");
  return {ok: true};
});

// Admins try the reminder on their own phone.
export const testShareReminder = onCall(async (request) => {
  const staff = await requireStaff(request, true);
  const variant = Math.floor(Math.random() * 4);
  return {sent: await send(staff.uid, variant)};
});

export async function deleteShareReminderData(uid: string): Promise<void> {
  await reminders().doc(uid).delete();
}
