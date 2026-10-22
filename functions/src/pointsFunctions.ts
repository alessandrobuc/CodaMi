import "./options";

import {createHash} from "node:crypto";

import {getAuth} from "firebase-admin/auth";
import {FieldValue, Timestamp, getFirestore, type Transaction} from "firebase-admin/firestore";
import {HttpsError, onCall, type CallableRequest} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";
import {onSchedule} from "firebase-functions/scheduler";

import {SAFE_ID_PATTERN, readString} from "./places";
import {
  DAILY_TASKS,
  dayKey,
  deviceFlags,
  earnsStreakBonus,
  levelFor,
  levelsReached,
  newInviteCode,
  nextStreak,
  normalizeCode,
  pointsConfigOf,
  referralOutcome,
  taskPoints,
  type FraudFlag,
  type PointAction,
  type PointsConfig,
} from "./points";
import {pointsText} from "./pointsMessages";
import {oneOf} from "./support";
import {requireStaff} from "./supportFunctions";
import {pushToUsers} from "./userPush";

const DAY_MS = 86_400_000;
const MAX_INSTALL_HASHES = 5;
const INSTALL_ID_PATTERN = /^[A-Za-z0-9-]{16,64}$/;

const db = () => getFirestore();
const usersRef = () => db().collection("users");
const referralsRef = () => db().collection("referrals");

function requireUid(request: CallableRequest): string {
  if (!request.auth) throw new HttpsError("unauthenticated", "Please sign in again.");
  return request.auth.uid;
}

async function loadConfig(): Promise<PointsConfig> {
  return pointsConfigOf((await db().collection("config").doc("points").get()).data());
}

// Only a hash of the random install ID is kept, never the ID itself.
function installHashOf(value: unknown): string | null {
  return typeof value === "string" && INSTALL_ID_PATTERN.test(value) ?
    createHash("sha256").update(value).digest("hex") :
    null;
}

interface Award {
  uid: string;
  action: PointAction;
  key: string;
  points: number;
  note?: string;
}

// Each award has a fixed ledger ID, so the same award can never count twice.
// Firestore wants every read before the first write, so callers finish their reads first.
async function awardInTx(tx: Transaction, awards: Award[]): Promise<Award[]> {
  const wanted = awards.filter((a) => a.points !== 0);
  const refs = wanted.map((a) => usersRef().doc(a.uid).collection("pointsLedger").doc(`${a.action}_${a.key}`));
  const snaps = await Promise.all(refs.map((ref) => tx.get(ref)));
  const given = wanted.filter((_, i) => !snaps[i].exists);
  given.forEach((award) => {
    tx.set(refs[wanted.indexOf(award)], {
      action: award.action,
      points: award.points,
      ...(award.note ? {note: award.note} : {}),
      createdAt: FieldValue.serverTimestamp(),
    });
    tx.set(usersRef().doc(award.uid), {points: FieldValue.increment(award.points)}, {merge: true});
  });
  return given;
}

// Called by the app once a day. Counts active days and remembers recent install IDs.
export const registerVisit = onCall(async (request) => {
  const uid = requireUid(request);
  const today = dayKey(Date.now());
  const installHash = installHashOf((request.data as {installId?: unknown} | null)?.installId);

  await db().runTransaction(async (tx) => {
    const user = await tx.get(usersRef().doc(uid));
    if (!user.exists) return;
    const activity = user.get("activity") ?? {};
    const hashes: string[] = Array.isArray(user.get("installHashes")) ? user.get("installHashes") : [];
    const update: Record<string, unknown> = {};
    if (activity.lastDay !== today) {
      update.activity = {lastDay: today, days: (activity.days ?? 0) + 1};
    }
    if (installHash && !hashes.includes(installHash)) {
      update.installHashes = [...hashes, installHash].slice(-MAX_INSTALL_HASHES);
    }
    if (Object.keys(update).length > 0) tx.update(user.ref, update);
  });

  await evaluateReferral(uid);
  return {day: today};
});

