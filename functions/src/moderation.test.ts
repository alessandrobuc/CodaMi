import assert from "node:assert/strict";
import {test} from "node:test";

import {
  DEFAULT_MODERATION_LIMITS,
  checkIdOf,
  classify,
  downloadUrlOf,
  moderationLimitsOf,
  pathOfUrl,
  photoOwnerOf,
  quarantinePathOf,
  readScores,
  withoutPath,
  type Scores,
} from "./moderation";
import {MODERATION_MESSAGES, moderationText} from "./moderationMessages";

const safe: Scores = {
  adult: "VERY_UNLIKELY",
  racy: "UNLIKELY",
  violence: "UNLIKELY",
  medical: "UNLIKELY",
  spoof: "UNLIKELY",
};
const limits = DEFAULT_MODERATION_LIMITS;

test("safe photos are clear", () => {
  assert.deepEqual(classify(safe, limits), {result: "clear", reason: null, level: null});
});

test("very likely adult content is blocked", () => {
  assert.deepEqual(classify({...safe, adult: "VERY_LIKELY"}, limits), {
    result: "blocked",
    reason: "adult",
    level: "VERY_LIKELY",
  });
});

test("possible adult and likely racy content go to review", () => {
  assert.equal(classify({...safe, adult: "POSSIBLE"}, limits).result, "review");
  assert.equal(classify({...safe, adult: "LIKELY"}, limits).reason, "adult");
  assert.equal(classify({...safe, racy: "POSSIBLE"}, limits).result, "clear");
  assert.deepEqual(classify({...safe, racy: "LIKELY"}, limits), {
    result: "review",
    reason: "racy",
    level: "LIKELY",
  });
});

test("violence is only reviewed, never blocked, and medical is ignored", () => {
  assert.equal(classify({...safe, violence: "LIKELY"}, limits).result, "clear");
  assert.deepEqual(classify({...safe, violence: "VERY_LIKELY"}, limits), {
    result: "review",
    reason: "violence",
    level: "VERY_LIKELY",
  });
  assert.equal(classify({...safe, medical: "VERY_LIKELY", spoof: "VERY_LIKELY"}, limits).result, "clear");
});

test("adult content wins over other reasons", () => {
  assert.equal(classify({...safe, adult: "LIKELY", violence: "VERY_LIKELY"}, limits).reason, "adult");
});

test("limits come from config with safe defaults", () => {
  assert.deepEqual(moderationLimitsOf(undefined), limits);
  const custom = moderationLimitsOf({reviewViolence: "LIKELY", reviewRacy: "UNKNOWN", blockAdult: "nope"});
  assert.equal(custom.reviewViolence, "LIKELY");
  assert.equal(custom.reviewRacy, limits.reviewRacy);
  assert.equal(custom.blockAdult, limits.blockAdult);
  assert.equal(classify({...safe, violence: "LIKELY"}, custom).result, "review");
});

test("readScores fills missing categories with UNKNOWN", () => {
  assert.equal(readScores(null), null);
  assert.deepEqual(readScores({adult: "LIKELY", racy: "weird"}), {
    adult: "LIKELY",
    racy: "UNKNOWN",
    violence: "UNKNOWN",
    medical: "UNKNOWN",
    spoof: "UNKNOWN",
  });
});

test("only user photo paths are checked", () => {
  assert.deepEqual(photoOwnerOf("pets/u1/pet1/1_0.jpg"), {folder: "pets", ownerId: "u1"});
  assert.deepEqual(photoOwnerOf("reports/u1/r1/1_0.png"), {folder: "reports", ownerId: "u1"});
  assert.deepEqual(photoOwnerOf("pets/u1/1_0.jpg"), {folder: "pets", ownerId: "u1"});
  assert.equal(photoOwnerOf("quarantine/pets/u1/pet1/1_0.jpg"), null);
  assert.deepEqual(photoOwnerOf("emergencies/u1/e1/1_0.jpg"), {folder: "emergencies", ownerId: "u1"});
  assert.equal(photoOwnerOf("videos/v1/thumbnail.jpg"), null);
  assert.equal(photoOwnerOf("pets/u1"), null);
  assert.equal(photoOwnerOf("pets//1.jpg"), null);
  assert.equal(photoOwnerOf("pets/u1/pet1/"), null);
  assert.equal(quarantinePathOf("pets/u1/1_0.jpg"), "quarantine/pets/u1/1_0.jpg");
});

test("check IDs are stable and safe for Firestore", () => {
  const id = checkIdOf("pets/u1/1_0.jpg");
  assert.equal(id, checkIdOf("pets/u1/1_0.jpg"));
  assert.notEqual(id, checkIdOf("pets/u1/1_1.jpg"));
  assert.match(id, /^[a-f0-9]{40}$/);
});

test("download links map back to their storage path", () => {
  const url = "https://firebasestorage.googleapis.com/v0/b/app.firebasestorage.app/o/pets%2Fu1%2F1_0.jpg?alt=media&token=abc";
  assert.equal(pathOfUrl(url), "pets/u1/1_0.jpg");
  assert.equal(pathOfUrl("https://example.com/photo.jpg"), null);
  assert.equal(pathOfUrl(42), null);
});

test("download links are rebuilt from the token", () => {
  const url = downloadUrlOf("app.firebasestorage.app", "pets/u1/p1/1_0.jpg", "abc,def");
  assert.equal(url, "https://firebasestorage.googleapis.com/v0/b/app.firebasestorage.app/o/pets%2Fu1%2Fp1%2F1_0.jpg?alt=media&token=abc");
  assert.equal(pathOfUrl(url), "pets/u1/p1/1_0.jpg");
  assert.equal(downloadUrlOf("b", "pets/u1/p1/1_0.jpg", undefined), null);
});

test("withoutPath removes only the matching photo", () => {
  const a = "https://x/o/pets%2Fu1%2Fa.jpg?alt=media";
  const b = "https://x/o/pets%2Fu1%2Fb.jpg?alt=media";
  assert.deepEqual(withoutPath([a, b], "pets/u1/a.jpg"), [b]);
  assert.equal(withoutPath([a, b], "pets/u1/c.jpg"), null);
  assert.equal(withoutPath("nope", "pets/u1/a.jpg"), null);
});

test("moderation pushes exist in every language", () => {
  const keys = Object.keys(MODERATION_MESSAGES.en);
  assert.equal(Object.keys(MODERATION_MESSAGES).length, 10);
  for (const messages of Object.values(MODERATION_MESSAGES)) {
    assert.deepEqual(Object.keys(messages), keys);
    for (const text of Object.values(messages)) assert.ok(text.trim().length > 0);
  }
  assert.equal(moderationText("it", "reviewBody", {count: "3"}), "3 foto aspettano la decisione di un moderatore.");
  assert.equal(moderationText("xx", "removedTitle"), "Photo removed");
});
