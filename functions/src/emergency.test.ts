import assert from "node:assert/strict";
import {test} from "node:test";

import {
  DEFAULT_EMERGENCY_CONFIG,
  EMERGENCY_TYPES,
  emergencyConfigOf,
  isStale,
  nextStatus,
  rankContacts,
  readContact,
  ringFor,
  snapshotOf,
  type Contact,
} from "./emergency";
import {EMERGENCY_MESSAGES, emergencyText} from "./emergencyMessages";

const config = DEFAULT_EMERGENCY_CONFIG;
const milan = {lat: 45.4642, lng: 9.19};

function contact(id: string, fields: Partial<Contact>): Contact {
  return {
    id,
    name: id,
    kind: "vet",
    phones: ["+39 000 000 0000"],
    email: null,
    address: null,
    lat: milan.lat,
    lng: milan.lng,
    areaKm: null,
    types: [],
    open24h: false,
    hours: null,
    verified: false,
    recommended: false,
    active: true,
    isTest: false,
    ...fields,
  };
}

test("config has safe defaults and sorted rings", () => {
  assert.deepEqual(emergencyConfigOf(undefined), config);
  const custom = emergencyConfigOf({ringsKm: [20, 2, "x", 20], minRecipients: 50, maxRecipients: 10, emailEnabled: "yes"});
  assert.deepEqual(custom.ringsKm, [2, 20]);
  assert.equal(custom.maxRecipients, 50);
  assert.equal(custom.emailEnabled, false);
});

test("contacts need a name and position", () => {
  assert.equal(readContact("c1", {name: "Vet"}), null);
  const c = readContact("c1", {name: " Vet ", lat: 1, lng: 2, types: ["injured", "nope"], kind: "x", phones: ["1", 2]});
  assert.equal(c?.name, "Vet");
  assert.deepEqual(c?.types, ["injured"]);
  assert.equal(c?.kind, "other");
  assert.deepEqual(c?.phones, ["1"]);
  assert.equal(c?.active, true);
});

test("nearest suitable contacts come first", () => {
  const ranked = rankContacts([
    contact("far", {lat: 45.6, lng: 9.19}),
    contact("near", {lat: 45.47, lng: 9.19}),
    contact("inactive", {active: false}),
    contact("cats-only", {types: ["abandoned"]}),
  ], "injured", milan, config);
  assert.deepEqual(ranked.map((c) => c.id), ["near", "far"]);
  assert.ok(ranked[0].distanceKm < 1);
  assert.ok(ranked.every((c) => c.inArea));
});

test("recommended and verified contacts can come before nearer ones", () => {
  const ranked = rankContacts([
    contact("near", {lat: 45.47, lng: 9.19}),
    contact("recommended", {lat: 45.55, lng: 9.19, recommended: true}),
  ], "injured", milan, config);
  assert.equal(ranked[0].id, "recommended");
  const noWeight = rankContacts([
    contact("near", {lat: 45.47, lng: 9.19}),
    contact("recommended", {lat: 45.55, lng: 9.19, recommended: true}),
  ], "injured", milan, {...config, weightRecommended: 0});
  assert.equal(noWeight[0].id, "near");
});

test("contacts outside their area are only used when nobody covers the place", () => {
  const rome = contact("rome", {lat: 41.9, lng: 12.5});
  const local = contact("local", {lat: 45.47, lng: 9.19, areaKm: 5});
  assert.deepEqual(rankContacts([rome, local], "injured", milan, config).map((c) => c.id), ["local"]);
  const fallback = rankContacts([rome], "injured", milan, config);
  assert.equal(fallback[0].id, "rome");
  assert.equal(fallback[0].inArea, false);
});

test("the list is capped", () => {
  const many = Array.from({length: 9}, (_, i) => contact(`c${i}`, {}));
  assert.equal(rankContacts(many, "danger", milan, config).length, config.maxSuggested);
});

test("snapshots keep what the app shows", () => {
  const [ranked] = rankContacts([contact("c", {isTest: true, email: "a@example.com"})], "danger", milan, config);
  const snap = snapshotOf(ranked);
  assert.equal(snap.isTest, true);
  assert.equal(snap.email, "a@example.com");
  assert.equal("score" in snap, false);
});

test("alerts use the smallest circle that reaches enough people", () => {
  assert.equal(ringFor([25, 40, 90], config), 0);
  assert.equal(ringFor([3, 21, 90], config), 1);
  assert.equal(ringFor([1, 2, 3], config), 2);
});

test("quiet emergencies close by themselves", () => {
  assert.ok(isStale(0, 72 * 3_600_000, config));
  assert.ok(!isStale(0, 71 * 3_600_000, config));
});

test("who can change an emergency", () => {
  const anyone = {isOwner: false, isStaff: false};
  const owner = {isOwner: true, isStaff: false};
  const staff = {isOwner: false, isStaff: true};
  assert.equal(nextStatus("open", "helping", anyone), "helping");
  assert.equal(nextStatus("helping", "helping", anyone), null);
  assert.equal(nextStatus("open", "resolved", anyone), null);
  assert.equal(nextStatus("helping", "resolved", owner), "resolved");
  assert.equal(nextStatus("open", "closed", staff), "closed");
  assert.equal(nextStatus("open", "false_alarm", owner), null);
  assert.equal(nextStatus("open", "false_alarm", staff), "false_alarm");
  assert.equal(nextStatus("resolved", "reopen", owner), "open");
  assert.equal(nextStatus("open", "reopen", owner), null);
  assert.equal(nextStatus("open", "report_false", anyone), "open");
});

test("emergency pushes exist in every language", () => {
  const keys = Object.keys(EMERGENCY_MESSAGES.en);
  assert.equal(Object.keys(EMERGENCY_MESSAGES).length, 10);
  for (const messages of Object.values(EMERGENCY_MESSAGES)) {
    assert.deepEqual(Object.keys(messages), keys);
    for (const text of Object.values(messages)) assert.ok(text.trim().length > 0);
  }
  for (const type of EMERGENCY_TYPES) assert.ok(keys.includes(`type_${type}`));
  assert.equal(emergencyText("it", "type_injured"), "Animale ferito");
});
