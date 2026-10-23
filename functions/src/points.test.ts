import assert from "node:assert/strict";
import {test} from "node:test";

import {
  CODE_LENGTH,
  DEFAULT_POINTS_CONFIG,
  LEVEL_IDS,
  dayKey,
  deviceFlags,
  earnsStreakBonus,
  feedbackEarnsPoints,
  feedbackOf,
  levelFor,
  levelsReached,
  newInviteCode,
  nextStreak,
  normalizeCode,
  pointsConfigOf,
  previousDay,
  referralOutcome,
  taskPoints,
} from "./points";
import {POINTS_MESSAGES, pointsText} from "./pointsMessages";

const config = DEFAULT_POINTS_CONFIG;
const DAY = 86_400_000;

test("config comes from the admin panel with safe defaults", () => {
  assert.deepEqual(pointsConfigOf(undefined), config);
  const custom = pointsConfigOf({
    dailyCheckin: 8,
    dailyActive: -5,
    streakDays: 1,
    levels: {ambassador: {minFriends: 3, bonus: 40}, champion: {minFriends: "x"}},
  });
  assert.equal(custom.dailyCheckin, 8);
  assert.equal(custom.dailyActive, config.dailyActive);
  assert.equal(custom.streakDays, config.streakDays);
  assert.deepEqual(custom.levels.find((l) => l.id === "ambassador"), {id: "ambassador", minFriends: 3, bonus: 40});
  assert.equal(custom.levels.find((l) => l.id === "champion")?.minFriends, 30);
  assert.equal(taskPoints(custom, "checkin"), 8);
  assert.equal(taskPoints(custom, "active"), config.dailyActive);
});

test("days follow Italian time", () => {
  assert.equal(dayKey(Date.UTC(2026, 9, 21, 22, 30)), "2026-10-22");
  assert.equal(dayKey(Date.UTC(2026, 9, 21, 21, 30)), "2026-10-21");
  assert.equal(previousDay("2026-03-01"), "2026-02-28");
  assert.equal(previousDay("2026-01-01"), "2025-12-31");
});

test("streaks grow on consecutive days and restart after a gap", () => {
  const first = nextStreak({lastDay: null, count: 0}, "2026-10-20");
  assert.deepEqual(first, {lastDay: "2026-10-20", count: 1});
  const second = nextStreak(first, "2026-10-21");
  assert.equal(second.count, 2);
  assert.equal(nextStreak(second, "2026-10-21"), second);
  assert.equal(nextStreak(second, "2026-10-23").count, 1);
});

test("the streak bonus comes every seventh day, once", () => {
  const six = {lastDay: "2026-10-20", count: 6};
  const seven = nextStreak(six, "2026-10-21");
  assert.ok(earnsStreakBonus(six, seven, config));
  assert.ok(!earnsStreakBonus(seven, nextStreak(seven, "2026-10-21"), config));
  assert.ok(!earnsStreakBonus(seven, nextStreak(seven, "2026-10-22"), config));
  assert.ok(earnsStreakBonus({lastDay: "2026-10-20", count: 13}, {lastDay: "2026-10-21", count: 14}, config));
});

test("ambassador levels", () => {
  assert.equal(levelFor(0, config), null);
  assert.equal(levelFor(1, config), "supporter");
  assert.equal(levelFor(14, config), "ambassador");
  assert.equal(levelFor(30, config), "champion");
  assert.deepEqual(levelsReached(4, 5, config).map((l) => l.id), ["ambassador"]);
  assert.deepEqual(levelsReached(5, 6, config), []);
  assert.deepEqual(levelsReached(0, 15, config).map((l) => l.id), ["supporter", "ambassador", "super_ambassador"]);
});

test("invite codes are short, readable and checked", () => {
  const code = newInviteCode();
  assert.equal(code.length, CODE_LENGTH);
  assert.equal(normalizeCode(` ${code.toLowerCase()} `), code);
  assert.equal(normalizeCode("ABC"), null);
  assert.equal(normalizeCode("ABCDE0"), null);
  assert.equal(normalizeCode(42), null);
});

test("device signals flag for review but never block on their own", () => {
  assert.deepEqual(deviceFlags("h1", ["h1"], false), ["same_device_as_inviter"]);
  assert.deepEqual(deviceFlags("h1", [], true), ["device_used_before"]);
  assert.deepEqual(deviceFlags(null, ["h1"], true), []);
  assert.deepEqual(deviceFlags("h2", ["h1"], false), []);
});

test("a friend qualifies after enough active days with a city, within the window", () => {
  const base = {activeDays: 3, hasCity: true, joinedAt: 0, now: 5 * DAY};
  assert.equal(referralOutcome(base, config), "qualify");
  assert.equal(referralOutcome({...base, activeDays: 2}, config), "wait");
  assert.equal(referralOutcome({...base, hasCity: false}, config), "wait");
  assert.equal(referralOutcome({...base, now: 15 * DAY}, config), "expire");
  assert.equal(referralOutcome({...base, activeDays: 1, now: 15 * DAY}, config), "expire");
});

test("points pushes exist in every language", () => {
  const keys = Object.keys(POINTS_MESSAGES.en);
  assert.equal(Object.keys(POINTS_MESSAGES).length, 10);
  for (const messages of Object.values(POINTS_MESSAGES)) {
    assert.deepEqual(Object.keys(messages), keys);
    for (const text of Object.values(messages)) assert.ok(text.trim().length > 0);
  }
  for (const level of LEVEL_IDS) assert.ok(keys.includes(`level_${level}`));
  assert.equal(pointsText("it", "referralBody", {points: "50"}), "+50 punti. Grazie per aiutare CodaMi a crescere!");
});

test("feedback needs 1 to 5 stars and a short comment", () => {
  assert.deepEqual(feedbackOf({rating: 4, comment: "  Great app "}), {rating: 4, comment: "Great app"});
  assert.deepEqual(feedbackOf({rating: 5}), {rating: 5, comment: ""});
  assert.equal(feedbackOf({rating: 0}), null);
  assert.equal(feedbackOf({rating: 6}), null);
  assert.equal(feedbackOf({rating: 3.5}), null);
  assert.equal(feedbackOf({rating: 3, comment: "x".repeat(1001)}), null);
  assert.equal(feedbackOf(null), null);
});

test("feedback earns points only after some days of use", () => {
  const config = pointsConfigOf({feedbackAfterDays: 5});
  assert.equal(feedbackEarnsPoints(0, 5 * DAY, config), true);
  assert.equal(feedbackEarnsPoints(0, 4 * DAY, config), false);
  assert.equal(feedbackEarnsPoints(0, 9 * DAY, pointsConfigOf({feedbackPoints: 0})), false);
  assert.equal(pointsConfigOf({reviewEveryDays: 5}).reviewEveryDays, 120);
});
