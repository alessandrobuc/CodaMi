import "./options";

import {
  FieldValue,
  Timestamp,
  getFirestore,
  type DocumentReference,
  type DocumentSnapshot,
  type Transaction,
} from "firebase-admin/firestore";
import {onDocumentCreated} from "firebase-functions/firestore";
import {HttpsError, onCall, type CallableRequest} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";
import {onSchedule} from "firebase-functions/scheduler";

import {languageOf, pushSettingsOf} from "./notifications";
import {SAFE_ID_PATTERN, readString} from "./places";
import {sendToTokens, tokensOf} from "./push";
import {
  CASE_STATUSES,
  FIRST_CASE_NUMBER,
  MAX_ACTIVE_CASES,
  PRESENCE_TIMEOUT_MS,
  applyMessage,
  applyStatus,
  canSetStatus,
  caseReference,
  isActive,
  isOverdue,
  limitsOf,
  oneOf,
  preview,
  readCase,
  readNewCase,
  secondsBetween,
  shouldAutoClose,
  statusNotice,
  type Actor,
  type CaseState,
  type Sender,
} from "./support";
import {supportText, type SupportMessageKey} from "./supportMessages";

const TRIGGER_REGION = "us-central1";
const ACTIVE_STATUSES = ["open", "in_progress", "waiting_user"];
const STAFF_ROLES = ["support", "admin"];
const SUPPORT_COLOR = "#1F6F5B";

const db = () => getFirestore();
const casesRef = () => db().collection("supportCases");
const statsRef = (uid: string) => db().collection("staffStats").doc(uid);

interface Staff {
  uid: string;
  role: "support" | "admin";
  name: string;
}

function requireSignedIn(request: CallableRequest): string {
  if (!request.auth) throw new HttpsError("unauthenticated", "Please sign in again.");
  return request.auth.uid;
}

async function staffOf(uid: string): Promise<Staff | null> {
  const user = await db().collection("users").doc(uid).get();
  const role = user.get("role");
  if (!STAFF_ROLES.includes(role)) return null;
  return {uid, role, name: nameOf(user)};
}

export async function requireStaff(request: CallableRequest, adminOnly = false): Promise<Staff> {
  const staff = await staffOf(requireSignedIn(request));
  if (!staff || (adminOnly && staff.role !== "admin")) {
    throw new HttpsError("permission-denied", "Only support staff can do this.");
  }
  return staff;
}

function nameOf(user: DocumentSnapshot): string {
  const name = user.get("name");
  const email = user.get("email");
  if (typeof name === "string" && name.trim()) return name.trim();
  return typeof email === "string" ? email : "";
}

function readCaseId(data: unknown): string {
  return readString(data, "caseId", {min: 1, max: 128, pattern: SAFE_ID_PATTERN});
}

// Millisecond times become Timestamps and `null` removes the field.
function toFirestore(fields: Record<string, number | string | boolean | null>): Record<string, unknown> {
  const out: Record<string, unknown> = {};
  for (const [key, value] of Object.entries(fields)) {
    if (value === null) out[key] = FieldValue.delete();
    else if (typeof value === "number" && (key.endsWith("At") || key === "awaitingSince")) {
      out[key] = Timestamp.fromMillis(value);
    } else out[key] = value;
  }
  return out;
}

function addEvent(
  tx: Transaction,
  caseRef: DocumentReference,
  event: {type: string; by: string; byName: string; [key: string]: unknown},
): void {
  tx.set(caseRef.collection("events").doc(), {...event, at: FieldValue.serverTimestamp()});
}

function addStats(
  tx: Transaction,
  uid: string | null,
  stats: Record<string, number>,
): void {
  if (!uid) return;
  const update: Record<string, unknown> = {lastActiveAt: FieldValue.serverTimestamp()};
  for (const [key, value] of Object.entries(stats)) update[key] = FieldValue.increment(value);
  tx.set(statsRef(uid), update, {merge: true});
}

async function readCaseIn(tx: Transaction, caseId: string): Promise<{ref: DocumentReference; snap: DocumentSnapshot; state: CaseState}> {
  const ref = casesRef().doc(caseId);
  const snap = await tx.get(ref);
  const state = readCase(snap.data());
  if (!state) throw new HttpsError("not-found", "This request no longer exists.");
  return {ref, snap, state};
}

