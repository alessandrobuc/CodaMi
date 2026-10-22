import "./options";

import {FieldPath, FieldValue, Timestamp, getFirestore, type QueryDocumentSnapshot} from "firebase-admin/firestore";
import {getStorage} from "firebase-admin/storage";
import {onDocumentCreated} from "firebase-functions/firestore";
import {HttpsError, onCall} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";
import {onSchedule} from "firebase-functions/scheduler";
import {distanceBetween, geohashForLocation, geohashQueryBounds} from "geofire-common";

import {
  ACTIVE_STATUSES,
  EMERGENCY_STATUSES,
  EMERGENCY_TYPES,
  emergencyConfigOf,
  isStale,
  nextStatus,
  rankContacts,
  readContact,
  ringFor,
  snapshotOf,
  type Contact,
  type EmergencyAction,
  type EmergencyConfig,
  type EmergencyType,
  type RankedContact,
} from "./emergency";
import {emergencyText, type EmergencyMessageKey} from "./emergencyMessages";
import {pathOfUrl, quarantinePathOf} from "./moderation";
import {isCleared} from "./moderationFunctions";
import {chunk, languageOf} from "./notifications";
import {SAFE_ID_PATTERN, readString} from "./places";
import {oneOf} from "./support";
import {staffToAlert} from "./supportFunctions";
import {pushToUsers} from "./userPush";

const TRIGGER_REGION = "us-central1";
const EMERGENCY_COLOR = "#B42318";
const MAX_USERS_PER_BOUND = 2000;
const ACTIONS = ["helping", "resolved", "closed", "false_alarm", "reopen", "report_false"] as const;

const db = () => getFirestore();
const emergenciesRef = () => db().collection("emergencies");

async function loadConfig(): Promise<EmergencyConfig> {
  return emergencyConfigOf((await db().collection("config").doc("emergency").get()).data());
}

function typeLabel(lang: string, type: EmergencyType): string {
  return emergencyText(lang, `type_${type}` as EmergencyMessageKey);
}

// Users are placed by the centre of their city (set at sign-up), never by live location.
export function homeGeohashOf(data: Record<string, unknown> | undefined): string | null {
  const lat = data?.homeLat;
  const lng = data?.homeLng;
  return typeof lat === "number" && typeof lng === "number" ? geohashForLocation([lat, lng]) : null;
}

async function usersWithin(at: [number, number], km: number): Promise<{doc: QueryDocumentSnapshot; km: number}[]> {
  const bounds = geohashQueryBounds(at, km * 1000);
  const snaps = await Promise.all(bounds.map(([start, end]) =>
    db().collection("users").orderBy("homeGeohash").startAt(start).endAt(end).limit(MAX_USERS_PER_BOUND).get()));
  const seen = new Set<string>();
  const found: {doc: QueryDocumentSnapshot; km: number}[] = [];
  for (const doc of snaps.flatMap((s) => s.docs)) {
    if (seen.has(doc.id)) continue;
    seen.add(doc.id);
    const distance = distanceBetween([doc.get("homeLat"), doc.get("homeLng")], at);
    if (distance <= km) found.push({doc, km: distance});
  }
  return found;
}

function wantsAlerts(user: QueryDocumentSnapshot, ownerId: string): boolean {
  const blocked = user.get("blockedUsers");
  const prefs = user.get("notificationPrefs")?.emergency;
  return user.id !== ownerId &&
    user.get("disabled") !== true &&
    !(typeof blocked === "object" && blocked !== null && ownerId in blocked) &&
    prefs?.enabled !== false;
}

async function waitForPhoto(url: string | null, waitMs: number): Promise<string | null> {
  const path = pathOfUrl(url);
  if (!path) return null;
  const deadline = Date.now() + waitMs;
  for (;;) {
    if (await isCleared(path)) return url;
    if (Date.now() >= deadline) return null;
    await new Promise((resolve) => setTimeout(resolve, 1_000));
  }
}

