import "./options";

import {FieldValue, Timestamp, getFirestore, type QueryDocumentSnapshot} from "firebase-admin/firestore";
import {HttpsError, onCall} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";

import {dayKey, pointsConfigOf} from "./points";
import {awardInTx} from "./pointsLedger";
import {requireStaff} from "./supportFunctions";
import {
  CLEAN_DAYS, bonusAwards, donationOf, earnedLevels, effectiveLevels, grantOf, idsOf, levelsOf, newUnlocks,
  nextShareCount, prefsOf, publicTitles, titlesConfigOf, unlockText,
  type Counts, type Levels, type Standing, type TitleId, type TitlesConfig,
} from "./titles";
import {pushToUsers} from "./userPush";

const db = () => getFirestore();
const achievements = () => db().collection("achievements");
const publicProfiles = () => db().collection("publicProfiles");
const donations = () => db().collection("donations");

async function loadConfigs(): Promise<{config: TitlesConfig; ambassadorMins: number[]}> {
  const [titles, points] = await Promise.all([
    db().collection("config").doc("titles").get(),
    db().collection("config").doc("points").get(),
  ]);
  return {
    config: titlesConfigOf(titles.data()),
    ambassadorMins: pointsConfigOf(points.data()).levels.map((l) => l.minFriends),
  };
}

const daysAgo = (t: unknown) =>
  t instanceof Timestamp ? (Date.now() - t.toMillis()) / 86_400_000 : Infinity;

// Everything is counted from the real records, so removed or hidden items drop out.
// Only plain lookups by user, so no extra database indexes are needed.
async function countsOf(uid: string): Promise<{counts: Omit<Counts, "shares">; standing: Standing} | null> {
  const emergencies = db().collection("emergencies");
  const [user, sitter, reports, owned, helped, feedback, removed, given] = await Promise.all([
    db().collection("users").doc(uid).get(),
    db().collection("sitters").doc(uid).get(),
    db().collection("reports").where("ownerId", "==", uid).select("type", "status", "updatedAt").get(),
    emergencies.where("ownerId", "==", uid).select("status").get(),
    emergencies.where("helpers", "array-contains", uid).select("status").get(),
    db().collection("feedback").where("uid", "==", uid).select("status").get(),
    db().collection("photoChecks").where("ownerId", "==", uid).where("status", "==", "removed").get(),
    donations().where("uid", "==", uid).select("cents").get(),
  ]);
  if (!user.exists) return null;
  const resolved = (docs: QueryDocumentSnapshot[]) => docs.filter((d) => d.get("status") === "resolved").length;
  const hidden = reports.docs.filter((d) => d.get("status") === "hidden");
  const recentlyRemoved =
    hidden.some((d) => daysAgo(d.get("updatedAt")) <= CLEAN_DAYS) ||
    removed.docs.some((d) => daysAgo(d.get("reviewedAt")) <= CLEAN_DAYS);
  const sitterShown = sitter.exists && sitter.get("hidden") !== true;
  const reviews = Number(sitter.get("reviewCount") ?? 0);
  return {
    counts: {
      reports: reports.size - hidden.length,
      rescues:
        reports.docs.filter((d) => d.get("type") === "found" && d.get("status") === "resolved").length +
        resolved(owned.docs) + resolved(helped.docs),
      helps: helped.size,
      feedbackDone: feedback.docs.filter((d) => d.get("status") === "done").length,
      activeDays: Number(user.get("activity")?.days ?? 0),
      sittings: sitterShown ? Number(sitter.get("completedCount") ?? 0) : 0,
      invites: Number(user.get("referralCount") ?? 0),
      donorCents: given.docs.reduce((sum, d) => sum + (Number(d.get("cents")) || 0), 0),
    },
    standing: {
      clean: user.get("disabled") !== true && !recentlyRemoved,
      sitterRating: sitterShown && reviews > 0 ? Number(sitter.get("ratingSum") ?? 0) / reviews : null,
    },
  };
}

function publicDoc(levels: Levels, main: TitleId | null, hideDonor: boolean, ambassadorLevels: number) {
  const pub = publicTitles(levels, main, hideDonor, ambassadorLevels);
  return {title: pub.title, tags: pub.tags, updatedAt: FieldValue.serverTimestamp()};
}

// Counts again, saves the titles, gives bonus points once per level and tells the user.
export async function refreshTitles(uid: string): Promise<void> {
  try {
    const [{config, ambassadorMins}, found] = await Promise.all([loadConfigs(), countsOf(uid)]);
    if (!found) return;
    const unlocks = await db().runTransaction(async (tx) => {
      const ref = achievements().doc(uid);
      const snap = await tx.get(ref);
      const counts: Counts = {...found.counts, shares: Number(snap.get("shares") ?? 0)};
      const before = levelsOf(snap.get("levels"));
      const earned = earnedLevels(counts, found.standing, config, ambassadorMins, levelsOf(snap.get("earned")));
      const levels = effectiveLevels(earned, levelsOf(snap.get("granted")), idsOf(snap.get("revoked")), config,
        ambassadorMins.length);
      const paid = levelsOf(snap.get("paid"));
      if (config.enabled) {
        await awardInTx(tx, bonusAwards(paid, earned, config).map((a) => ({uid, action: "title" as const, ...a})));
        for (const [id, level] of Object.entries(earned) as [TitleId, number][]) {
          paid[id] = Math.max(paid[id] ?? 0, level);
        }
      }
      const unlocked = {...(snap.get("unlockedAt") ?? {})} as Record<string, unknown>;
      const fresh = newUnlocks(before, levels);
      for (const u of fresh) unlocked[`${u.id}_${u.level}`] ??= FieldValue.serverTimestamp();
      tx.set(ref, {counts, earned, levels, paid, unlockedAt: unlocked, refreshedAt: FieldValue.serverTimestamp()},
        {mergeFields: ["counts", "earned", "levels", "paid", "unlockedAt", "refreshedAt"]});
      tx.set(publicProfiles().doc(uid),
        publicDoc(levels, snap.get("main") ?? null, snap.get("hideDonor") === true, ambassadorMins.length));
      return fresh;
    });
    if (config.enabled && unlocks.length > 0) {
      await pushToUsers([uid], {
        title: (lang) => unlockText(lang, unlocks).title,
        body: (lang) => unlockText(lang, unlocks).body,
      }, {kind: "title_unlocked"}, null);
    }
  } catch (error) {
    logger.warn("Titles not refreshed", {uid, error});
  }
}

