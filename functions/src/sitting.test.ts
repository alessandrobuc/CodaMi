import assert from "node:assert/strict";
import {test} from "node:test";

import {
  chatIdOf,
  confirmStep,
  messagePreview,
  ratingOf,
  reviewBlockOf,
  reviewInputOf,
  sittingConfigOf,
  sittingText,
} from "./sitting";

const done = {status: "done", ownerId: "owner", sitterId: "sitter"};

test("sitting settings: defaults and limits", () => {
  assert.deepEqual(sittingConfigOf(undefined), {enabled: false, minAccountDays: 3});
  assert.deepEqual(sittingConfigOf({enabled: true, minAccountDays: 0}), {enabled: true, minAccountDays: 0});
  assert.equal(sittingConfigOf({minAccountDays: 61}).minAccountDays, 3);
});

test("chat ID is the same from both sides", () => {
  assert.equal(chatIdOf("b", "a"), "a_b");
  assert.equal(chatIdOf("a", "b"), "a_b");
});

test("review input: 1 to 5 stars, text cleaned and limited", () => {
  assert.deepEqual(reviewInputOf({requestId: "r1", stars: 5, text: "  Great\n\nsitter "}), {requestId: "r1", stars: 5, text: "Great sitter"});
  assert.equal(reviewInputOf({requestId: "r1", stars: 0}), null);
  assert.equal(reviewInputOf({requestId: "r1", stars: 4.5}), null);
  assert.equal(reviewInputOf({requestId: "../x", stars: 3}), null);
  assert.equal(reviewInputOf({requestId: "r1", stars: 3, text: "x".repeat(801)}), null);
});

test("only the owner of a completed service can review, and not a brand-new account", () => {
  assert.equal(reviewBlockOf(done, "owner", 10, 3), null);
  assert.equal(reviewBlockOf({...done, status: "booked"}, "owner", 10, 3), "not_done");
  assert.equal(reviewBlockOf(done, "sitter", 10, 3), "not_owner");
  assert.equal(reviewBlockOf(done, "stranger", 10, 3), "not_owner");
  assert.equal(reviewBlockOf(done, "owner", 1, 3), "too_new");
  assert.equal(reviewBlockOf(undefined, "owner", 10, 3), "not_done");
});

test("both sides confirm after the start; the second one completes it", () => {
  const booked = {status: "booked", ownerId: "owner", sitterId: "sitter", start: "2026-11-01"};
  assert.deepEqual(confirmStep(booked, "owner", "2026-11-04"), {field: "ownerConfirmed", done: false});
  assert.deepEqual(confirmStep({...booked, ownerConfirmed: true}, "sitter", "2026-11-04"), {field: "sitterConfirmed", done: true});
  assert.equal(confirmStep({...booked, ownerConfirmed: true}, "owner", "2026-11-04"), null, "no confirming twice");
  assert.equal(confirmStep(booked, "owner", "2026-10-30"), null, "not before the start");
  assert.equal(confirmStep(booked, "stranger", "2026-11-04"), null);
  assert.equal(confirmStep({...booked, status: "open"}, "owner", "2026-11-04"), null);
});

test("rating leaves out hidden reviews", () => {
  assert.deepEqual(ratingOf([{stars: 5}, {stars: 3}, {stars: 1, hidden: true}, {stars: "x"}]), {ratingSum: 8, reviewCount: 2});
});

test("push texts in the user's language", () => {
  assert.equal(sittingText("en", "acceptedTitle", "Marta"), "Your offer was accepted");
  assert.match(sittingText("it", "offerBody", "Marta"), /^Marta si è offerto/);
  assert.match(sittingText("xx", "confirmBody", "Marta"), /^Marta confirmed/);
  assert.equal(messagePreview("x".repeat(200)).length, 140);
});
