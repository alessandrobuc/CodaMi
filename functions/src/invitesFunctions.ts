import "./options";

import {createHash} from "node:crypto";

import {FieldValue, Timestamp, getFirestore, type DocumentSnapshot, type Query} from "firebase-admin/firestore";
import {HttpsError, onCall, onRequest} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";

import {SAFE_ID_PATTERN, readString} from "./places";
import {
  RANK_SORTS,
  addInvite,
  addOpens,
  dayKey,
  emptyInviteCounts,
  inviteBucket,
  isStillUsing,
  normalizeCode,
  periodOf,
  pointsConfigOf,
  rankInviters,
  shiftDay,
  type InviteCounts,
} from "./points";
import {oneOf} from "./support";
import {requireStaff} from "./supportFunctions";

const DAY_MS = 86_400_000;
const RANKING_SIZE = 100;
const ALREADY_EXISTS = 6;

const db = () => getFirestore();
const usersRef = () => db().collection("users");
const referralsRef = () => db().collection("referrals");
const opensRef = () => db().collection("inviteOpens");
const seenRef = () => db().collection("inviteOpenSeen");

async function stillUsingDays(): Promise<number> {
  return pointsConfigOf((await db().collection("config").doc("points").get()).data()).stillUsingDays;
}

async function usersById(ids: string[]): Promise<Map<string, DocumentSnapshot>> {
  const found = new Map<string, DocumentSnapshot>();
  const unique = [...new Set(ids)];
  for (let i = 0; i < unique.length; i += 100) {
    const snaps = await db().getAll(...unique.slice(i, i + 100).map((id) => usersRef().doc(id)));
    snaps.filter((s) => s.exists).forEach((s) => found.set(s.id, s));
  }
  return found;
}

const millisOf = (value: unknown) => value instanceof Timestamp ? value.toMillis() : null;
const lastDayOf = (user: DocumentSnapshot | undefined) => {
  const day = user?.get("activity")?.lastDay;
  return typeof day === "string" ? day : null;
};

// Opened by the invite page (hosting/invite.html) through the /api/invite-open rewrite.
// Each visitor counts once a day per code; only a daily hash is kept, never the IP.
export const trackInviteOpen = onRequest({maxInstances: 5}, async (req, res) => {
  res.set("Cache-Control", "no-store");
  if (req.method !== "POST") {
    res.status(405).end();
    return;
  }
  const body = typeof req.body === "object" && req.body !== null ? req.body as Record<string, unknown> : {};
  const code = normalizeCode(body.code);
  if (code) {
    const forwarded = String(req.headers["x-forwarded-for"] ?? "").split(",")[0].trim();
    const visitor = `${forwarded || req.ip || ""}|${req.headers["user-agent"] ?? ""}`;
    try {
      await countOpen(code, body.source === "qr" ? "qr" : "link", visitor);
    } catch (error) {
      logger.warn("Invite open not counted", {code, error});
    }
  }
  res.status(204).end();
});

async function countOpen(code: string, source: "qr" | "link", visitor: string): Promise<void> {
  const uid = (await db().collection("inviteCodes").doc(code).get()).get("uid");
  if (typeof uid !== "string") return;
  const day = dayKey(Date.now());
  const seenId = createHash("sha256").update(`${day}|${code}|${visitor}`).digest("hex");
  try {
    await seenRef().doc(seenId).create({day});
  } catch (error) {
    if ((error as {code?: unknown}).code === ALREADY_EXISTS) return;
    throw error;
  }
  await opensRef().doc(`${code}_${day}`).set({uid, code, day, [source]: FieldValue.increment(1)}, {merge: true});
}

// Called by the daily points sweep.
export async function sweepInviteOpenSeen(): Promise<number> {
  const yesterday = shiftDay(dayKey(Date.now()), -1);
  let removed = 0;
  for (;;) {
    const old = await seenRef().where("day", "<", yesterday).limit(400).get();
    if (old.empty) return removed;
    const batch = db().batch();
    old.docs.forEach((d) => batch.delete(d.ref));
    await batch.commit();
    removed += old.size;
  }
}

export async function deleteInviteOpens(uid: string): Promise<void> {
  const opens = await opensRef().where("uid", "==", uid).get();
  await Promise.all(opens.docs.map((d) => d.ref.delete()));
}

