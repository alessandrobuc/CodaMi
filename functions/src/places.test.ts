import assert from "node:assert/strict";
import {test} from "node:test";

import {
  SAFE_ID_PATTERN,
  parseCityDetails,
  parseSuggestions,
  readString,
} from "./places";

test("parseSuggestions keeps place predictions only", () => {
  const result = parseSuggestions({
    suggestions: [
      {
        placePrediction: {
          placeId: "ChIJ53USP0nBhkcRjQ50xhPN_zw",
          text: {text: "Milano, MI, Italia"},
          structuredFormat: {
            mainText: {text: "Milano"},
            secondaryText: {text: "MI, Italia"},
          },
        },
      },
      {queryPrediction: {text: {text: "milano centrale"}}},
    ],
  });

  assert.deepEqual(result, [{
    placeId: "ChIJ53USP0nBhkcRjQ50xhPN_zw",
    mainText: "Milano",
    secondaryText: "MI, Italia",
  }]);
  assert.deepEqual(parseSuggestions({}), []);
});

test("parseCityDetails reads city, province, country and coordinates", () => {
  const city = parseCityDetails({
    id: "ChIJ53USP0nBhkcRjQ50xhPN_zw",
    location: {latitude: 45.4642035, longitude: 9.189982},
    addressComponents: [
      {longText: "Milano", shortText: "Milano", types: ["locality", "political"]},
      {
        longText: "Città Metropolitana di Milano",
        shortText: "MI",
        types: ["administrative_area_level_2", "political"],
      },
      {longText: "Lombardia", shortText: "Lombardia", types: ["administrative_area_level_1"]},
      {longText: "Italia", shortText: "it", types: ["country", "political"]},
    ],
  });

  assert.deepEqual(city, {
    placeId: "ChIJ53USP0nBhkcRjQ50xhPN_zw",
    city: "Milano",
    province: "MI",
    region: "Lombardia",
    country: "IT",
    countryName: "Italia",
    lat: 45.4642035,
    lng: 9.189982,
  });
});

test("parseCityDetails rejects places without coordinates", () => {
  assert.equal(parseCityDetails({id: "x", addressComponents: []}), null);
});

test("readString validates type, length and pattern", () => {
  assert.equal(readString({input: "  Mil "}, "input", {min: 2, max: 10}), "Mil");
  assert.throws(() => readString({input: 5}, "input", {min: 2, max: 10}));
  assert.throws(() => readString({input: "M"}, "input", {min: 2, max: 10}));
  assert.throws(() => readString(null, "input", {min: 2, max: 10}));
  assert.throws(() =>
    readString({placeId: "../secrets"}, "placeId", {min: 3, max: 300, pattern: SAFE_ID_PATTERN}),
  );
});
