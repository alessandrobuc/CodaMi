import assert from "node:assert/strict";
import {test} from "node:test";

import {
  DEFAULT_LIMITS,
  applyMessage,
  applyStatus,
  canSetStatus,
  caseReference,
  isOverdue,
  limitsOf,
  preview,
  readCase,
  readNewCase,
  shouldAutoClose,
  statusNotice,
  type CaseState,
} from "./support";
import {supportText} from "./supportMessages";

const MIN = 60_000;
const base: CaseState = {
  kind: "chat",
  status: "open",
  userId: "u1",
  assignedTo: null,
  awaitingSince: 1_000,
  firstResponseAt: null,
  workStartedAt: null,
  resolvedAt: null,
};

test("case references and previews", () => {
  assert.equal(caseReference(1042), "CM-1042");
  assert.equal(preview("  hello\n  there "), "hello there");
  assert.equal(preview("a".repeat(200)).length, 140);
});

test("readCase needs a kind, status and user", () => {
  const state = readCase({kind: "ticket", status: "in_progress", userId: "u1", assignedTo: "s1", awaitingSince: new Date(5)});
  assert.equal(state?.assignedTo, "s1");
  assert.equal(state?.awaitingSince, 5);
  assert.equal(readCase({kind: "ticket", status: "nope", userId: "u1"}), null);
  assert.equal(readCase(undefined), null);
});

test("new case input is checked", () => {
  const ok = {kind: "chat", category: "app", subject: "  Login  ", message: " Help "};
  assert.deepEqual(readNewCase(ok), {kind: "chat", category: "app", subject: "Login", message: "Help"});
  assert.equal(readNewCase({...ok, kind: "call"}), null);
  assert.equal(readNewCase({...ok, subject: "no"}), null);
  assert.equal(readNewCase({...ok, message: "x".repeat(2001)}), null);
  assert.equal(readNewCase(null), null);
});

test("first staff reply records response time and waits for the user", () => {
  const assigned = {...base, status: "in_progress" as const, assignedTo: "s1"};
  const effect = applyMessage(assigned, "staff", 1_000 + 3 * MIN, "Hi");
  assert.equal(effect.responseSeconds, 180);
  assert.equal(effect.update.firstResponseAt, 1_000 + 3 * MIN);
  assert.equal(effect.update.awaitingStaff, false);
  assert.equal(effect.update.awaitingSince, null);
  assert.equal(effect.update.status, "waiting_user");

  const again = applyMessage({...assigned, awaitingSince: null, firstResponseAt: 5}, "staff", 9_000, "More");
  assert.equal(again.responseSeconds, null);
  assert.ok(!("firstResponseAt" in again.update));
});

test("user messages keep the oldest waiting time and reopen resolved cases", () => {
  const waiting = applyMessage(base, "user", 50_000, "Still there?");
  assert.ok(!("awaitingSince" in waiting.update));

  const answered = {...base, status: "waiting_user" as const, assignedTo: "s1", awaitingSince: null};
  const reply = applyMessage(answered, "user", 70_000, "Thanks");
  assert.equal(reply.update.status, "in_progress");
  assert.equal(reply.update.awaitingSince, 70_000);

  const resolved = {...answered, status: "resolved" as const, resolvedAt: 60_000};
  const reopen = applyMessage(resolved, "user", 80_000, "It broke again");
  assert.ok(reopen.reopened);
  assert.equal(reopen.update.status, "in_progress");
  assert.equal(reopen.update.resolvedAt, null);
  assert.equal(reopen.update.workStartedAt, 80_000);

  const unassigned = applyMessage({...resolved, assignedTo: null}, "user", 80_000, "Hi");
  assert.equal(unassigned.update.status, "open");
});

test("who can change the status", () => {
  assert.ok(canSetStatus("user", "waiting_user", "resolved"));
  assert.ok(!canSetStatus("user", "open", "closed"));
  assert.ok(canSetStatus("assignee", "in_progress", "resolved"));
  assert.ok(canSetStatus("admin", "resolved", "in_progress"));
  assert.ok(!canSetStatus("support", "in_progress", "resolved"));
  assert.ok(!canSetStatus("admin", "closed", "in_progress"));
  assert.ok(!canSetStatus("admin", "in_progress", "open"));
  assert.ok(!canSetStatus("admin", "resolved", "resolved"));
});

test("resolving counts handling time once", () => {
  const working = {...base, status: "in_progress" as const, assignedTo: "s1", workStartedAt: 0};
  const resolved = applyStatus(working, "resolved", 10 * MIN);
  assert.equal(resolved.handlingSeconds, 600);
  assert.ok(resolved.resolved);
  assert.equal(resolved.update.resolvedAt, 10 * MIN);
  assert.equal(resolved.update.workStartedAt, null);
  assert.equal(resolved.update.awaitingStaff, false);

  const closed = applyStatus({...working, status: "resolved", workStartedAt: null}, "closed", 20 * MIN);
  assert.equal(closed.handlingSeconds, 0);
  assert.ok(!closed.resolved);
  assert.equal(closed.update.closedAt, 20 * MIN);

  const reopened = applyStatus({...working, status: "resolved", workStartedAt: null}, "in_progress", 30 * MIN);
  assert.equal(reopened.update.resolvedAt, null);
  assert.equal(reopened.update.workStartedAt, 30 * MIN);
});

test("reply limits, overdue and auto-close", () => {
  assert.deepEqual(limitsOf(undefined), DEFAULT_LIMITS);
  assert.equal(limitsOf({chatReplyMinutes: 10, autoCloseDays: -1}).chatReplyMinutes, 10);
  assert.equal(limitsOf({autoCloseDays: -1}).autoCloseDays, 7);
  assert.ok(isOverdue("chat", 0, 5 * MIN, DEFAULT_LIMITS));
  assert.ok(!isOverdue("ticket", 0, 5 * MIN, DEFAULT_LIMITS));
  assert.ok(isOverdue("ticket", 0, 24 * 60 * MIN, DEFAULT_LIMITS));
  assert.ok(!isOverdue("chat", null, 99 * MIN, DEFAULT_LIMITS));
  assert.ok(shouldAutoClose(0, 7 * 86_400_000, DEFAULT_LIMITS));
  assert.ok(!shouldAutoClose(0, 6 * 86_400_000, DEFAULT_LIMITS));
});

test("support pushes follow the recipient's language", () => {
  assert.equal(supportText("it", "newCaseTitle", {ref: "CM-1001"}), "Nuova richiesta di assistenza CM-1001");
  assert.equal(supportText("xx", "overdueBody", {count: "3"}), "3 requests have no reply yet.");
});

test("only finishing a request sends a status push", () => {
  assert.deepEqual(statusNotice("assignee", "resolved", "s1", "s1"), {recipient: "user", title: "resolvedTitle"});
  assert.deepEqual(statusNotice("admin", "closed", "s1", "a1"), {recipient: "user", title: "closedTitle"});
  assert.deepEqual(statusNotice("user", "resolved", "s1", "u1"), {recipient: "assignee", title: "userSolvedTitle"});
  assert.equal(statusNotice("user", "resolved", null, "u1"), null);
  assert.equal(statusNotice("assignee", "waiting_user", "s1", "s1"), null);
  assert.equal(statusNotice("admin", "in_progress", "s1", "a1"), null);
});

test("new support pushes are translated", () => {
  assert.equal(supportText("it", "assignedTitle", {ref: "CM-1001"}), "CM-1001 è stata assegnata a te");
  assert.equal(supportText("de", "queueBody", {count: "2"}), "2 Anfragen brauchen einen neuen Mitarbeiter.");
});