export const claimDailyTask = onCall(async (request) => {
  const uid = requireUid(request);
  const task = oneOf(DAILY_TASKS, (request.data as {task?: unknown} | null)?.task);
  if (!task) throw new HttpsError("invalid-argument", "Unknown task.");
  const config = await loadConfig();
  const points = taskPoints(config, task);
  if (points === 0) throw new HttpsError("failed-precondition", "This task is turned off.");
  const today = dayKey(Date.now());

  return db().runTransaction(async (tx) => {
    const user = await tx.get(usersRef().doc(uid));
    if (!user.exists || user.get("disabled") === true) {
      throw new HttpsError("permission-denied", "This account can't earn points.");
    }
    const daily = user.get("daily") ?? {};
    const claimed: string[] = daily.day === today && Array.isArray(daily.claimed) ? daily.claimed : [];
    if (claimed.includes(task)) throw new HttpsError("already-exists", "Already claimed today.");

    const previous = {lastDay: daily.streakDay ?? null, count: daily.streak ?? 0};
    const streak = nextStreak(previous, today);
    const bonus = earnsStreakBonus(previous, streak, config) ? config.streakBonus : 0;
    await awardInTx(tx, [
      {uid, action: task === "checkin" ? "daily_checkin" : "daily_active", key: today, points},
      {uid, action: "streak_bonus", key: today, points: bonus},
    ]);
    tx.update(user.ref, {
      daily: {day: today, claimed: [...claimed, task], streak: streak.count, streakDay: streak.lastDay},
    });
    return {points, bonus, streak: streak.count};
  });
});

export const getInviteCode = onCall(async (request) => {
  const uid = requireUid(request);
  const existing = (await usersRef().doc(uid).get()).get("inviteCode");
  if (typeof existing === "string") return {code: existing};
  for (let attempt = 0; attempt < 5; attempt++) {
    const code = newInviteCode();
    const created = await db().runTransaction(async (tx) => {
      const codeRef = db().collection("inviteCodes").doc(code);
      const [taken, user] = await Promise.all([tx.get(codeRef), tx.get(usersRef().doc(uid))]);
      if (typeof user.get("inviteCode") === "string") return user.get("inviteCode") as string;
      if (taken.exists) return null;
      tx.set(codeRef, {uid, createdAt: FieldValue.serverTimestamp()});
      tx.update(user.ref, {inviteCode: code});
      return code;
    });
    if (created) return {code: created};
  }
  throw new HttpsError("unavailable", "Please try again.");
});

// Stops guessing random codes; a real code typed wrong a few times is fine.
const MAX_FAILED_CODES_PER_DAY = 10;

export const redeemInviteCode = onCall(async (request) => {
  const uid = requireUid(request);
  const code = normalizeCode((request.data as {code?: unknown} | null)?.code);
  if (!code) throw new HttpsError("invalid-argument", "This code isn't valid.");
  const config = await loadConfig();

  const joinedAt = Date.parse((await getAuth().getUser(uid)).metadata.creationTime);
  if (Date.now() - joinedAt > config.codeEntryDays * DAY_MS) {
    throw new HttpsError("failed-precondition", "Invite codes can only be added soon after signing up.",
      {reason: "too_late", days: config.codeEntryDays});
  }
  const today = dayKey(Date.now());
  const tries = (await usersRef().doc(uid).get()).get("inviteTries");
  const failedToday = tries?.day === today ? Number(tries.count) || 0 : 0;
  if (failedToday >= MAX_FAILED_CODES_PER_DAY) {
    throw new HttpsError("resource-exhausted", "Too many wrong codes today. Try again tomorrow.");
  }
  const notFound = async (): Promise<never> => {
    await usersRef().doc(uid).update({inviteTries: {day: today, count: failedToday + 1}});
    throw new HttpsError("not-found", "This code doesn't exist.");
  };

  const codeDoc = await db().collection("inviteCodes").doc(code).get();
  const inviterId = codeDoc.get("uid");
  if (typeof inviterId !== "string") return notFound();
  if (inviterId === uid) {
    throw new HttpsError("failed-precondition", "You can't use your own code.", {reason: "own_code"});
  }
  const inviter = await usersRef().doc(inviterId).get();
  if (!inviter.exists || inviter.get("disabled") === true) return notFound();

  const installHash = installHashOf((request.data as {installId?: unknown}).installId);
  const sameDevice = installHash ?
    (await referralsRef().where("installHash", "==", installHash).limit(2).get()).docs.some((d) => d.id !== uid) :
    false;
  const inviterHashes = Array.isArray(inviter.get("installHashes")) ? inviter.get("installHashes") : [];
  const flags = deviceFlags(installHash, inviterHashes, sameDevice);

  await db().runTransaction(async (tx) => {
    const referralRef = referralsRef().doc(uid);
    const [referral, user] = await Promise.all([tx.get(referralRef), tx.get(usersRef().doc(uid))]);
    if (referral.exists || user.get("referredBy")) {
      throw new HttpsError("already-exists", "You already used an invite code.");
    }
    await awardInTx(tx, [{uid, action: "referral_welcome", key: "welcome", points: config.referralWelcome}]);
    tx.set(referralRef, {
      inviterId,
      inviteeId: uid,
      inviteeName: String(user.get("name") ?? "").trim().split(/\s+/)[0].slice(0, 40),
      code,
      status: "pending",
      flags,
      installHash,
      joinedAt: Timestamp.fromMillis(joinedAt),
      createdAt: FieldValue.serverTimestamp(),
    });
    tx.update(user.ref, {referredBy: inviterId});
  });
  logger.info("Invite code used", {uid, inviterId, flags});

  await evaluateReferral(uid);
  return {inviterName: String(inviter.get("name") ?? "").trim().split(/\s+/)[0]};
});

