import assert from "node:assert/strict";
import {test} from "node:test";

import {LATE_MS, remindersOf, stepReminders} from "./schedule";

const at = (ms: number) => ({toMillis: () => ms});

test("reminders are cleaned and sorted", () => {
  const list = remindersOf([
    {at: at(300), title: "Vet visit · Luna", body: "Tomorrow · 10:30"},
    {at: at(100), title: "x".repeat(500), body: 5},
    {at: "soon", title: "Bad"},
    {at: at(200), title: "  "},
    null,
  ]);
  assert.deepEqual(list.map((r) => r.at), [100, 300]);
  assert.equal(list[0].title.length, 120);
  assert.equal(list[0].body, "");
  assert.deepEqual(remindersOf("nope"), []);
});

test("the due reminder is sent and the later ones are kept", () => {
  const list = [{at: 1000, title: "a", body: ""}, {at: 5000, title: "b", body: ""}];
  const step = stepReminders(list, 1200);
  assert.equal(step.send?.title, "a");
  assert.deepEqual(step.rest.map((r) => r.title), ["b"]);
});

test("nothing due: nothing sent", () => {
  const step = stepReminders([{at: 5000, title: "b", body: ""}], 1000);
  assert.equal(step.send, null);
  assert.equal(step.rest.length, 1);
});

test("a late sweep sends only the latest reminder, and never one that is too late", () => {
  const list = [{at: 1000, title: "a", body: ""}, {at: 2000, title: "b", body: ""}];
  assert.equal(stepReminders(list, 2500).send?.title, "b");
  const late = stepReminders(list, 2000 + LATE_MS + 1);
  assert.equal(late.send, null);
  assert.deepEqual(late.rest, []);
});
