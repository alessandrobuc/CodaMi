import assert from "node:assert/strict";
import {test} from "node:test";

import {
  DEFAULT_LEVELS, bonusAwards, donationOf, donorLevel, earnedLevels, effectiveLevels, grantOf, levelFor, newUnlocks,
  nextShareCount, prefsOf, publicTitles, titleName, titlesConfigOf, unlockText, type Counts,
} from "./titles";

const config = titlesConfigOf({enabled: true});
const mins = [1, 5, 15, 30];
const none: Counts = {
  reports: 0, rescues: 0, helps: 0, shares: 0, feedbackDone: 0, activeDays: 0, sittings: 0, invites: 0, donorCents: 0,
};
const clean = {clean: true, sitterRating: null};

test("settings fall back to the agreed numbers", () => {
  const c = titlesConfigOf(undefined);
  assert.equal(c.enabled, false, "off until the admin switches it on");
  assert.deepEqual(c.levels, DEFAULT_LEVELS);
  assert.deepEqual(c.bonus, [10, 25, 50]);
  assert.deepEqual(c.donorCents, [1000, 2500, 5000, 10000, 25000]);
  const odd = titlesConfigOf({levels: {rescuer: [3, 2, 1], advocate: [2, 4, 8]}, bonus: [1, 2], donorCents: [5, 1], off: ["sitter", "x"]});
  assert.deepEqual(odd.levels.rescuer, [1, 3, 10], "levels must rise");
  assert.deepEqual(odd.levels.advocate, [2, 4, 8]);
  assert.deepEqual(odd.bonus, [10, 25, 50]);
  assert.deepEqual(odd.donorCents, [1000, 2500, 5000, 10000, 25000]);
  assert.deepEqual(odd.off, ["sitter"]);
});

test("levels follow the numbers", () => {
  assert.equal(levelFor(0, [1, 5, 15]), 0);
  assert.equal(levelFor(1, [1, 5, 15]), 1);
  assert.equal(levelFor(14, [1, 5, 15]), 2);
  assert.equal(levelFor(99, [1, 5, 15]), 3);
});

test("donor titles: any donation, then Bronze to Lifetime on the total", () => {
  const tiers = config.donorCents;
  assert.equal(donorLevel(0, tiers), 0);
  assert.equal(donorLevel(100, tiers), 1, "€1 makes a Supporter");
  assert.equal(donorLevel(1000, tiers), 2, "€10 Bronze");
  assert.equal(donorLevel(2500, tiers), 3, "€25 Silver");
  assert.equal(donorLevel(6000, tiers), 4, "€60 Gold");
  assert.equal(donorLevel(10000, tiers), 5, "€100 Platinum");
  assert.equal(donorLevel(25000, tiers), 6, "€250 Lifetime");
});

test("activity titles are kept, the record-based ones follow the record", () => {
  const before = {contributor: 2, trusted: 1, sitter: 1, donor: 3};
  const got = earnedLevels({...none, reports: 1, activeDays: 40, sittings: 1, donorCents: 1000}, clean, config, mins, before);
  assert.equal(got.contributor, 2, "a removed report doesn't take a level away");
  assert.equal(got.trusted, 1);
  assert.equal(got.sitter, 1);
  assert.equal(got.donor, 2, "a corrected donation lowers the donor title");
  const flagged = earnedLevels({...none, activeDays: 400}, {clean: false, sitterRating: null}, config, mins, before);
  assert.equal(flagged.trusted, undefined, "paused while something was removed recently");
  const lowRated = earnedLevels({...none, sittings: 6}, {clean: true, sitterRating: 3.4}, config, mins, {});
  assert.equal(lowRated.sitter, undefined, "a pet sitter needs 4 stars on average");
  const goodRated = earnedLevels({...none, sittings: 6}, {clean: true, sitterRating: 4.6}, config, mins, {});
  assert.equal(goodRated.sitter, 2);
  assert.equal(earnedLevels({...none, invites: 16}, clean, config, mins, {}).ambassador, 3);
});

test("what shows: team grants, removals and switched-off titles", () => {
  const off = titlesConfigOf({enabled: true, off: ["advocate"]});
  const levels = effectiveLevels({contributor: 1, advocate: 2, rescuer: 3}, {partner: 1, contributor: 3}, ["rescuer"], off, 4);
  assert.deepEqual(levels, {contributor: 3, partner: 1});
  assert.deepEqual(effectiveLevels({}, {team: 5}, [], config, 4), {team: 1}, "capped at the highest level");
});

