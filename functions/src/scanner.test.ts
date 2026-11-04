import assert from "node:assert/strict";
import {test} from "node:test";

import {
  DEFAULT_SCANNER,
  answerTextOf,
  FALLBACK_MODELS,
  imageTypeOf,
  modelTier,
  nextScanUsage,
  parseScan,
  scanModelsOf,
  scanPrompt,
  scannerConfigOf,
} from "./scanner";

test("scanner config defaults and limits", () => {
  assert.deepEqual(scannerConfigOf(undefined), DEFAULT_SCANNER);
  assert.deepEqual(scannerConfigOf({enabled: true, dailyScans: 25, model: "gemini-3.5-flash"}),
    {enabled: true, dailyScans: 25, model: "gemini-3.5-flash"});
  const bad = scannerConfigOf({enabled: "yes", dailyScans: 0, model: "gpt-5"});
  assert.equal(bad.enabled, false);
  assert.equal(bad.dailyScans, 10);
  assert.equal(bad.model, "gemini-3.8-flash");
  assert.equal(scannerConfigOf({dailyScans: 101}).dailyScans, 10);
  assert.equal(scannerConfigOf({model: "gemini-x/../../other"}).model, "gemini-3.8-flash");
});

test("daily scans: counted per day, stopped at the limit", () => {
  assert.deepEqual(nextScanUsage(undefined, "2026-11-04", 3), {day: "2026-11-04", scans: 1});
  assert.deepEqual(nextScanUsage({day: "2026-11-04", scans: 2}, "2026-11-04", 3), {day: "2026-11-04", scans: 3});
  assert.equal(nextScanUsage({day: "2026-11-04", scans: 3}, "2026-11-04", 3), null);
  assert.deepEqual(nextScanUsage({day: "2026-11-03", scans: 3}, "2026-11-04", 3), {day: "2026-11-04", scans: 1});
});

test("image type comes from the file's bytes", () => {
  const pad = Buffer.alloc(16);
  assert.equal(imageTypeOf(Buffer.concat([Buffer.from([0xff, 0xd8, 0xff, 0xe0]), pad])), "image/jpeg");
  assert.equal(imageTypeOf(Buffer.concat([Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]), pad])), "image/png");
  assert.equal(imageTypeOf(Buffer.concat([Buffer.from("RIFF\0\0\0\0WEBP"), pad])), "image/webp");
  assert.equal(imageTypeOf(Buffer.concat([Buffer.from("\0\0\0\x18ftypheic"), pad])), "image/heic");
  assert.equal(imageTypeOf(Buffer.concat([Buffer.from("%PDF-1.7 hello"), pad])), null);
  assert.equal(imageTypeOf(Buffer.from([0xff, 0xd8])), null);
});

test("the answer is cleaned before it reaches the app", () => {
  const scan = parseScan({
    animalFound: true,
    species: "dog",
    speciesName: "  Cane ",
    mixed: true,
    breeds: [
      {name: "Beagle", confidence: 30},
      {name: "Labrador", confidence: 90},
      {name: "labrador", confidence: 50},
      {name: "", confidence: 40},
      {name: "Pointer", confidence: -5},
      {name: "Basset", confidence: 20},
      {name: "Harrier", confidence: 10},
    ],
    photoQuality: "poor",
    size: "Medium\n\n  size",
    temperament: 42,
    note: "x".repeat(500),
  });
  assert.equal(scan.animalFound, true);
  assert.equal(scan.speciesName, "Cane");
  assert.equal(scan.mixed, true);
  assert.deepEqual(scan.breeds.map((b) => b.name), ["Labrador", "Beagle", "Basset", "Harrier"]);
  assert.ok(scan.breeds.reduce((s, b) => s + b.confidence, 0) <= 100, "confidences add up to 100 at most");
  assert.ok(scan.breeds.every((b, i, all) => i === 0 || all[i - 1].confidence >= b.confidence), "most likely first");
  assert.equal(scan.photoQuality, "poor");
  assert.equal(scan.info.size, "Medium size");
  assert.equal(scan.info.temperament, "");
  assert.equal(scan.note.length, 300);
});

test("no animal: no breeds or facts, unknown species is other", () => {
  const scan = parseScan({animalFound: false, species: "dragon", breeds: [{name: "X", confidence: 80}], size: "Big", mixed: true});
  assert.equal(scan.animalFound, false);
  assert.equal(scan.species, "other");
  assert.equal(scan.mixed, false);
  assert.deepEqual(scan.breeds, []);
  assert.equal(scan.info.size, "");
  assert.equal(parseScan({animalFound: true, breeds: []}).animalFound, false, "found but without a breed counts as not found");
  assert.equal(parseScan("not json").animalFound, false);
});

test("the prompt asks for the user's language", () => {
  assert.match(scanPrompt("it"), /in Italian/);
  assert.match(scanPrompt("zh"), /Simplified Chinese/);
  assert.match(scanPrompt("xx"), /in English/);
});

test("the answer text leaves out the model's thinking", () => {
  const body = {candidates: [{content: {parts: [{text: "thinking…", thought: true}, {text: "{\"a\":"}, {text: "1}"}]}}]};
  assert.equal(answerTextOf(body), "{\"a\":1}");
  assert.equal(answerTextOf({}), "");
});

test("model list: only released Gemini models that can scan a photo, newest first", () => {
  const listed = [
    "gemini-3.5-flash", "gemini-4-argon", "gemini-3.8-flash", "gemini-3.5-flash-lite", "gemini-2.0-flash-001",
    "gemini-3.1-flash-image", "gemini-3.8-live", "gemini-embedding-2", "gemini-3.8-flash-cyber",
    "gemini-nano-banana-2.1", "gemini-4-argon-cyber-permissive", "imagen-4.0-generate", "gemma-4",
  ].map((id) => ({name: `publishers/google/models/${id}`}));
  listed.push({name: "publishers/google/models/gemini-3.9-flash-preview"});
  listed.push({name: "publishers/google/models/gemini-3.9-flash", launchStage: "PUBLIC_PREVIEW"} as never);
  listed.push({name: "publishers/google/models/gemini-3.8-flash", launchStage: "GA"} as never);
  listed.push({name: "publishers/google/models/gemini-3.7-flash", versionState: "VERSION_STATE_UNSTABLE"} as never);
  assert.deepEqual(scanModelsOf(listed), ["gemini-4-argon", "gemini-3.8-flash", "gemini-3.5-flash", "gemini-3.5-flash-lite"]);
  assert.deepEqual(scanModelsOf([]), []);
});

test("model tiers and the fallback list", () => {
  assert.equal(modelTier("gemini-3.5-flash-lite"), "lite");
  assert.equal(modelTier("gemini-3.8-flash"), "flash");
  assert.equal(modelTier("gemini-4-argon"), "pro");
  assert.ok(FALLBACK_MODELS.includes(DEFAULT_SCANNER.model));
});