// Waits until the friend is really using the app, then rewards the inviter (or asks an admin first).
async function evaluateReferral(inviteeId: string): Promise<void> {
  const referral = await referralsRef().doc(inviteeId).get();
  if (referral.get("status") !== "pending") return;
  const invitee = await usersRef().doc(inviteeId).get();
  if (!invitee.exists || invitee.get("disabled") === true) return;
  const config = await loadConfig();
  const outcome = referralOutcome({
    activeDays: invitee.get("activity")?.days ?? 0,
    hasCity: typeof invitee.get("cityKey") === "string" && invitee.get("cityKey") !== "",
    joinedAt: (referral.get("joinedAt") as Timestamp).toMillis(),
    now: Date.now(),
  }, config);
  if (outcome === "wait") return;
  if (outcome === "expire") {
    await referral.ref.update({status: "expired", closedAt: FieldValue.serverTimestamp()});
    return;
  }

  const inviterId = referral.get("inviterId") as string;
  const recent = await referralsRef()
    .where("inviterId", "==", inviterId)
    .where("qualifiedAt", ">=", Timestamp.fromMillis(Date.now() - DAY_MS))
    .count()
    .get();
  const flags: FraudFlag[] = [...(referral.get("flags") ?? [])];
  if (recent.data().count >= config.maxQualifiedPerDay) flags.push("burst");
  if (flags.length > 0) {
    await referral.ref.update({status: "review", flags, reviewSince: FieldValue.serverTimestamp()});
    await alertAdminsAboutReviews();
    return;
  }
  await qualifyReferral(inviteeId, null);
}

async function qualifyReferral(inviteeId: string, reviewer: string | null): Promise<void> {
  const config = await loadConfig();
  const result = await db().runTransaction(async (tx) => {
    const referralRef = referralsRef().doc(inviteeId);
    const referral = await tx.get(referralRef);
    if (!["pending", "review"].includes(referral.get("status"))) return null;
    const inviterRef = usersRef().doc(referral.get("inviterId"));
    const inviter = await tx.get(inviterRef);
    if (!inviter.exists) return null;
    const before = inviter.get("referralCount") ?? 0;
    const after = before + 1;
    const levels = levelsReached(before, after, config);
    const given = await awardInTx(tx, [
      {uid: inviter.id, action: "referral_qualified", key: inviteeId, points: config.referralQualified},
      ...levels.map((level) => ({uid: inviter.id, action: "level_bonus" as const, key: level.id, points: level.bonus})),
    ]);
    tx.update(referralRef, {
      status: "qualified",
      qualifiedAt: FieldValue.serverTimestamp(),
      ...(reviewer ? {reviewedBy: reviewer} : {}),
    });
    tx.update(inviterRef, {referralCount: after, ambassadorLevel: levelFor(after, config)});
    return {inviterId: inviter.id, given};
  });
  if (!result) return;

  for (const award of result.given) {
    const points = String(award.points);
    if (award.action === "referral_qualified") {
      await pushToUsers([result.inviterId], {
        title: (lang) => pointsText(lang, "referralTitle"),
        body: (lang) => pointsText(lang, "referralBody", {points}),
      }, {kind: "points"}, null);
    } else {
      const levelKey = `level_${award.key}` as Parameters<typeof pointsText>[1];
      await pushToUsers([result.inviterId], {
        title: (lang) => pointsText(lang, "levelTitle", {level: pointsText(lang, levelKey)}),
        body: (lang) => pointsText(lang, "levelBody", {points}),
      }, {kind: "points"}, null);
    }
  }
}

