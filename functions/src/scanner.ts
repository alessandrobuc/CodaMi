type Json = Record<string, unknown>;

export const MODEL_PATTERN = /^gemini-[a-z0-9.-]{1,60}$/;
export const MAX_IMAGE_BYTES = 4 * 1024 * 1024;
export const MAX_BREEDS = 4;

export interface ScannerConfig {
  enabled: boolean;
  dailyScans: number;
  model: string;
}

export const DEFAULT_SCANNER: ScannerConfig = {
  enabled: false,
  dailyScans: 10,
  model: "gemini-3.8-flash",
};

export function scannerConfigOf(data: Json | undefined): ScannerConfig {
  const scans = data?.dailyScans;
  const model = data?.model;
  return {
    enabled: data?.enabled === true,
    dailyScans: typeof scans === "number" && Number.isInteger(scans) && scans >= 1 && scans <= 100 ?
      scans :
      DEFAULT_SCANNER.dailyScans,
    model: typeof model === "string" && MODEL_PATTERN.test(model) ? model : DEFAULT_SCANNER.model,
  };
}

// Used when Google's model list can't be read.
export const FALLBACK_MODELS = ["gemini-3.8-flash", "gemini-3.5-flash", "gemini-3.5-flash-lite", "gemini-3.1-flash-lite"];

export type ModelTier = "lite" | "flash" | "pro";

export const modelTier = (id: string): ModelTier =>
  id.includes("lite") ? "lite" : id.includes("flash") ? "flash" : "pro";

// Models that can't do this job, or aren't meant for production.
const NOT_FOR_SCANS = /image|live|embedding|tts|audio|cyber|permissive|banana|robotics|computer|nano|exp|preview|native|veo|imagen|-\d{3}$/;
const RELEASED = ["GA", "LAUNCH_STAGE_UNSPECIFIED"];

// Gemini models from Google's list that can read a photo and answer, newest first.
export function scanModelsOf(publisherModels: Json[]): string[] {
  const ids = new Set<string>();
  for (const m of publisherModels) {
    const id = typeof m.name === "string" ? m.name.split("/").pop() ?? "" : "";
    const stage = m.launchStage;
    if (!MODEL_PATTERN.test(id) || NOT_FOR_SCANS.test(id)) continue;
    if (stage !== undefined && !RELEASED.includes(stage as string)) continue;
    if (m.versionState === "VERSION_STATE_UNSTABLE") continue;
    ids.add(id);
  }
  const version = (id: string) => Number(/^gemini-(\d+(?:\.\d+)?)/.exec(id)?.[1] ?? 0);
  return [...ids].sort((a, b) => version(b) - version(a) || a.localeCompare(b));
}

export function nextScanUsage(previous: Json | undefined, day: string, limit: number): {day: string; scans: number} | null {
  const used = previous?.day === day && typeof previous.scans === "number" ? previous.scans : 0;
  return used >= limit ? null : {day, scans: used + 1};
}

export type ImageType = "image/jpeg" | "image/png" | "image/webp" | "image/heic";

// Read from the file itself, never from what the app says it is.
export function imageTypeOf(bytes: Buffer): ImageType | null {
  if (bytes.length < 12) return null;
  if (bytes[0] === 0xff && bytes[1] === 0xd8 && bytes[2] === 0xff) return "image/jpeg";
  if (bytes.subarray(0, 8).equals(Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]))) return "image/png";
  if (bytes.toString("ascii", 0, 4) === "RIFF" && bytes.toString("ascii", 8, 12) === "WEBP") return "image/webp";
  if (bytes.toString("ascii", 4, 8) === "ftyp" && /^(heic|heix|mif1|msf1)$/.test(bytes.toString("ascii", 8, 12))) {
    return "image/heic";
  }
  return null;
}

export const LANGUAGE_NAMES: Record<string, string> = {
  en: "English",
  it: "Italian",
  de: "German",
  fr: "French",
  es: "Spanish",
  pt: "Portuguese",
  ru: "Russian",
  zh: "Simplified Chinese",
  ar: "Arabic",
  hi: "Hindi",
};