// One user's invites for the admin side: counts and the list of invited friends.
export const adminInviteStats = onCall(async (request) => {
  await requireStaff(request, true);
  const uid = readString(request.data, "uid", {min: 1, max: 128, pattern: SAFE_ID_PATTERN});
  const [days, user, referrals, opens] = await Promise.all([
    stillUsingDays(),
    usersRef().doc(uid).get(),
    referralsRef().where("inviterId", "==", uid).get(),
    opensRef().where("uid", "==", uid).get(),
  ]);
  const invitees = await usersById(referrals.docs.map((d) => d.id));
  const today = dayKey(Date.now());
  const counts = emptyInviteCounts();
  opens.docs.forEach((d) => addOpens(counts, d.data()));

  const friends = referrals.docs.map((d) => {
    const bucket = inviteBucket(d.get("status"));
    const lastDay = lastDayOf(invitees.get(d.id));
    const stillUsing = bucket === "active" && isStillUsing(lastDay, today, days);
    addInvite(counts, bucket, stillUsing);
    return {
      inviteeId: d.id,
      name: String(d.get("inviteeName") ?? ""),
      status: String(d.get("status") ?? "pending"),
      bucket,
      createdAt: millisOf(d.get("createdAt")),
      qualifiedAt: millisOf(d.get("qualifiedAt")),
      lastActiveDay: lastDay,
      stillUsing,
    };
  }).sort((a, b) => (b.createdAt ?? 0) - (a.createdAt ?? 0));

  return {code: user.get("inviteCode") ?? null, stillUsingDays: days, counts, friends};
});

// Totals for the whole app and the users who invited the most, for a period or all time.
export const adminInviteRanking = onCall(async (request) => {
  await requireStaff(request, true);
  const period = periodOf(request.data);
  if (!period) throw new HttpsError("invalid-argument", "Choose a valid period.");
  const sort = oneOf(RANK_SORTS, (request.data as {sort?: unknown} | null)?.sort) ?? "active";

  let referralQuery: Query = referralsRef();
  let opensQuery: Query = opensRef();
  if (period !== "all") {
    // Days are Italian days, so a little more is read and then filtered by day.
    referralQuery = referralQuery
      .where("createdAt", ">=", Timestamp.fromMillis(Date.parse(`${period.from}T00:00:00Z`) - DAY_MS))
      .where("createdAt", "<", Timestamp.fromMillis(Date.parse(`${period.to}T00:00:00Z`) + 2 * DAY_MS));
    opensQuery = opensQuery.where("day", ">=", period.from).where("day", "<=", period.to);
  }
  const [days, referrals, opens] = await Promise.all([stillUsingDays(), referralQuery.get(), opensQuery.get()]);

  const inPeriod = referrals.docs.filter((d) => {
    if (period === "all") return true;
    const created = millisOf(d.get("createdAt"));
    if (created === null) return false;
    const day = dayKey(created);
    return day >= period.from && day <= period.to;
  });
  const active = inPeriod.filter((d) => inviteBucket(d.get("status")) === "active");
  const invitees = await usersById(active.map((d) => d.id));
  const today = dayKey(Date.now());

  const rows = new Map<string, InviteCounts & {uid: string}>();
  const rowOf = (uid: string) => {
    if (!rows.has(uid)) rows.set(uid, {uid, ...emptyInviteCounts()});
    return rows.get(uid)!;
  };
  for (const d of inPeriod) {
    const inviterId = d.get("inviterId");
    if (typeof inviterId !== "string") continue;
    const bucket = inviteBucket(d.get("status"));
    addInvite(rowOf(inviterId), bucket, bucket === "active" && isStillUsing(lastDayOf(invitees.get(d.id)), today, days));
  }
  for (const d of opens.docs) {
    const uid = d.get("uid");
    if (typeof uid === "string") addOpens(rowOf(uid), d.data());
  }

  const totals = emptyInviteCounts();
  for (const row of rows.values()) {
    for (const key of Object.keys(totals) as (keyof InviteCounts)[]) totals[key] += row[key];
  }
  const top = rankInviters([...rows.values()], sort).slice(0, RANKING_SIZE);
  const inviters = await usersById(top.map((r) => r.uid));
  return {
    totals,
    inviters: rows.size,
    stillUsingDays: days,
    rows: top
      .filter((r) => inviters.has(r.uid))
      .map((r) => {
        const user = inviters.get(r.uid)!;
        return {
          ...r,
          name: String(user.get("name") ?? "").trim(),
          email: String(user.get("email") ?? ""),
          code: user.get("inviteCode") ?? null,
        };
      }),
  };
});
