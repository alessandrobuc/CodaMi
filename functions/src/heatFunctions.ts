import "./options";

import {getFirestore} from "firebase-admin/firestore";
import * as logger from "firebase-functions/logger";
import {onSchedule} from "firebase-functions/scheduler";

import {heatReminderOf, heatText, stepReminder} from "./heat";
import {DEFAULT_CHANNEL, languageOf} from "./notifications";
import {dayKey} from "./points";
import {sendToTokens, tokensOf} from "./push";

const db = () => getFirestore();

// Morning reminders before an expected heat; the app keeps each pet's next expected start.
export const heatReminderSweep = onSchedule(
  {schedule: "every day 09:00", timeZone: "Europe/Rome"},
  async () => {
    const today = dayKey(Date.now());
    let sent = 0;
    let moved = 0;
    for (let round = 0; round < 20; round++) {
      const due = await db().collection("heatReminders").where("remindOn", "<=", today).limit(300).get();
      if (due.empty) break;
      for (const doc of due.docs) {
        const reminder = heatReminderOf(doc.data());
        if (!reminder) {
          await doc.ref.delete();
          continue;
        }
        const step = stepReminder(reminder, today);
        await doc.ref.update({nextStart: step.nextStart, remindOn: step.remindOn});
        moved++;
        if (step.remindFor && await remind(reminder.ownerId, reminder.petId, reminder.petName, step.remindFor)) sent++;
      }
    }
    logger.info("Heat reminders", {today, sent, moved});
  },
);

async function remind(ownerId: string, petId: string, petName: string, day: string): Promise<boolean> {
  try {
    const user = await db().collection("users").doc(ownerId).get();
    const tokens = tokensOf(user);
    if (!user.exists || tokens.length === 0) return false;
    const lang = languageOf(user.get("language"));
    const result = await sendToTokens(tokens, {
      notification: {title: heatText(lang, "title", petName, day), body: heatText(lang, "body", petName, day)},
      data: {kind: "heat_reminder", petId},
      android: {priority: "high", notification: {channelId: DEFAULT_CHANNEL, tag: `heat_${petId}`}},
      apns: {payload: {aps: {sound: "default"}}},
    });
    return result.success > 0;
  } catch (error) {
    logger.error("Heat reminder failed", {petId, error});
    return false;
  }
}

export async function deleteHeatData(uid: string): Promise<void> {
  for (const name of ["heatCycles", "heatReminders"]) {
    const owned = await db().collection(name).where("ownerId", "==", uid).get();
    await Promise.all(owned.docs.map((d) => d.ref.delete()));
  }
}