export function scanPrompt(language: string): string {
  const name = LANGUAGE_NAMES[language] ?? LANGUAGE_NAMES.en;
  return [
    "You are an expert in the breeds of dogs, cats and other pets (rabbits, birds, horses, rodents, reptiles…).",
    "Identify the animal in the photo for its owner.",
    "",
    "Rules:",
    "- Judge only from visible features: head and muzzle shape, ears, eyes, coat length, texture and colour, build and size. Ignore the background.",
    "- animalFound is false when there is no animal or it can't be seen well enough to judge. With several animals, describe the most visible one and say so in note.",
    `- species is dog, cat or other. speciesName is the common name of the species in ${name}.`,
    `- breeds: up to ${MAX_BREEDS} most likely breeds, most likely first, each with confidence: your honest estimate from 0 to 100 as a whole number. Together they must not exceed 100. Leave room for uncertainty: when features fit several breeds, spread the confidence.`,
    "- mixed is true when the animal looks like a mixed breed or crossbreed; then list the breeds it most likely comes from.",
    "- For species without breeds, give the species as the only entry.",
    `- Use the usual name of each breed in ${name}.`,
    "- photoQuality is poor when the photo is blurry, dark, far away, or the animal is partly hidden.",
    `- size, weight, lifeSpan, temperament, characteristics and care: short facts about the most likely breed (or the mix), one or two sentences each, in ${name}. Give typical ranges for weight and life span.`,
    `- note: one short sentence in ${name} with anything the owner should know about this result (for example why it is uncertain), or an empty string.`,
  ].join("\n");
}

const text = {type: "STRING"};

export const SCAN_SCHEMA = {
  type: "OBJECT",
  properties: {
    animalFound: {type: "BOOLEAN"},
    species: {type: "STRING", enum: ["dog", "cat", "other"]},
    speciesName: text,
    mixed: {type: "BOOLEAN"},
    breeds: {
      type: "ARRAY",
      items: {
        type: "OBJECT",
        properties: {name: text, confidence: {type: "INTEGER"}},
        required: ["name", "confidence"],
      },
    },
    photoQuality: {type: "STRING", enum: ["good", "poor"]},
    size: text,
    weight: text,
    lifeSpan: text,
    temperament: text,
    characteristics: text,
    care: text,
    note: text,
  },
  required: ["animalFound", "species", "speciesName", "mixed", "breeds", "photoQuality"],
};

export interface BreedGuess {
  name: string;
  confidence: number;
}

export interface BreedScan {
  animalFound: boolean;
  species: "dog" | "cat" | "other";
  speciesName: string;
  mixed: boolean;
  breeds: BreedGuess[];
  photoQuality: "good" | "poor";
  info: Record<"size" | "weight" | "lifeSpan" | "temperament" | "characteristics" | "care", string>;
  note: string;
}

const INFO_KEYS = ["size", "weight", "lifeSpan", "temperament", "characteristics", "care"] as const;

const clean = (value: unknown, max: number) =>
  typeof value === "string" ? value.replace(/\s+/g, " ").trim().slice(0, max) : "";

// The model's answer is checked like any other input before it reaches the app.
export function parseScan(raw: unknown): BreedScan {
  const data = (typeof raw === "object" && raw !== null ? raw : {}) as Json;
  const seen = new Set<string>();
  let breeds: BreedGuess[] = [];
  for (const entry of Array.isArray(data.breeds) ? data.breeds : []) {
    const item = (typeof entry === "object" && entry !== null ? entry : {}) as Json;
    const name = clean(item.name, 80);
    const confidence = typeof item.confidence === "number" && Number.isFinite(item.confidence) ?
      Math.round(Math.min(100, Math.max(0, item.confidence))) :
      0;
    if (!name || seen.has(name.toLowerCase())) continue;
    seen.add(name.toLowerCase());
    breeds.push({name, confidence});
  }
  breeds.sort((a, b) => b.confidence - a.confidence);
  breeds = breeds.slice(0, MAX_BREEDS);
  const total = breeds.reduce((sum, b) => sum + b.confidence, 0);
  if (total > 100) {
    breeds = breeds.map((b) => ({...b, confidence: Math.floor((b.confidence * 100) / total)}));
  }

  const animalFound = data.animalFound === true && breeds.length > 0;
  const species = data.species === "dog" || data.species === "cat" ? data.species : "other";
  return {
    animalFound,
    species,
    speciesName: clean(data.speciesName, 60),
    mixed: animalFound && data.mixed === true,
    breeds: animalFound ? breeds : [],
    photoQuality: data.photoQuality === "poor" ? "poor" : "good",
    info: Object.fromEntries(INFO_KEYS.map((k) => [k, animalFound ? clean(data[k], 400) : ""])) as BreedScan["info"],
    note: clean(data.note, 300),
  };
}

// Joins the answer's text parts, leaving out the model's thinking.
export function answerTextOf(body: Json): string {
  const candidates = Array.isArray(body.candidates) ? body.candidates as Json[] : [];
  const parts = ((candidates[0]?.content as Json | undefined)?.parts ?? []) as Json[];
  return parts
    .filter((p) => p.thought !== true && typeof p.text === "string")
    .map((p) => p.text as string)
    .join("");
}
