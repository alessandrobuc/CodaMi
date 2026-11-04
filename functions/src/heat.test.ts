import assert from "node:assert/strict";
import {test} from "node:test";

import {heatReminderOf, heatText, stepReminder, type HeatReminder} from "./heat";

const base: HeatReminder = {ownerId: "u", petId: "p", petName: "Luna", nextStart: "2026-12-10", cycleDays: 180, daysBefore: 3};

test("reminder is sent on its day, then planned for the next cycle", () => {
  assert.deepEqual(stepReminder(base, "2026-12-07"), {remindFor: "2026-12-10", nextStart: "2027-06-08", remindOn: "2027-06-05"});
  assert.deepEqual(stepReminder(base, "2026-12-01"), {remindFor: null, nextStart: "2026-12-10", remindOn: "2026-12-07"});
});

test("missed reminders are skipped, never sent late", () => {
  const step = stepReminder(base, "2026-12-20");
  assert.equal(step.remindFor, null);
  assert.equal(step.nextStart, "2027-06-08");
  assert.equal(step.remindOn, "2027-06-05");
  const cat = stepReminder({...base, cycleDays: 21, daysBefore: 1}, "2027-01-21");
  assert.equal(cat.remindFor, null);
  assert.ok(cat.remindOn > "2027-01-21");
});

test("only valid reminders are used", () => {
  assert.deepEqual(heatReminderOf({...base}), base);
  assert.equal(heatReminderOf({...base, daysBefore: 5}), null);
  assert.equal(heatReminderOf({...base, cycleDays: 3}), null);
  assert.equal(heatReminderOf({...base, nextStart: "2026-02-30"}), null);
  assert.equal(heatReminderOf(undefined), null);
  assert.equal(heatReminderOf({...base, petName: "x".repeat(80)})?.petName.length, 60);
});

test("reminder text in the owner's language with the date", () => {
  assert.equal(heatText("en", "title", "Luna", "2026-12-10"), "Luna: heat expected soon");
  assert.match(heatText("en", "body", "Luna", "2026-12-10"), /around December 10/);
  assert.match(heatText("it", "body", "Luna", "2026-12-10"), /10 dicembre/);
  assert.match(heatText("xx", "body", "Luna", "2026-12-10"), /December/);
});