async function onlineStaffIds(): Promise<string[]> {
  const since = Timestamp.fromMillis(Date.now() - PRESENCE_TIMEOUT_MS);
  const presence = await db().collection("staffPresence").where("lastSeen", ">", since).get();
  const ids = presence.docs.filter((d) => d.get("state") === "online").map((d) => d.id);
  if (ids.length === 0) return [];
  const users = await db().getAll(...ids.map((id) => db().collection("users").doc(id)));
  return users.filter((u) => STAFF_ROLES.includes(u.get("role"))).map((u) => u.id);
}

function notify(
  uids: (string | null)[],
  content: PushContent,
  data: Record<string, string>,
): Promise<void> {
  const recipients = uids.filter((uid): uid is string => !!uid);
  return pushToUsers(recipients, content, data)
    .catch((error) => logger.error("Support push failed", {kind: data.kind, error}));
}

interface PushContent {
  title: SupportMessageKey;
  vars: Record<string, string>;
  // Either a message key or text shown as it is, such as a chat message.
  body: SupportMessageKey | {text: string};
}

// Online operators first; when nobody is online every staff member hears about it.
export async function staffToAlert(): Promise<string[]> {
  const online = await onlineStaffIds();
  if (online.length > 0) return online;
  const staff = await db().collection("users").where("role", "in", STAFF_ROLES).get();
  return staff.docs.map((d) => d.id);
}

async function pushToUsers(
  uids: string[],
  content: PushContent,
  data: Record<string, string>,
): Promise<void> {
  if (uids.length === 0) return;
  const users = await db().getAll(...uids.map((uid) => db().collection("users").doc(uid)));
  for (const user of users) {
    if (!user.exists) continue;
    const settings = pushSettingsOf(user.get("notificationPrefs"), "support");
    const tokens = tokensOf(user);
    if (!settings.enabled || tokens.length === 0) continue;
    const lang = languageOf(user.get("language"));
    const body = typeof content.body === "string" ?
      supportText(lang, content.body, content.vars) :
      content.body.text;
    const result = await sendToTokens(tokens, {
      notification: {title: supportText(lang, content.title, content.vars), body},
      data,
      android: {priority: "high", notification: {channelId: settings.channelId, color: SUPPORT_COLOR}},
      apns: {payload: {aps: settings.iosSound ? {sound: settings.iosSound} : {}}},
    });
    logger.info("Support notification sent", {uid: user.id, kind: data.kind, ...result});
  }
}

// Someone who is no longer staff can't see their cases, so they go back to the queue.
export async function releaseCasesOf(uid: string): Promise<number> {
  const assigned = await casesRef()
    .where("assignedTo", "==", uid)
    .where("status", "in", ACTIVE_STATUSES)
    .get();
  for (const doc of assigned.docs) {
    await db().runTransaction(async (tx) => {
      const snap = await tx.get(doc.ref);
      const state = readCase(snap.data());
      if (!state || state.assignedTo !== uid || !isActive(state.status)) return;
      const now = Date.now();
      const worked = secondsBetween(state.workStartedAt, now);
      tx.update(doc.ref, {
        ...toFirestore({
          assignedName: null,
          assignedAt: null,
          workStartedAt: null,
          status: "open",
          updatedAt: now,
        }),
        assignedTo: null,
        handlingSeconds: FieldValue.increment(worked),
      });
      addEvent(tx, doc.ref, {
        type: "reassigned",
        by: "system",
        byName: "",
        from: uid,
        fromName: snap.get("assignedName") ?? null,
        to: null,
        toName: null,
      });
      addStats(tx, uid, {handlingSecondsTotal: worked});
    });
  }
  if (assigned.size > 0) {
    await notify(
      await staffToAlert(),
      {title: "queueTitle", vars: {count: String(assigned.size)}, body: "queueBody"},
      {kind: "support_queue"},
    );
  }
  return assigned.size;
}

export const supportAvailability = onCall(async (request) => {
  requireSignedIn(request);
  return {liveChat: (await onlineStaffIds()).length > 0};
});