export async function refreshMany(uids: string[]): Promise<void> {
  for (const uid of new Set(uids.filter((u) => typeof u === "string" && u))) await refreshTitles(uid);
}

// A share counts a few times a day at most.
export async function countShare(uid: string): Promise<void> {
  try {
    const today = dayKey(Date.now());
    const counted = await db().runTransaction(async (tx) => {
      const ref = achievements().doc(uid);
      const snap = await tx.get(ref);
      const next = nextShareCount(snap.get("shareDay"), snap.get("shareDayCount"), today);
      if (next === null) return false;
      tx.set(ref, {shares: FieldValue.increment(1), shareDay: today, shareDayCount: next}, {merge: true});
      return true;
    });
    if (counted) await refreshTitles(uid);
  } catch (error) {
    logger.warn("Share not counted for titles", {uid, error});
  }
}

// The achievements screen asks for a fresh count when it opens.
export const refreshMyTitles = onCall(async (request) => {
  if (!request.auth) throw new HttpsError("unauthenticated", "Please sign in again.");
  const uid = request.auth.uid;
  const last = (await achievements().doc(uid).get()).get("refreshedAt");
  if (!(last instanceof Timestamp) || Date.now() - last.toMillis() > 30_000) {
    await refreshTitles(uid);
  }
  return {ok: true};
});

export const setTitlePrefs = onCall(async (request) => {
  if (!request.auth) throw new HttpsError("unauthenticated", "Please sign in again.");
  const uid = request.auth.uid;
  const prefs = prefsOf(request.data);
  if (!prefs) throw new HttpsError("invalid-argument", "Unknown title.");
  const {ambassadorMins} = await loadConfigs();
  await db().runTransaction(async (tx) => {
    const ref = achievements().doc(uid);
    const levels = levelsOf((await tx.get(ref)).get("levels"));
    if (prefs.main && !levels[prefs.main]) throw new HttpsError("failed-precondition", "This title is still locked.");
    tx.set(ref, {main: prefs.main, hideDonor: prefs.hideDonor}, {merge: true});
    tx.set(publicProfiles().doc(uid), publicDoc(levels, prefs.main, prefs.hideDonor, ambassadorMins.length));
  });
  return {ok: true};
});

// Admins give a title by hand (level > 0), take it away (0) or allow it again (null).
export const adminSetTitle = onCall(async (request) => {
  const admin = await requireStaff(request, true);
  const {ambassadorMins} = await loadConfigs();
  const input = grantOf(request.data, ambassadorMins.length);
  if (!input) throw new HttpsError("invalid-argument", "Unknown title or level.");
  await db().runTransaction(async (tx) => {
    const ref = achievements().doc(input.uid);
    const snap = await tx.get(ref);
    const granted = levelsOf(snap.get("granted"));
    const revoked = new Set(idsOf(snap.get("revoked")));
    if (input.level === null) revoked.delete(input.id);
    else if (input.level === 0) {
      revoked.add(input.id);
      delete granted[input.id];
    } else {
      revoked.delete(input.id);
      granted[input.id] = input.level;
    }
    tx.set(ref, {granted, revoked: [...revoked]}, {mergeFields: ["granted", "revoked"]});
  });
  await refreshTitles(input.uid);
  logger.info("Title changed by admin", {...input, by: admin.uid});
  return {ok: true};
});

// For donations made outside the app (bank transfer, PayPal, events).
export const adminRecordDonation = onCall(async (request) => {
  const admin = await requireStaff(request, true);
  const input = donationOf(request.data);
  if (!input) throw new HttpsError("invalid-argument", "Check the user and the amount.");
  if (!(await db().collection("users").doc(input.uid).get()).exists) {
    throw new HttpsError("not-found", "This user no longer exists.");
  }
  const ref = await donations().add({
    ...input,
    source: "manual",
    by: admin.uid,
    day: dayKey(Date.now()),
    createdAt: FieldValue.serverTimestamp(),
  });
  await refreshTitles(input.uid);
  logger.info("Donation recorded", {uid: input.uid, cents: input.cents, by: admin.uid});
  return {id: ref.id};
});

export const adminDeleteDonation = onCall(async (request) => {
  const admin = await requireStaff(request, true);
  const id = (request.data as {id?: unknown} | null)?.id;
  if (typeof id !== "string" || !/^[A-Za-z0-9_-]{1,64}$/.test(id)) throw new HttpsError("invalid-argument", "Unknown donation.");
  const doc = await donations().doc(id).get();
  if (!doc.exists) throw new HttpsError("not-found", "This donation no longer exists.");
  await doc.ref.delete();
  await refreshTitles(doc.get("uid"));
  logger.info("Donation deleted", {id, by: admin.uid});
  return {ok: true};
});

export async function deleteTitlesData(uid: string): Promise<void> {
  const given = await donations().where("uid", "==", uid).get();
  await Promise.all([
    achievements().doc(uid).delete(),
    publicProfiles().doc(uid).delete(),
    ...given.docs.map((d) => d.ref.delete()),
  ]);
}