export const onEmergencyCreated = onDocumentCreated(
  {document: "emergencies/{emergencyId}", region: TRIGGER_REGION, timeoutSeconds: 120},
  async (event) => {
    const data = event.data?.data();
    const id = event.params.emergencyId;
    const type = oneOf(EMERGENCY_TYPES, data?.type);
    if (!data || !type || typeof data.lat !== "number" || typeof data.lng !== "number") return;
    const at: [number, number] = [data.lat, data.lng];
    const ownerId = String(data.ownerId);
    const config = await loadConfig();

    const contactDocs = await db().collection("emergencyContacts").where("active", "==", true).get();
    const contacts = contactDocs.docs
      .map((d) => readContact(d.id, d.data()))
      .filter((c): c is Contact => c !== null);
    const ranked = rankContacts(contacts, type, {lat: at[0], lng: at[1]}, config);

    const nearby = (await usersWithin(at, config.ringsKm[config.ringsKm.length - 1]))
      .filter(({doc}) => wantsAlerts(doc, ownerId))
      .sort((a, b) => a.km - b.km);
    const ring = ringFor(config.ringsKm.map((km) => nearby.filter((u) => u.km <= km).length), config);
    const radiusKm = config.ringsKm[ring];
    const recipients = nearby.filter((u) => u.km <= radiusKm).slice(0, config.maxRecipients).map((u) => u.doc);

    await event.data!.ref.update({
      suggestedContacts: ranked.map(snapshotOf),
      alertRadiusKm: radiusKm,
      alertedUsers: recipients.length,
    });

    const photos = Array.isArray(data.photoUrls) ? data.photoUrls : [];
    const photoUrl = await waitForPhoto(typeof photos[0] === "string" ? photos[0] : null, 8_000);
    const place = String(data.placeLabel ?? data.city ?? "");
    await notifyNearby(recipients, id, type, place, photoUrl);
    await pushToUsers(await staffToAlert(), {
      title: (lang) => emergencyText(lang, "staffTitle"),
      body: (lang) => [typeLabel(lang, type), place].filter(Boolean).join(" · "),
    }, {emergencyId: id, kind: "emergency_staff"}, "support", {color: EMERGENCY_COLOR});
    if (config.emailEnabled) await emailContacts(ranked, id, type, data);

    logger.info("Emergency alerts sent", {id, type, radiusKm, users: recipients.length, contacts: ranked.length});
  },
);

