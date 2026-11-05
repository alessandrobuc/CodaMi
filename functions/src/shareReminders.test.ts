import assert from "node:assert/strict";
import {test} from "node:test";

import {decideReminder, firstReminderDay, reminderText, shareReminderConfigOf} from "./shareReminders";

const config = shareReminderConfigOf({enabled: true});
const active = {exists: true, disabled: false, optedOut: false, lastActiveDay: "2026-11-04"};
const state = {next: "2026-11-05", count: 0, lastSharedDay: null};

test("settings fall back to the agreed defaults", () => {
  assert.deepEqual(shareReminderConfigOf(undefined), {enabled: false, firstDays: 3, everyDays: 7, maxCount: 8});
  assert.equal(shareReminderConfigOf({everyDays: 1}).everyDays, 7, "never more than about weekly");
  assert.equal(shareReminderConfigOf({maxCount: 100}).maxCount, 8);
});

test("the first reminder comes a few days after sign-up, never in the past", () => {
  assert.equal(firstReminderDay("2026-11-05", "2026-11-05", config), "2026-11-08");
  assert.equal(firstReminderDay("2026-01-01", "2026-11-05", config), "2026-11-05");
});

test("a due reminder is sent, then the next one a week later", () => {
  assert.deepEqual(decideReminder(state, active, "2026-11-05", config), {action: "send", variant: 0, next: "2026-11-12", count: 1});
  const third = decideReminder({...state, count: 2}, active, "2026-11-05", config);
  assert.equal(third.action === "send" && third.variant, 2, "the text rotates");
});

test("it stops after the total and respects the user", () => {
  assert.deepEqual(decideReminder({...state, count: 8}, active, "2026-11-05", config), {action: "stop"});
  assert.deepEqual(decideReminder(state, {...active, optedOut: true}, "2026-11-05", config),
    {action: "skip", next: "2026-11-12", reason: "opted_out"});
  assert.deepEqual(decideReminder(state, {...active, exists: false}, "2026-11-05", config), {action: "delete"});
  assert.deepEqual(decideReminder(state, {...active, disabled: true}, "2026-11-05", config), {action: "delete"});
});

test("people who shared lately or left the app aren't bothered", () => {
  const shared = decideReminder({...state, lastSharedDay: "2026-10-25"}, active, "2026-11-05", config);
  assert.equal(shared.action === "skip" && shared.reason, "shared");
  assert.equal(decideReminder({...state, lastSharedDay: "2026-10-01"}, active, "2026-11-05", config).action, "send");
  const gone = decideReminder(state, {...active, lastActiveDay: "2026-08-01"}, "2026-11-05", config);
  assert.equal(gone.action === "skip" && gone.reason, "inactive");
  assert.equal(decideReminder(state, {...active, lastActiveDay: null}, "2026-11-05", config).action, "skip");
});

test("the client's text comes first, in every language", () => {
  assert.equal(reminderText("en", 0).title, "Help CodaMi make a difference! 🐾");
  assert.ok(reminderText("en", 0).body.startsWith("Sharing our app costs you nothing"));
  assert.ok(reminderText("it", 0).title.startsWith("Aiuta CodaMi"));
  assert.equal(reminderText("xx", 1).title, reminderText("en", 1).title);
  for (const lang of ["en", "it", "de", "fr", "es", "pt", "ru", "zh", "ar", "hi"]) {
    for (let v = 0; v < 4; v++) assert.ok(reminderText(lang, v).body.length > 20, `${lang} ${v}`);
  }
});
