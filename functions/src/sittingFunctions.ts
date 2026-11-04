import "./options";

import {FieldValue, Timestamp, getFirestore, type DocumentSnapshot} from "firebase-admin/firestore";
import {HttpsError, onCall, type CallableRequest} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";
import {onDocumentCreated, onDocumentUpdated} from "firebase-functions/firestore";

import {DEFAULT_CHANNEL, languageOf} from "./notifications";
import {dayKey} from "./points";
import {sendToTokens, tokensOf} from "./push";
import {
  confirmStep,
  messagePreview,
  offerIdOf,
  ratingOf,
  reviewBlockOf,
  reviewInputOf,
  sittingConfigOf,
  sittingText,
} from "./sitting";
import {requireStaff} from "./supportFunctions";

const TRIGGER_REGION = "us-central1";
const ID = /^[A-Za-z0-9_-]{1,128}$/;
const db = () => getFirestore();
const requests = () => db().collection("sittingRequests");
const offers = () => db().collection("sittingOffers");
const sitters = () => db().collection("sitters");
const reviews = () => db().collection("sittingReviews");

function uidOf(request: CallableRequest): string {
  if (!request.auth) throw new HttpsError("unauthenticated", "Please sign in again.");
  return request.auth.uid;
}

function idOf(data: unknown, field: string): string {
  const value = (data as Record<string, unknown> | null)?.[field];
  if (typeof value !== "string" || !ID.test(value)) throw new HttpsError("invalid-argument", `"${field}" is not valid.`);
  return value;
}

async function nameOf(uid: string): Promise<string> {
  const user = await db().collection("users").doc(uid).get();
  return String(user.get("name") ?? "").trim() || "CodaMi";
}

async function push(
  uid: string,
  title: (lang: string) => string,
  body: (lang: string) => string,
  data: Record<string, string>,
  blockedBy?: string,
): Promise<void> {
  try {
    const user = await db().collection("users").doc(uid).get();
    if (!user.exists) return;
    // A user who blocked the sender gets nothing from them.
    if (blockedBy && typeof user.get(`blockedUsers.${blockedBy}`) === "string") return;
    const tokens = tokensOf(user);
    if (tokens.length === 0) return;
    const lang = languageOf(user.get("language"));
    await sendToTokens(tokens, {
      notification: {title: title(lang), body: body(lang)},
      data,
      android: {priority: "high", notification: {channelId: DEFAULT_CHANNEL, tag: data.tag ?? data.kind}},
      apns: {payload: {aps: {sound: "default"}}},
    });
  } catch (error) {
    logger.error("Pet sitting push failed", {kind: data.kind, error});
  }
}

// The owner picks one offer: one transaction books the request and declines the other offers.
// Pushes go out from onSittingRequestUpdated, so the app gets its answer straight away.
export const acceptSittingOffer = onCall(async (request) => {
  const uid = uidOf(request);
  const requestId = idOf(request.data, "requestId");
  const sitterId = idOf(request.data, "sitterId");
  const requestRef = requests().doc(requestId);
  const offerRef = offers().doc(offerIdOf(requestId, sitterId));
  await db().runTransaction(async (tx) => {
    const [req, offer, pending] = await Promise.all([
      tx.get(requestRef),
      tx.get(offerRef),
      tx.get(offers().where("requestId", "==", requestId).where("status", "==", "pending")),
    ]);
    if (!req.exists || req.get("ownerId") !== uid) throw new HttpsError("permission-denied", "Not your request.");
    if (req.get("status") !== "open") throw new HttpsError("failed-precondition", "This request is no longer open.");
    if (!offer.exists || offer.get("status") !== "pending") {
      throw new HttpsError("failed-precondition", "This offer is no longer available.");
    }
    tx.update(requestRef, {status: "booked", sitterId, sitterName: offer.get("sitterName") ?? "", bookedAt: FieldValue.serverTimestamp()});
    tx.update(offerRef, {status: "accepted"});
    pending.docs.filter((d) => d.id !== offerRef.id).forEach((d) => tx.update(d.ref, {status: "declined"}));
  });
  return {booked: true};
});

// Each side confirms after the start date; when both have, the service is done.
export const confirmSitting = onCall(async (request) => {
  const uid = uidOf(request);
  const requestId = idOf(request.data, "requestId");
  const ref = requests().doc(requestId);
  const today = dayKey(Date.now());
  const done = await db().runTransaction(async (tx) => {
    const req = await tx.get(ref);
    const step = confirmStep(req.data(), uid, today);
    if (!step) throw new HttpsError("failed-precondition", "This service can't be confirmed now.");
    tx.update(ref, {
      [step.field]: true,
      ...(step.done ? {status: "done", doneAt: FieldValue.serverTimestamp()} : {}),
    });
    if (step.done) tx.set(sitters().doc(req.get("sitterId")), {completedCount: FieldValue.increment(1)}, {merge: true});
    return step.done;
  });
  return {done};
});