export const supportCreateCase = onCall(async (request) => {
  const uid = requireSignedIn(request);
  const input = readNewCase(request.data);
  if (!input) throw new HttpsError("invalid-argument", "Please check the subject and message.");

  const user = await db().collection("users").doc(uid).get();
  if (user.get("disabled") === true) {
    throw new HttpsError("permission-denied", "This account is disabled.");
  }
  const active = await casesRef()
    .where("userId", "==", uid)
    .where("status", "in", ACTIVE_STATUSES)
    .count()
    .get();
  if (active.data().count >= MAX_ACTIVE_CASES) {
    throw new HttpsError("resource-exhausted", "You already have open requests. Please continue in one of them.");
  }

  const caseRef = casesRef().doc();
  const now = Timestamp.now();
  const reference = await db().runTransaction(async (tx) => {
    const counterRef = db().collection("counters").doc("supportCases");
    const counter = await tx.get(counterRef);
    const next = counter.get("next");
    const number = typeof next === "number" ? next : FIRST_CASE_NUMBER;
    const reference = caseReference(number);
    const email = user.get("email");

    tx.set(counterRef, {next: number + 1}, {merge: true});
    tx.set(caseRef, {
      kind: input.kind,
      category: input.category,
      subject: input.subject,
      number,
      reference,
      userId: uid,
      userName: nameOf(user),
      userEmail: typeof email === "string" ? email.toLowerCase() : "",
      language: languageOf(user.get("language")),
      status: "open",
      assignedTo: null,
      awaitingStaff: true,
      awaitingSince: now,
      overdue: false,
      messageCount: 1,
      responseCount: 0,
      responseSecondsTotal: 0,
      handlingSeconds: 0,
      lastMessageAt: now,
      lastMessageBy: "user",
      lastMessageText: preview(input.message),
      lastUserMessageAt: now,
      createdAt: now,
      updatedAt: now,
    });
    tx.set(caseRef.collection("messages").doc(), {
      senderId: uid,
      senderRole: "user",
      text: input.message,
      createdAt: now,
      applied: true,
    });
    addEvent(tx, caseRef, {type: "created", by: uid, byName: nameOf(user), kind: input.kind});
    return reference;
  });

  logger.info("Support case created", {caseId: caseRef.id, reference, kind: input.kind});
  await pushToUsers(
    await staffToAlert(),
    {title: "newCaseTitle", vars: {ref: reference}, body: {text: input.subject}},
    {kind: "support_case", caseId: caseRef.id},
  ).catch((error) => logger.error("New case push failed", error));
  return {caseId: caseRef.id, reference};
});

export const supportTakeCase = onCall(async (request) => {
  const staff = await requireStaff(request);
  const caseId = readCaseId(request.data);

  const taken = await db().runTransaction(async (tx) => {
    const {ref, snap, state} = await readCaseIn(tx, caseId);
    if (!isActive(state.status)) {
      throw new HttpsError("failed-precondition", "This request is already finished.");
    }
    if (state.assignedTo === staff.uid) return null;
    if (state.assignedTo) {
      throw new HttpsError("already-exists", `Already taken by ${snap.get("assignedName") || "another operator"}.`);
    }
    const now = Date.now();
    tx.update(ref, toFirestore({
      assignedTo: staff.uid,
      assignedName: staff.name,
      assignedAt: now,
      workStartedAt: now,
      status: state.status === "open" ? "in_progress" : state.status,
      updatedAt: now,
    }));
    addEvent(tx, ref, {type: "taken", by: staff.uid, byName: staff.name});
    addStats(tx, staff.uid, {casesTaken: 1});
    return {userId: state.userId, reference: String(snap.get("reference") ?? "")};
  });

  logger.info("Support case taken", {caseId, by: staff.uid});
  if (taken) {
    await notify(
      [taken.userId],
      {title: "takenTitle", vars: {ref: taken.reference}, body: "takenBody"},
      {kind: "support_taken", caseId},
    );
  }
  return {assignedTo: staff.uid};
});

