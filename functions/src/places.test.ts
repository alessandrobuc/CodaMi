import assert from "node:assert/strict";
import {test} from "node:test";

import {
  SAFE_ID_PATTERN,
  blurLocation,
  cityQuery,
  mentionsCity,
  placeLocality,
  suggestionsInCity,
  parseCityDetails,
  parseStreetDetails,
  parseSuggestions,
  readCoordinate,
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

test("blurLocation stays within the radius", () => {
  for (let i = 0; i < 200; i++) {
    const {lat, lng} = blurLocation(41.7, 15.28, 100);
    const dLat = (lat - 41.7) * 111_320;
    const dLng = (lng - 15.28) * 111_320 * Math.cos((41.7 * Math.PI) / 180);
    assert.ok(Math.hypot(dLat, dLng) <= 101);
  }
  assert.deepEqual(blurLocation(41.7, 15.28, 100, () => 0), {lat: 41.7, lng: 15.28});
});

test("parseStreetDetails drops the house number and blurs the point", () => {
  const street = parseStreetDetails(
    {
      id: "abc",
      types: ["street_address"],
      displayName: {text: "Piazzale Enrico Fermi, 12"},
      location: {latitude: 41.7, longitude: 15.28},
      addressComponents: [
        {longText: "12", types: ["street_number"]},
        {longText: "Piazzale Enrico Fermi", types: ["route"]},
      ],
    },
    100,
    () => 0,
  );
  assert.deepEqual(street, {
    placeId: "abc",
    label: "Piazzale Enrico Fermi",
    lat: 41.7,
    lng: 15.28,
  });
});

test("parseStreetDetails uses the name for landmarks", () => {
  const park = parseStreetDetails(
    {
      types: ["park"],
      displayName: {text: "Villa Comunale"},
      location: {latitude: 41.7, longitude: 15.28},
      addressComponents: [{longText: "Via Roma", types: ["route"]}],
    },
    100,
    () => 0,
  );
  assert.equal(park?.label, "Villa Comunale");
  assert.equal(parseStreetDetails({types: ["route"]}, 100), null);
});

test("readCoordinate rejects bad values", () => {
  assert.equal(readCoordinate({lat: 41.7}, "lat", 90), 41.7);
  assert.throws(() => readCoordinate({lat: 120}, "lat", 90));
  assert.throws(() => readCoordinate({lat: "41"}, "lat", 90));
});

test("mentionsCity matches whole names, ignoring case and accents", () => {
  assert.ok(mentionsCity("Torremaggiore, FG, Italia", "Torremaggiore"));
  assert.ok(mentionsCity("Forlì, FC, Italia", "forli"));
  assert.ok(!mentionsCity("San Severo, FG, Italia", "Torremaggiore"));
  assert.ok(!mentionsCity("Romano di Lombardia, BG", "Roma"));
});

test("cityQuery adds the city only when missing", () => {
  assert.equal(cityQuery("Piazzale Enrico Fermi", "Torremaggiore"),
    "Piazzale Enrico Fermi, Torremaggiore");
  assert.equal(cityQuery("via roma torremaggiore", "Torremaggiore"),
    "via roma torremaggiore");
});

test("suggestionsInCity drops places in other towns", () => {
  const result = suggestionsInCity([
    {placeId: "a", mainText: "Via Roma", secondaryText: "Torremaggiore, FG, Italia"},
    {placeId: "b", mainText: "Via Roma", secondaryText: "San Severo, FG, Italia"},
  ], "Torremaggiore");
  assert.deepEqual(result.map((s) => s.placeId), ["a"]);
});

test("placeLocality reads the town of a place", () => {
  assert.equal(placeLocality({
    addressComponents: [{longText: "Torremaggiore", types: ["locality"]}],
  }), "Torremaggiore");
  assert.equal(placeLocality({}), null);
});
