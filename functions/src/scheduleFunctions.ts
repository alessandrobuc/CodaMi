import "./options";

import {Timestamp, getFirestore} from "firebase-admin/firestore";
import * as logger from "firebase-functions/logger";
import {onSchedule} from "firebase-functions/scheduler";

import {DEFAULT_CHANNEL} from "./notifications";
import {sendToTokens, tokensOf} from "./push";
import {remindersOf, stepReminders, type PlannedReminder} from "./schedule";

const db = () => getFirestore();
const events = () => db().collection("scheduleEvents");

// Sends the reminders the app planned for each event, then keeps the rest.
export const scheduleReminderSweep = onSchedule("every 5 minutes", async () => {
  const now = Date.now();
  let sent = 0;
  let checked = 0;
  for (let round = 0; round < 20; round++) {
    const due = await events().where("nextRemindAt", "<=", Timestamp.fromMillis(now)).limit(300).get();
    if (due.empty) break;
    for (const doc of due.docs) {
      checked++;
      const step = stepReminders(remindersOf(doc.get("reminders")), now);
      await doc.ref.update({
        reminders: step.rest.map((r) => ({at: Timestamp.fromMillis(r.at), title: r.title, body: r.body})),
        nextRemindAt: step.rest.length > 0 ? Timestamp.fromMillis(step.rest[0].at) : null,
      });
      const ownerId = doc.get("ownerId");
      if (step.send && typeof ownerId === "string" && await remind(ownerId, doc.id, step.send)) sent++;
    }
    if (due.size < 300) break;
  }
  logger.info("Schedule reminders", {checked, sent});
});

async function remind(ownerId: string, eventId: string, r: PlannedReminder): Promise<boolean> {
  try {
    const user = await db().collection("users").doc(ownerId).get();
    const tokens = tokensOf(user);
    if (!user.exists || tokens.length === 0) return false;
    const result = await sendToTokens(tokens, {
      notification: {title: r.title, body: r.body},
      data: {kind: "schedule_reminder", scheduleEventId: eventId},
      android: {priority: "high", notification: {channelId: DEFAULT_CHANNEL, tag: `schedule_${eventId}`}},
      apns: {payload: {aps: {sound: "default"}}},
    });
    return result.success > 0;
  } catch (error) {
    logger.error("Schedule reminder failed", {eventId, error});
    return false;
  }
}

export async function deleteScheduleData(uid: string): Promise<void> {
  const owned = await events().where("ownerId", "==", uid).get();
  for (let i = 0; i < owned.docs.length; i += 400) {
    const batch = db().batch();
    owned.docs.slice(i, i + 400).forEach((d) => batch.delete(d.ref));
    await batch.commit();
  }
}