// Tells the other side when a request is booked or one side has confirmed.
export const onSittingRequestUpdated = onDocumentUpdated(
  {document: "sittingRequests/{requestId}", region: TRIGGER_REGION},
  async (event) => {
    const before = event.data?.before.data();
    const after = event.data?.after.data();
    if (!before || !after) return;
    const requestId = event.params.requestId;
    const ownerId = String(after.ownerId ?? "");
    const sitterId = String(after.sitterId ?? "");
    if (before.status === "open" && after.status === "booked" && sitterId) {
      const owner = await nameOf(ownerId);
      await push(sitterId, (l) => sittingText(l, "acceptedTitle", owner), (l) => sittingText(l, "acceptedBody", owner),
        {kind: "sitting_accepted", requestId});
      return;
    }
    if (after.status !== "booked") return;
    const ownerNow = after.ownerConfirmed === true && before.ownerConfirmed !== true;
    const sitterNow = after.sitterConfirmed === true && before.sitterConfirmed !== true;
    if (!ownerNow && !sitterNow) return;
    const [from, to] = ownerNow ? [ownerId, sitterId] : [sitterId, ownerId];
    const name = await nameOf(from);
    await push(to, (l) => sittingText(l, "confirmTitle", name), (l) => sittingText(l, "confirmBody", name),
      {kind: "sitting_confirm", requestId});
  },
);

async function refreshRating(sitterId: string): Promise<void> {
  const all = await reviews().where("sitterId", "==", sitterId).get();
  await sitters().doc(sitterId).set(ratingOf(all.docs.map((d) => d.data())), {merge: true});
}

// One verified review per completed service, written only here.
export const reviewSitter = onCall(async (request) => {
  const uid = uidOf(request);
  const input = reviewInputOf(request.data);
  if (!input) throw new HttpsError("invalid-argument", "Choose 1 to 5 stars and keep the text under 800 characters.");
  const [req, user, config] = await Promise.all([
    requests().doc(input.requestId).get(),
    db().collection("users").doc(uid).get(),
    db().collection("config").doc("sitting").get(),
  ]);
  const created = user.get("createdAt");
  const ageDays = created instanceof Timestamp ? (Date.now() - created.toMillis()) / 86_400_000 : 0;
  const block = reviewBlockOf(req.data(), uid, ageDays, sittingConfigOf(config.data()).minAccountDays);
  if (block) throw new HttpsError("failed-precondition", `Review not allowed: ${block}.`);
  const sitterId = req.get("sitterId") as string;
  try {
    await reviews().doc(input.requestId).create({
      requestId: input.requestId,
      sitterId,
      reviewerId: uid,
      reviewerName: String(user.get("name") ?? "").trim(),
      stars: input.stars,
      text: input.text,
      hidden: false,
      createdAt: FieldValue.serverTimestamp(),
    });
  } catch {
    throw new HttpsError("already-exists", "You already reviewed this service.");
  }
  await refreshRating(sitterId);
  return {reviewed: true};
});

// Hiding a review takes it out of the sitter's rating too.
export const adminSetReviewHidden = onCall(async (request) => {
  await requireStaff(request);
  const id = idOf(request.data, "reviewId");
  const hidden = (request.data as {hidden?: unknown} | null)?.hidden === true;
  const ref = reviews().doc(id);
  const review = await ref.get();
  if (!review.exists) throw new HttpsError("not-found", "Review not found.");
  await ref.update({hidden});
  await refreshRating(review.get("sitterId"));
  return {hidden};
});

export const onSittingOffer = onDocumentCreated(
  {document: "sittingOffers/{offerId}", region: TRIGGER_REGION},
  async (event) => {
    const offer = event.data?.data();
    if (!offer) return;
    const req = await requests().doc(String(offer.requestId)).get();
    const ownerId = req.get("ownerId");
    if (typeof ownerId !== "string") return;
    await requests().doc(req.id).update({offerCount: FieldValue.increment(1)});
    const name = String(offer.sitterName ?? "");
    await push(ownerId, (l) => sittingText(l, "offerTitle", name), (l) => sittingText(l, "offerBody", name),
      {kind: "sitting_offer", requestId: req.id}, String(offer.sitterId));
  },
);

export const onSittingMessage = onDocumentCreated(
  {document: "sittingChats/{chatId}/messages/{messageId}", region: TRIGGER_REGION},
  async (event) => {
    const message = event.data?.data();
    if (!message || typeof message.to !== "string" || typeof message.senderId !== "string") return;
    const name = await nameOf(message.senderId);
    await push(message.to, () => name, () => messagePreview(message.text),
      {kind: "sitting_message", chatId: event.params.chatId, tag: `chat_${event.params.chatId}`}, message.senderId);
  },
);

async function deleteDocs(snaps: DocumentSnapshot[]): Promise<void> {
  for (let i = 0; i < snaps.length; i += 400) {
    const batch = db().batch();
    snaps.slice(i, i + 400).forEach((d) => batch.delete(d.ref));
    await batch.commit();
  }
}

export async function deleteSittingData(uid: string): Promise<void> {
  const [mine, myOffers, chats, written, about, flags] = await Promise.all([
    requests().where("ownerId", "==", uid).get(),
    offers().where("sitterId", "==", uid).get(),
    db().collection("sittingChats").where("members", "array-contains", uid).get(),
    reviews().where("reviewerId", "==", uid).get(),
    reviews().where("sitterId", "==", uid).get(),
    db().collection("sittingFlags").where("reporterId", "==", uid).get(),
  ]);
  const offersOnMine = await Promise.all(mine.docs.map((r) => offers().where("requestId", "==", r.id).get()));
  await deleteDocs([...mine.docs, ...myOffers.docs, ...offersOnMine.flatMap((s) => s.docs), ...about.docs, ...flags.docs]);
  for (const chat of chats.docs) await db().recursiveDelete(chat.ref);
  const touched = new Set(written.docs.map((d) => String(d.get("sitterId"))));
  await deleteDocs(written.docs);
  await sitters().doc(uid).delete();
  await Promise.all([...touched].filter((id) => id !== uid).map(refreshRating));
}