async function notifyNearby(
  recipients: QueryDocumentSnapshot[],
  id: string,
  type: EmergencyType,
  place: string,
  photoUrl: string | null,
): Promise<void> {
  for (const group of chunk(recipients, 400)) {
    const batch = db().batch();
    for (const user of group) {
      const lang = languageOf(user.get("language"));
      batch.set(user.ref.collection("notifications").doc(), {
        kind: "emergency",
        title: emergencyText(lang, "nearbyTitle"),
        body: [typeLabel(lang, type), place].filter(Boolean).join(" · "),
        emergencyId: id,
        photoUrl,
        placeDetail: place,
        read: false,
        createdAt: FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
  }
  await pushToUsers(recipients.map((u) => u.id), {
    title: (lang) => emergencyText(lang, "nearbyTitle"),
    body: (lang) => [typeLabel(lang, type), place].filter(Boolean).join(" · "),
  }, {emergencyId: id, kind: "emergency"}, "emergency", {color: EMERGENCY_COLOR, imageUrl: photoUrl});
}

// Uses the Firebase "Trigger Email" extension format; nothing is sent until it is installed and enabled.
async function emailContacts(
  ranked: RankedContact[],
  id: string,
  type: EmergencyType,
  data: Record<string, unknown>,
): Promise<void> {
  const targets = ranked.filter((c) => c.email && c.verified && !c.isTest && c.inArea);
  const map = `https://www.google.com/maps/search/?api=1&query=${data.lat},${data.lng}`;
  for (const contact of targets) {
    await db().collection("mail").add({
      to: contact.email,
      message: {
        subject: `CodaMi: ${typeLabel("it", type)} – ${data.placeLabel ?? data.city ?? ""}`,
        text: [
          typeLabel("it", type),
          String(data.description ?? ""),
          `${data.placeLabel ?? ""} ${map}`,
          data.contactPhone ? `Tel: ${data.contactPhone}` : "",
          `ID: ${id}`,
        ].filter(Boolean).join("\n\n"),
      },
      emergencyId: id,
    });
  }
}

async function isStaffUser(uid: string): Promise<boolean> {
  const role = (await db().collection("users").doc(uid).get()).get("role");
  return role === "support" || role === "admin";
}

export const updateEmergency = onCall(async (request) => {
  if (!request.auth) throw new HttpsError("unauthenticated", "Please sign in again.");
  const uid = request.auth.uid;
  const id = readString(request.data, "emergencyId", {min: 1, max: 128, pattern: SAFE_ID_PATTERN});
  const action = oneOf(ACTIONS, (request.data as {action?: unknown}).action) as EmergencyAction | null;
  if (!action) throw new HttpsError("invalid-argument", "Unknown action.");
  const staff = await isStaffUser(uid);
  const ref = emergenciesRef().doc(id);

  const result = await db().runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    const status = oneOf(EMERGENCY_STATUSES, snap.get("status"));
    if (!snap.exists || !status) throw new HttpsError("not-found", "This emergency no longer exists.");
    const ownerId = snap.get("ownerId") as string;
    const next = nextStatus(status, action, {isOwner: ownerId === uid, isStaff: staff});
    if (!next) throw new HttpsError("failed-precondition", "This can't be done now.");

    if (action === "report_false") {
      const flagRef = ref.collection("flags").doc(uid);
      if ((await tx.get(flagRef)).exists) throw new HttpsError("already-exists", "You already reported this.");
      tx.set(flagRef, {at: FieldValue.serverTimestamp()});
      tx.update(ref, {falseReports: FieldValue.increment(1)});
      return {ownerId, status, next};
    }
    const helpers: string[] = Array.isArray(snap.get("helpers")) ? snap.get("helpers") : [];
    tx.update(ref, {
      status: next,
      updatedAt: FieldValue.serverTimestamp(),
      lastActivityAt: FieldValue.serverTimestamp(),
      ...(action === "helping" && !helpers.includes(uid) ? {helpers: FieldValue.arrayUnion(uid)} : {}),
      ...(next === "resolved" ? {resolvedAt: FieldValue.serverTimestamp()} : {}),
    });
    tx.set(ref.collection("events").doc(), {
      type: action,
      by: uid,
      byStaff: staff,
      from: status,
      to: next,
      at: FieldValue.serverTimestamp(),
    });
    return {ownerId, status, next};
  });

  if (action === "helping" && result.ownerId !== uid) {
    await pushToUsers([result.ownerId], {
      title: (lang) => emergencyText(lang, "helpingTitle"),
      body: (lang) => emergencyText(lang, "helpingBody"),
    }, {emergencyId: id, kind: "emergency_update"}, null, {color: EMERGENCY_COLOR});
  }
  if (action === "false_alarm") {
    await pushToUsers([result.ownerId], {
      title: (lang) => emergencyText(lang, "falseAlarmTitle"),
      body: (lang) => emergencyText(lang, "falseAlarmBody"),
    }, {emergencyId: id, kind: "emergency_update"}, null);
  }
  return {status: result.next};
});

// Closes quiet emergencies and gives older accounts a home geohash for nearby alerts.
export const emergencySweep = onSchedule("every 60 minutes", async () => {
  const config = await loadConfig();
  const now = Date.now();
  const cutoff = Timestamp.fromMillis(now - config.autoCloseHours * 3_600_000);
  const quiet = await emergenciesRef()
    .where("status", "in", [...ACTIVE_STATUSES])
    .where("lastActivityAt", "<=", cutoff)
    .limit(200)
    .get();
  for (const doc of quiet.docs) {
    const last = (doc.get("lastActivityAt") as Timestamp | undefined)?.toMillis() ?? 0;
    if (!isStale(last, now, config)) continue;
    await doc.ref.update({status: "closed", updatedAt: FieldValue.serverTimestamp(), autoClosed: true});
    await doc.ref.collection("events").add({type: "closed", by: "system", from: doc.get("status"), to: "closed", at: FieldValue.serverTimestamp()});
    await pushToUsers([doc.get("ownerId")], {
      title: (lang) => emergencyText(lang, "closedTitle"),
      body: (lang) => emergencyText(lang, "closedBody"),
    }, {emergencyId: doc.id, kind: "emergency_update"}, null);
  }

  const stateRef = db().collection("config").doc("emergencyBackfill");
  const state = (await stateRef.get()).data() ?? {};
  let filled = 0;
  if (state.done !== true) {
    let query = db().collection("users").orderBy(FieldPath.documentId()).limit(300);
    if (typeof state.lastId === "string") query = query.startAfter(state.lastId);
    const page = await query.get();
    for (const user of page.docs) {
      const hash = homeGeohashOf(user.data());
      if (hash && user.get("homeGeohash") !== hash) {
        await user.ref.update({homeGeohash: hash});
        filled++;
      }
    }
    const last = page.docs[page.docs.length - 1]?.id;
    await stateRef.set(page.size < 300 ? {done: true} : {lastId: last}, {merge: true});
  }
  logger.info("Emergency sweep", {closed: quiet.size, geohashes: filled});
});

// Placeholders for testing. Clearly marked, never verified and never emailed.
const TEST_CONTACTS = [
  {name: "TEST – Veterinario di prova (Milano)", kind: "vet", city: "Milano", lat: 45.4642, lng: 9.19, open24h: true},
  {name: "TEST – Associazione di prova (Milano)", kind: "association", city: "Milano", lat: 45.478, lng: 9.21, open24h: false},
  {name: "TEST – Servizio veterinario di prova (Roma)", kind: "public_service", city: "Roma", lat: 41.9028, lng: 12.4964, open24h: true},
  {name: "TEST – Veterinario di prova (Roma)", kind: "vet", city: "Roma", lat: 41.89, lng: 12.48, open24h: false},
  {name: "TEST – Associazione di prova (Napoli)", kind: "association", city: "Napoli", lat: 40.8518, lng: 14.2681, open24h: false},
  {name: "TEST – Veterinario di prova (Torino)", kind: "vet", city: "Torino", lat: 45.0703, lng: 7.6869, open24h: true},
];

export const seedTestContacts = onCall(async (request) => {
  if (!request.auth) throw new HttpsError("unauthenticated", "Please sign in again.");
  const role = (await db().collection("users").doc(request.auth.uid).get()).get("role");
  if (role !== "admin") throw new HttpsError("permission-denied", "Only admins can do this.");
  const existing = await db().collection("emergencyContacts").where("isTest", "==", true).limit(1).get();
  if (!existing.empty) return {added: 0};
  const batch = db().batch();
  TEST_CONTACTS.forEach((contact, i) => {
    batch.set(db().collection("emergencyContacts").doc(), {
      ...contact,
      phones: [`+39 000 000 00${String(i + 1).padStart(2, "0")}`],
      email: `test-contact-${i + 1}@example.com`,
      address: `${contact.city} (indirizzo di prova)`,
      areaKm: 30,
      types: [],
      hours: contact.open24h ? null : "Lun–Ven 9:00–18:00 (di prova)",
      verified: false,
      recommended: false,
      active: true,
      isTest: true,
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
    });
  });
  await batch.commit();
  return {added: TEST_CONTACTS.length};
});

// Used by account deletion.
export async function deleteEmergencyData(uid: string): Promise<void> {
  const owned = await emergenciesRef().where("ownerId", "==", uid).get();
  for (const doc of owned.docs) await db().recursiveDelete(doc.ref);
  const bucket = getStorage().bucket();
  await Promise.all([
    bucket.deleteFiles({prefix: `emergencies/${uid}/`}),
    bucket.deleteFiles({prefix: quarantinePathOf(`emergencies/${uid}/`)}),
  ]);
}
