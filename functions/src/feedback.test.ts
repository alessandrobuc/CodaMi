import assert from "node:assert/strict";
import {test} from "node:test";

import {
  FEEDBACK_PER_DAY, feedbackOf, feedbackUpdateOf, nextDayCount, thanksKindOf, thanksText,
} from "./feedback";

test("feedback needs stars or a few words", () => {
  assert.deepEqual(feedbackOf({type: "bug", area: "map", rating: 2, comment: "  Pins vanish  "}, "u1"), {
    type: "bug", area: "map", rating: 2, comment: "Pins vanish", asked: false, screenshotPath: null,
  });
  assert.equal(feedbackOf({rating: 4}, "u1")?.comment, "");
  assert.equal(feedbackOf({comment: "Add dark mode"}, "u1")?.rating, 0, "stars are optional");
  assert.equal(feedbackOf({comment: "ok"}, "u1"), null, "two letters and no stars is not enough");
  assert.equal(feedbackOf({rating: 6}, "u1"), null);
  assert.equal(feedbackOf({rating: 3.5}, "u1"), null);
  assert.equal(feedbackOf({rating: 3, comment: "x".repeat(1001)}, "u1"), null);
  assert.equal(feedbackOf(null, "u1"), null);
});

test("unknown types and parts of the app become general", () => {
  const f = feedbackOf({type: "rant", area: "moon", rating: 5, asked: true}, "u1");
  assert.equal(f?.type, "general");
  assert.equal(f?.area, "general");
  assert.equal(f?.asked, true);
});

test("a screenshot must be in the sender's own folder", () => {
  assert.equal(feedbackOf({rating: 5, screenshotPath: "feedback/u1/1730000000000.jpg"}, "u1")?.screenshotPath,
    "feedback/u1/1730000000000.jpg");
  assert.equal(feedbackOf({rating: 5, screenshotPath: "feedback/u2/1.jpg"}, "u1"), null);
  assert.equal(feedbackOf({rating: 5, screenshotPath: "pets/u1/1.jpg"}, "u1"), null);
  assert.equal(feedbackOf({rating: 5, screenshotPath: "feedback/u1/../x.jpg"}, "u1"), null);
  assert.equal(feedbackOf({rating: 5, screenshotPath: ""}, "u1")?.screenshotPath, null);
});

test("up to five feedbacks a day", () => {
  assert.equal(nextDayCount("2026-11-05", 5, "2026-11-06"), 1, "a new day starts again");
  assert.equal(nextDayCount("2026-11-06", undefined, "2026-11-06"), 2, "older accounts counted one");
  assert.equal(nextDayCount("2026-11-06", FEEDBACK_PER_DAY - 1, "2026-11-06"), FEEDBACK_PER_DAY);
  assert.equal(nextDayCount("2026-11-06", FEEDBACK_PER_DAY, "2026-11-06"), null);
});

test("the team can change the status and the note", () => {
  assert.deepEqual(feedbackUpdateOf({id: "abc", status: "done", notify: true}), {
    id: "abc", status: "done", note: null, notify: true,
  });
  assert.equal(feedbackUpdateOf({id: "abc", note: " Seen on Android 14 "})?.note, "Seen on Android 14");
  assert.equal(feedbackUpdateOf({id: "abc", status: "closed"}), null);
  assert.equal(feedbackUpdateOf({id: "a/b", status: "done"}), null);
  assert.equal(feedbackUpdateOf({id: "abc"}), null, "something must change");
});

test("bugs are thanked as fixed, ideas as ideas, in every language", () => {
  assert.equal(thanksKindOf("bug"), "fixed");
  assert.equal(thanksKindOf("problem"), "fixed");
  assert.equal(thanksKindOf("suggestion"), "idea");
  assert.equal(thanksKindOf(undefined), "idea");
  for (const lang of ["en", "it", "de", "fr", "es", "pt", "ru", "zh", "ar", "hi"]) {
    for (const kind of ["fixed", "idea"] as const) {
      const text = thanksText(lang, kind);
      assert.ok(text.title.length > 0 && text.body.length > 0, `${lang} ${kind}`);
    }
  }
  assert.deepEqual(thanksText("xx", "fixed"), thanksText("en", "fixed"));
});