async function alertAdminsAboutReviews(): Promise<void> {
  const waiting = await referralsRef().where("status", "==", "review").count().get();
  const admins = await usersRef().where("role", "==", "admin").get();
  const count = String(waiting.data().count);
  await pushToUsers(admins.docs.map((d) => d.id), {
    title: (lang) => pointsText(lang, "reviewTitle"),
    body: (lang) => pointsText(lang, "reviewBody", {count}),
  }, {kind: "referral_review"}, null);
}

export const adminReviewReferral = onCall(async (request) => {
  const admin = await requireStaff(request, true);
  const inviteeId = readString(request.data, "inviteeId", {min: 1, max: 128, pattern: SAFE_ID_PATTERN});
  const approve = (request.data as {approve?: unknown}).approve;
  if (typeof approve !== "boolean") throw new HttpsError("invalid-argument", "Missing decision.");
  const referral = await referralsRef().doc(inviteeId).get();
  if (referral.get("status") !== "review") {
    throw new HttpsError("failed-precondition", "This invite is not waiting for a review.");
  }
  if (approve) {
    await qualifyReferral(inviteeId, admin.uid);
  } else {
    await referral.ref.update({status: "rejected", reviewedBy: admin.uid, closedAt: FieldValue.serverTimestamp()});
  }
  return {status: approve ? "qualified" : "rejected"};
});

export const adminAdjustPoints = onCall(async (request) => {
  const admin = await requireStaff(request, true);
  const uid = readString(request.data, "uid", {min: 1, max: 128, pattern: SAFE_ID_PATTERN});
  const amount = (request.data as {amount?: unknown}).amount;
  if (typeof amount !== "number" || !Number.isInteger(amount) || amount === 0 || Math.abs(amount) > 100_000) {
    throw new HttpsError("invalid-argument", "Enter a whole number of points.");
  }
  const reason = readString(request.data, "reason", {min: 1, max: 200});
  await db().runTransaction(async (tx) => {
    const user = await tx.get(usersRef().doc(uid));
    if (!user.exists) throw new HttpsError("not-found", "This user no longer exists.");
    await awardInTx(tx, [{uid, action: "manual", key: `${Date.now()}_${admin.uid}`, points: amount, note: reason}]);
  });
  logger.info("Points adjusted", {uid, amount, by: admin.uid});
  return {ok: true};
});

// Invites whose friend never became active in time are closed once a day.
export const pointsSweep = onSchedule("every day 04:00", async () => {
  const config = await loadConfig();
  const cutoff = Timestamp.fromMillis(Date.now() - config.qualifyWithinDays * DAY_MS);
  const old = await referralsRef().where("status", "==", "pending").where("joinedAt", "<=", cutoff).limit(500).get();
  for (const doc of old.docs) await evaluateReferral(doc.id);
  logger.info("Points sweep", {checked: old.size});
});

// Used by account deletion. The ledger goes with the user document.
export async function deletePointsData(uid: string): Promise<void> {
  const [asInviter, codes] = await Promise.all([
    referralsRef().where("inviterId", "==", uid).get(),
    db().collection("inviteCodes").where("uid", "==", uid).get(),
  ]);
  await Promise.all([
    referralsRef().doc(uid).delete(),
    ...asInviter.docs.map((d) => d.ref.delete()),
    ...codes.docs.map((d) => d.ref.delete()),
  ]);
}