export const supportReassignCase = onCall(async (request) => {
  const admin = await requireStaff(request, true);
  const caseId = readCaseId(request.data);
  const rawTo = (request.data as {to?: unknown} | null)?.to;
  const target = rawTo === null || rawTo === undefined ?
    null :
    await staffOf(readString(request.data, "to", {min: 1, max: 128, pattern: SAFE_ID_PATTERN}));
  if (rawTo && !target) {
    throw new HttpsError("invalid-argument", "That person is not support staff.");
  }

  const moved = await db().runTransaction(async (tx) => {
    const {ref, snap, state} = await readCaseIn(tx, caseId);
    if (!isActive(state.status)) {
      throw new HttpsError("failed-precondition", "This request is already finished.");
    }
    if (state.assignedTo === (target?.uid ?? null)) return null;
    const now = Date.now();
    const worked = secondsBetween(state.workStartedAt, now);
    tx.update(ref, {
      ...toFirestore(target ? {
        assignedTo: target.uid,
        assignedName: target.name,
        assignedAt: now,
        workStartedAt: now,
        status: state.status === "open" ? "in_progress" : state.status,
        updatedAt: now,
      } : {
        assignedName: null,
        assignedAt: null,
        workStartedAt: null,
        status: "open",
        updatedAt: now,
      }),
      ...(target ? {} : {assignedTo: null}),
      handlingSeconds: FieldValue.increment(worked),
    });
    addEvent(tx, ref, {
      type: "reassigned",
      by: admin.uid,
      byName: admin.name,
      from: state.assignedTo,
      fromName: snap.get("assignedName") ?? null,
      to: target?.uid ?? null,
      toName: target?.name ?? null,
    });
    addStats(tx, state.assignedTo, {handlingSecondsTotal: worked});
    if (target) addStats(tx, target.uid, {casesTaken: 1});
    return {reference: String(snap.get("reference") ?? ""), subject: String(snap.get("subject") ?? "")};
  });

  logger.info("Support case reassigned", {caseId, by: admin.uid, to: target?.uid ?? null});
  if (moved && target && target.uid !== admin.uid) {
    await notify(
      [target.uid],
      {title: "assignedTitle", vars: {ref: moved.reference}, body: {text: moved.subject}},
      {kind: "support_assigned", caseId},
    );
  }
  return {assignedTo: target?.uid ?? null};
});

export const supportSetStatus = onCall(async (request) => {
  const uid = requireSignedIn(request);
  const caseId = readCaseId(request.data);
  const to = oneOf(CASE_STATUSES, (request.data as {status?: unknown} | null)?.status);
  if (!to) throw new HttpsError("invalid-argument", "Unknown status.");
  const staff = await staffOf(uid);

  const changed = await db().runTransaction(async (tx) => {
    const {ref, snap, state} = await readCaseIn(tx, caseId);
    let actor: Actor;
    if (state.userId === uid) actor = "user";
    else if (staff?.role === "admin") actor = "admin";
    else if (staff && state.assignedTo === uid) actor = "assignee";
    else if (staff) actor = "support";
    else throw new HttpsError("not-found", "This request no longer exists.");

    if (!canSetStatus(actor, state.status, to)) {
      throw new HttpsError("failed-precondition", "This status can't be set now.");
    }
    const now = Date.now();
    const effect = applyStatus(state, to, now);
    tx.update(ref, {
      ...toFirestore({...effect.update, updatedAt: now}),
      handlingSeconds: FieldValue.increment(effect.handlingSeconds),
    });
    addEvent(tx, ref, {
      type: "status",
      by: uid,
      byName: actor === "user" ? String(snap.get("userName") ?? "") : staff?.name ?? "",
      byUser: actor === "user",
      from: state.status,
      to,
    });
    addStats(tx, state.assignedTo, {
      handlingSecondsTotal: effect.handlingSeconds,
      casesResolved: effect.resolved ? 1 : 0,
    });
    return {
      notice: statusNotice(actor, to, state.assignedTo, uid),
      userId: state.userId,
      assignedTo: state.assignedTo,
      reference: String(snap.get("reference") ?? ""),
      subject: String(snap.get("subject") ?? ""),
    };
  });

  logger.info("Support case status changed", {caseId, by: uid, to});
  const notice = changed.notice;
  if (notice) {
    const toUser = notice.recipient === "user";
    await notify(
      [toUser ? changed.userId : changed.assignedTo],
      {
        title: notice.title,
        vars: {ref: changed.reference},
        body: notice.title === "resolvedTitle" ? "resolvedBody" :
          notice.title === "closedTitle" ? "closedBody" :
            {text: changed.subject},
      },
      {kind: "support_status", caseId},
    );
  }
  return {status: to};
});

