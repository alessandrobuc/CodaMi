import assert from "node:assert/strict";
import {test} from "node:test";

import {
  DEFAULT_WALKS,
  cacheKey,
  groupOf,
  mergePlaces,
  nearbyBody,
  nextUsage,
  parseDetails,
  searchTypeSets,
  walksConfigOf,
} from "./walks";

test("walks config defaults and limits", () => {
  assert.deepEqual(walksConfigOf(undefined), DEFAULT_WALKS);
  const c = walksConfigOf({
    enabled: true,
    defaultRadiusKm: 7,
    groups: {trails: false},
    hiddenPlaceIds: ["a", 3],
    dailySearches: 0,
  });
  assert.equal(c.enabled, true);
  assert.equal(c.defaultRadiusKm, 5);
  assert.deepEqual(c.groups, {dogParks: true, parks: true, green: true, trails: false});
  assert.deepEqual(c.hiddenPlaceIds, ["a"]);
  assert.equal(c.dailySearches, 40);
});

test("dog parks get their own search", () => {
  assert.deepEqual(searchTypeSets(DEFAULT_WALKS), [
    ["dog_park"],
    ["park", "national_park", "state_park", "garden", "botanical_garden", "hiking_area"],
  ]);
  const noDogs = walksConfigOf({groups: {dogParks: false, green: false}});
  assert.deepEqual(searchTypeSets(noDogs), [["park", "national_park", "state_park", "hiking_area"]]);
  assert.deepEqual(
    searchTypeSets(walksConfigOf({groups: {dogParks: false, parks: false, green: false, trails: false}})),
    [],
  );
});

test("nearby request is limited to the circle and ranked by distance", () => {
  const body = nearbyBody(45.46, 9.19, 3, ["dog_park"], "it");
  assert.equal(body.rankPreference, "DISTANCE");
  assert.deepEqual(body.locationRestriction, {
    circle: {center: {latitude: 45.46, longitude: 9.19}, radius: 3000},
  });
});

test("places are grouped, merged once and hidden ones dropped", () => {
  assert.equal(groupOf(["park", "dog_park"]), "dogParks");
  assert.equal(groupOf(["tourist_attraction", "hiking_area"]), "trails");
  assert.equal(groupOf(["restaurant"]), null);
  const place = (id: string, types: string[]) => ({
    id,
    displayName: {text: `Place ${id}`},
    formattedAddress: "Via Roma 1",
    location: {latitude: 45, longitude: 9},
    primaryType: types[0],
    types,
  });
  const merged = mergePlaces(
    [
      {places: [place("a", ["dog_park"]), place("b", ["park"])]},
      {places: [place("b", ["park"]), place("c", ["garden"]), place("d", ["cafe"]), {id: "e"}]},
      {},
    ],
    ["c"],
  );
  assert.deepEqual(merged.map((p) => [p.id, p.group]), [["a", "dogParks"], ["b", "parks"]]);
  assert.equal(merged[0].name, "Place a");
});

test("place details keep only what the app shows", () => {
  const d = parseDetails({
    id: "x",
    displayName: {text: "Parco Sempione"},
    rating: 4.6,
    userRatingCount: 1200,
    currentOpeningHours: {openNow: true},
    regularOpeningHours: {weekdayDescriptions: ["Monday: 6:30 AM – 9:00 PM"]},
    allowsDogs: true,
    photos: [{name: "places/x/photos/p1", authorAttributions: [{displayName: "Anna"}]}],
  });
  assert.equal(d.name, "Parco Sempione");
  assert.equal(d.openNow, true);
  assert.equal(d.allowsDogs, true);
  assert.equal(d.photoName, "places/x/photos/p1");
  assert.equal(d.photoAuthor, "Anna");
  assert.deepEqual(d.hours, ["Monday: 6:30 AM – 9:00 PM"]);
  const empty = parseDetails({});
  assert.equal(empty.allowsDogs, null);
  assert.equal(empty.openNow, null);
  assert.equal(empty.photoName, null);
});

test("nearby searches share a cache key", () => {
  const sets = [["dog_park"]];
  assert.equal(cacheKey(45.4612, 9.1901, 5, "it", sets), cacheKey(45.4598, 9.1888, 5, "it", sets));
  assert.notEqual(cacheKey(45.46, 9.19, 5, "it", sets), cacheKey(45.46, 9.19, 10, "it", sets));
});

test("daily limits reset each day", () => {
  assert.deepEqual(nextUsage(undefined, "2026-11-02", "searches", 2), {day: "2026-11-02", searches: 1, details: 0});
  const used = {day: "2026-11-02", searches: 2, details: 1};
  assert.equal(nextUsage(used, "2026-11-02", "searches", 2), null);
  assert.deepEqual(nextUsage(used, "2026-11-02", "details", 5), {day: "2026-11-02", searches: 2, details: 2});
  assert.deepEqual(nextUsage(used, "2026-11-03", "searches", 2), {day: "2026-11-03", searches: 1, details: 0});
});
