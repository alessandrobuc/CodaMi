import assert from "node:assert/strict";
import {test} from "node:test";

import {
  becameResolved,
  chunk,
  newReportContent,
  readReport,
  resolvedContent,
} from "./notifications";

const data = {
  ownerId: "u1",
  type: "lost",
  petName: "Luna",
  city: "Torremaggiore",
  cityKey: "torremaggiore-fg-it",
  placeDetail: "Piazzale Enrico Fermi",
  photoUrls: ["https://a"],
  status: "open",
};

test("readReport needs an owner and a city", () => {
  const report = readReport("r1", data);
  assert.equal(report?.photoUrl, "https://a");
  assert.equal(report?.type, "lost");
  assert.equal(readReport("r1", {...data, cityKey: ""}), null);
  assert.equal(readReport("r1", undefined), null);
});

test("new report messages read naturally", () => {
  const lost = newReportContent(readReport("r1", data)!);
  assert.equal(lost.title, "Lost pet in Torremaggiore");
  assert.equal(
    lost.body,
    "Luna was last seen near Piazzale Enrico Fermi, Torremaggiore. Keep an eye out!",
  );
  const found = newReportContent(
    readReport("r2", {...data, type: "found", placeDetail: null, petName: "Unknown dog"})!,
  );
  assert.equal(found.title, "Pet found in Torremaggiore");
  assert.equal(found.body, "Unknown dog was found in Torremaggiore. Do you know the owner?");
});

test("resolved message and transition", () => {
  assert.equal(resolvedContent(readReport("r1", data)!).title, "Luna is back home");
  assert.ok(becameResolved({status: "open"}, {status: "resolved"}));
  assert.ok(!becameResolved({status: "resolved"}, {status: "resolved"}));
  assert.ok(!becameResolved({status: "open"}, {status: "open"}));
});

test("chunk splits evenly", () => {
  assert.deepEqual(chunk([1, 2, 3, 4, 5], 2), [[1, 2], [3, 4], [5]]);
});