export const onSupportMessageCreated = onDocumentCreated(
  {document: "supportCases/{caseId}/messages/{messageId}", region: TRIGGER_REGION},
  async (event) => {
    const message = event.data;
    if (!message || message.get("applied") === true) return;
    const by: Sender = message.get("senderRole") === "staff" ? "staff" : "user";
    const senderId = String(message.get("senderId") ?? "");
    const text = String(message.get("text") ?? "");
    const at = message.get("createdAt")?.toMillis?.() ?? Date.now();

    const result = await db().runTransaction(async (tx) => {
      const fresh = await tx.get(message.ref);
      if (fresh.get("applied") === true) return null;
      const caseRef = casesRef().doc(event.params.caseId);
      const snap = await tx.get(caseRef);
      const state = readCase(snap.data());
      if (!state) return null;

      const effect = applyMessage(state, by, at, text);
      tx.update(caseRef, {
        ...toFirestore({...effect.update, updatedAt: Date.now()}),
        messageCount: FieldValue.increment(1),
        ...(effect.responseSeconds !== null ? {
          responseCount: FieldValue.increment(1),
          responseSecondsTotal: FieldValue.increment(effect.responseSeconds),
        } : {}),
      });
      tx.update(message.ref, {applied: true});
      if (effect.responseSeconds !== null) {
        addStats(tx, senderId, {responses: 1, responseSecondsTotal: effect.responseSeconds});
      }
      if (effect.reopened) {
        addEvent(tx, caseRef, {type: "reopened", by: senderId, byName: String(snap.get("userName") ?? "")});
      }
      return {state, reference: String(snap.get("reference") ?? "")};
    });
    if (!result) return;

    const data = {kind: "support_message", caseId: event.params.caseId};
    const vars = {ref: result.reference};
    const body = {text: preview(text)};
    if (by === "staff") {
      await pushToUsers([result.state.userId], {title: "replyTitle", vars, body}, data);
    } else {
      const recipients = result.state.assignedTo ? [result.state.assignedTo] : await staffToAlert();
      await pushToUsers(recipients, {title: "newMessageTitle", vars, body}, data);
    }
  },
);

// Flags requests nobody answered in time, tells the admins, and closes old resolved ones.
export const supportSweep = onSchedule("every 10 minutes", async () => {
  const limits = limitsOf((await db().collection("config").doc("support").get()).data());
  const now = Date.now();

  const waiting = await casesRef().where("awaitingStaff", "==", true).get();
  const overdue = waiting.docs.filter((doc) => {
    const state = readCase(doc.data());
    return state && isOverdue(state.kind, state.awaitingSince, now, limits);
  });
  const newlyOverdue = overdue.filter((doc) => doc.get("overdue") !== true);

  const cutoff = Timestamp.fromMillis(now - limits.autoCloseDays * 86_400_000);
  const resolved = await casesRef()
    .where("status", "==", "resolved")
    .where("resolvedAt", "<=", cutoff)
    .get();
  const toClose = resolved.docs.filter((doc) =>
    shouldAutoClose(readCase(doc.data())?.resolvedAt ?? null, now, limits),
  );

  const writes = [
    ...newlyOverdue.map((doc) => ({doc, update: {overdue: true, overdueAt: Timestamp.fromMillis(now)}, type: "overdue"})),
    ...toClose.map((doc) => ({doc, update: {status: "closed", closedAt: Timestamp.fromMillis(now)}, type: "auto_closed"})),
  ];
  for (let i = 0; i < writes.length; i += 200) {
    const batch = db().batch();
    for (const {doc, update, type} of writes.slice(i, i + 200)) {
      batch.update(doc.ref, {...update, updatedAt: FieldValue.serverTimestamp()});
      batch.set(doc.ref.collection("events").doc(), {
        type,
        by: "system",
        byName: "",
        at: FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
  }

  for (const doc of newlyOverdue) {
    await notify(
      [doc.get("assignedTo") ?? null],
      {title: "overdueCaseTitle", vars: {ref: String(doc.get("reference") ?? "")}, body: {text: String(doc.get("subject") ?? "")}},
      {kind: "support_overdue", caseId: doc.id},
    );
  }
  if (newlyOverdue.length > 0) {
    const admins = await db().collection("users").where("role", "==", "admin").get();
    await pushToUsers(
      admins.docs.map((d) => d.id),
      {title: "overdueTitle", vars: {count: String(overdue.length)}, body: "overdueBody"},
      {kind: "support_overdue"},
    );
  }
  logger.info("Support sweep", {waiting: waiting.size, overdue: overdue.length, newlyOverdue: newlyOverdue.length, closed: toClose.length});
});
