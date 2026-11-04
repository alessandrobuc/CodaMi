import "./options";

import {applicationDefault} from "firebase-admin/app";
import {FieldValue, getFirestore} from "firebase-admin/firestore";
import {HttpsError, onCall} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";

import {dayKey} from "./points";
import {
  DEFAULT_SCANNER,
  FALLBACK_MODELS,
  LANGUAGE_NAMES,
  MAX_IMAGE_BYTES,
  SCAN_SCHEMA,
  answerTextOf,
  imageTypeOf,
  modelTier,
  nextScanUsage,
  parseScan,
  scanPrompt,
  scanModelsOf,
  scannerConfigOf,
  type ImageType,
} from "./scanner";
import {requireStaff} from "./supportFunctions";

const db = () => getFirestore();
const usageRef = (uid: string) => db().collection("scanUsage").doc(uid);

// The global endpoint serves the newest Gemini models first.
const GEMINI_URL = (project: string, model: string) =>
  `https://aiplatform.googleapis.com/v1/projects/${project}/locations/global/publishers/google/models/${model}:generateContent`;

// Gemini does not run in the emulator, so tests get this answer.
const EMULATOR_ANSWER = {
  animalFound: true,
  species: "dog",
  speciesName: "Dog",
  mixed: false,
  breeds: [{name: "Labrador Retriever", confidence: 74}, {name: "Golden Retriever", confidence: 16}],
  photoQuality: "good",
  size: "Large",
  weight: "25-36 kg",
  lifeSpan: "10-12 years",
  temperament: "Friendly and outgoing",
  characteristics: "Short dense coat, otter tail",
  care: "Daily exercise",
  note: "",
};

async function askGemini(model: string, image: string, mimeType: ImageType, language: string): Promise<unknown> {
  if (process.env.FUNCTIONS_EMULATOR === "true") return EMULATOR_ANSWER;
  const project = process.env.GCLOUD_PROJECT ?? process.env.GOOGLE_CLOUD_PROJECT ?? "";
  const {access_token: token} = await applicationDefault().getAccessToken();
  const response = await fetch(GEMINI_URL(project, model), {
    method: "POST",
    headers: {"Authorization": `Bearer ${token}`, "Content-Type": "application/json"},
    body: JSON.stringify({
      contents: [{role: "user", parts: [{inlineData: {mimeType, data: image}}, {text: scanPrompt(language)}]}],
      generationConfig: {responseMimeType: "application/json", responseSchema: SCAN_SCHEMA, maxOutputTokens: 4096},
    }),
    signal: AbortSignal.timeout(60_000),
  });
  const body = (await response.json().catch(() => ({}))) as Record<string, unknown>;
  if (!response.ok) {
    throw new Error(`Gemini ${model} failed (${response.status}): ${JSON.stringify(body.error ?? body)}`);
  }
  return JSON.parse(answerTextOf(body));
}

export const scanBreed = onCall({timeoutSeconds: 90, memory: "512MiB"}, async (request) => {
  if (!request.auth) throw new HttpsError("unauthenticated", "Please sign in again.");
  const uid = request.auth.uid;
  const data = (request.data ?? {}) as Record<string, unknown>;
  const language = typeof data.language === "string" && data.language in LANGUAGE_NAMES ? data.language : "en";
  const image = typeof data.image === "string" ? data.image : "";
  const bytes = image.length <= Math.ceil(MAX_IMAGE_BYTES / 3) * 4 ? Buffer.from(image, "base64") : Buffer.alloc(0);
  const mimeType = bytes.length >= 1024 ? imageTypeOf(bytes) : null;
  if (!mimeType) throw new HttpsError("invalid-argument", "Please choose a photo (JPEG, PNG, WebP or HEIC, up to 4 MB).");

  const config = scannerConfigOf((await db().collection("config").doc("scanner").get()).data());
  if (!config.enabled && (await db().collection("users").doc(uid).get()).get("role") !== "admin") {
    throw new HttpsError("failed-precondition", "The breed scanner is off.");
  }

  const day = dayKey(Date.now());
  const allowed = await db().runTransaction(async (tx) => {
    const next = nextScanUsage((await tx.get(usageRef(uid))).data(), day, config.dailyScans);
    if (next) tx.set(usageRef(uid), next);
    return next !== null;
  });
  if (!allowed) throw new HttpsError("resource-exhausted", "Daily limit reached. Please try again tomorrow.");

  try {
    const scan = parseScan(await askGemini(config.model, bytes.toString("base64"), mimeType, language));
    logger.info("Breed scanned", {
      model: config.model, found: scan.animalFound, species: scan.species,
      top: scan.breeds[0]?.confidence ?? 0, mixed: scan.mixed, quality: scan.photoQuality,
    });
    return scan;
  } catch (error) {
    logger.error("Breed scan failed", error);
    // A failed scan doesn't count towards the daily limit.
    await usageRef(uid).update({scans: FieldValue.increment(-1)}).catch(() => undefined);
    throw new HttpsError("unavailable", "The scanner is not available right now. Please try again later.");
  }
});

const MODELS_URL = "https://aiplatform.googleapis.com/v1beta1/publishers/google/models";
const MODELS_CACHE_MS = 60 * 60 * 1000;
let modelsCache: {at: number; models: string[]} | null = null;

async function googleModels(): Promise<string[]> {
  if (process.env.FUNCTIONS_EMULATOR === "true") throw new Error("No model list in the emulator");
  if (modelsCache && Date.now() - modelsCache.at < MODELS_CACHE_MS) return modelsCache.models;
  const {access_token: token} = await applicationDefault().getAccessToken();
  const all: Record<string, unknown>[] = [];
  let pageToken = "";
  for (let page = 0; page < 10; page++) {
    const query = new URLSearchParams({pageSize: "200", ...(pageToken ? {pageToken} : {})});
    const response = await fetch(`${MODELS_URL}?${query}`, {
      headers: {Authorization: `Bearer ${token}`},
      signal: AbortSignal.timeout(15_000),
    });
    const body = (await response.json().catch(() => ({}))) as Record<string, unknown>;
    if (!response.ok) throw new Error(`Model list failed (${response.status}): ${JSON.stringify(body.error ?? body)}`);
    all.push(...(Array.isArray(body.publisherModels) ? body.publisherModels as Record<string, unknown>[] : []));
    pageToken = typeof body.nextPageToken === "string" ? body.nextPageToken : "";
    if (!pageToken) break;
  }
  const models = scanModelsOf(all);
  if (models.length > 0) modelsCache = {at: Date.now(), models};
  return models;
}

// For the admin's model picker: the Gemini models Google offers now.
// invoker is set so every deploy lets the app reach it (the first deploy left it out).
export const scannerModels = onCall({invoker: "public"}, async (request) => {
  await requireStaff(request, true);
  let models: string[] = [];
  let fromGoogle = true;
  try {
    models = await googleModels();
  } catch (error) {
    logger.warn("Gemini model list not read, using the usual models", error);
  }
  if (models.length === 0) {
    models = FALLBACK_MODELS;
    fromGoogle = false;
  }
  return {
    models: models.map((id) => ({id, tier: modelTier(id)})),
    recommended: DEFAULT_SCANNER.model,
    fromGoogle,
  };
});

export async function deleteScanUsage(uid: string): Promise<void> {
  await usageRef(uid).delete();
}