test("new levels and bonus points once per level", () => {
  assert.deepEqual(newUnlocks({contributor: 1}, {contributor: 2, rescuer: 1}),
    [{id: "contributor", level: 2}, {id: "rescuer", level: 1}]);
  assert.deepEqual(bonusAwards({contributor: 1}, {contributor: 3, donor: 4, ambassador: 2}, config), [
    {key: "contributor_2", points: 25},
    {key: "contributor_3", points: 50},
  ], "never for donor or invite titles");
  assert.deepEqual(bonusAwards({}, {}, config), []);
});

test("the public title: the user's choice, or the hardest one earned", () => {
  const levels = {contributor: 1, rescuer: 3, donor: 2, trusted: 1};
  assert.deepEqual(publicTitles(levels, null, false, 4).title, {id: "rescuer", level: 3});
  assert.deepEqual(publicTitles(levels, "trusted", false, 4).title, {id: "trusted", level: 1});
  assert.deepEqual(publicTitles(levels, "sitter", false, 4).title, {id: "rescuer", level: 3}, "a locked choice is ignored");
  assert.equal(publicTitles(levels, null, false, 4).tags.length, 3);
  assert.ok(!publicTitles(levels, "donor", true, 4).tags.some((t) => t.id === "donor"), "hidden donor title never shows");
  assert.deepEqual(publicTitles({partner: 1, rescuer: 3}, null, false, 4).title, {id: "partner", level: 1});
  assert.deepEqual(publicTitles({}, null, false, 4), {title: null, tags: []});
});

test("shares count three times a day at most", () => {
  assert.equal(nextShareCount("2026-11-05", 3, "2026-11-06"), 1);
  assert.equal(nextShareCount("2026-11-06", 2, "2026-11-06"), 3);
  assert.equal(nextShareCount("2026-11-06", 3, "2026-11-06"), null);
});

test("admin input checks", () => {
  assert.deepEqual(donationOf({uid: "u1", cents: 2500, note: " Bank transfer "}), {uid: "u1", cents: 2500, note: "Bank transfer"});
  assert.equal(donationOf({uid: "u1", cents: 0}), null);
  assert.equal(donationOf({uid: "u1", cents: 12.5}), null);
  assert.equal(donationOf({uid: "a/b", cents: 100}), null);
  assert.deepEqual(grantOf({uid: "u1", id: "partner", level: 1}, 4), {uid: "u1", id: "partner", level: 1});
  assert.deepEqual(grantOf({uid: "u1", id: "rescuer", level: 0}, 4), {uid: "u1", id: "rescuer", level: 0});
  assert.deepEqual(grantOf({uid: "u1", id: "rescuer", level: null}, 4), {uid: "u1", id: "rescuer", level: null});
  assert.equal(grantOf({uid: "u1", id: "rescuer", level: 4}, 4), null);
  assert.equal(grantOf({uid: "u1", id: "king", level: 1}, 4), null);
  assert.deepEqual(prefsOf({main: "rescuer", hideDonor: true}), {main: "rescuer", hideDonor: true});
  assert.deepEqual(prefsOf({main: null, hideDonor: false}), {main: null, hideDonor: false});
  assert.equal(prefsOf({main: "king", hideDonor: false}), null);
  assert.equal(prefsOf({main: "rescuer"}), null);
});

test("names and notifications in every language", () => {
  assert.equal(titleName("en", {id: "rescuer", level: 2}), "Animal Rescuer ★★");
  assert.equal(titleName("en", {id: "donor", level: 3}), "Silver Donor");
  assert.equal(titleName("en", {id: "ambassador", level: 1}), "Friend of CodaMi");
  assert.equal(titleName("it", {id: "partner", level: 1}), "Rifugio partner");
  assert.equal(unlockText("en", [{id: "helper", level: 1}]).title, "🏆 New title: Community Helper ★");
  assert.equal(unlockText("en", [{id: "helper", level: 1}, {id: "trusted", level: 1}]).title, "🏆 2 new titles!");
  assert.match(unlockText("en", [{id: "donor", level: 1}]).body, /Thank you/);
  for (const lang of ["en", "it", "de", "fr", "es", "pt", "ru", "zh", "ar", "hi"]) {
    for (let level = 1; level <= 6; level++) assert.ok(titleName(lang, {id: "donor", level}).length > 0, lang);
    assert.ok(!unlockText(lang, [{id: "sitter", level: 1}, {id: "team", level: 1}]).title.includes("{"), lang);
  }
});
