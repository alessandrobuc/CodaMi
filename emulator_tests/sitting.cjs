// Pet sitting: profiles, requests, offers, booking, both-sides confirmation, verified reviews, chats, blocking,
// reports and removal with the account. Run with emulator_tests/README.md.
const path = require("path");
const req = require("module").createRequire(path.join(__dirname, "../functions/package.json"));
const {initializeApp} = req("firebase-admin/app");
const {getFirestore, Timestamp} = req("firebase-admin/firestore");

const PROJECT = "demo-codami";
initializeApp({projectId: PROJECT});
const db = getFirestore();

let failures = 0;
function ok(cond, msg) {
  console.log(`${cond ? "PASS" : "FAIL"}  ${msg}`);
  if (!cond) failures++;
}
const wait = (ms) => new Promise((r) => setTimeout(r, ms));

async function signUp(email) {
  const r = await fetch("http://127.0.0.1:9099/identitytoolkit.googleapis.com/v1/accounts:signUp?key=fake", {
    method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify({email, password: "secret123", returnSecureToken: true}),
  });
  const b = await r.json();
  return {uid: b.localId, token: b.idToken};
}

async function call(name, token, data) {
  const r = await fetch(`http://127.0.0.1:5001/${PROJECT}/europe-west1/${name}`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({data}),
  });
  const body = await r.json();
  return {status: r.status, result: body.result, error: body.error};
}

const FS = `http://127.0.0.1:8080/v1/projects/${PROJECT}/databases/(default)/documents`;
const docName = (p) => `projects/${PROJECT}/databases/(default)/documents/${p}`;
function value(v) {
  if (typeof v === "string") return {stringValue: v};
  if (typeof v === "number") return Number.isInteger(v) ? {integerValue: String(v)} : {doubleValue: v};
  if (typeof v === "boolean") return {booleanValue: v};
  if (Array.isArray(v)) return {arrayValue: {values: v.map(value)}};
  if (v && typeof v === "object") return {mapValue: {fields: fields(v)}};
  return {nullValue: null};
}
const fields = (obj) => Object.fromEntries(Object.entries(obj).map(([k, v]) => [k, value(v)]));
async function write(token, p, data, stamps = ["updatedAt"], mask) {
  const r = await fetch(`${FS}:commit`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({writes: [{
      update: {name: docName(p), fields: fields(data)},
      ...(mask ? {updateMask: {fieldPaths: mask}} : {}),
      updateTransforms: stamps.map((f) => ({fieldPath: f, setToServerValue: "REQUEST_TIME"})),
    }]}),
  });
  return r.status;
}
const patch = (token, p, data, stamps = []) => write(token, p, data, stamps, Object.keys(data));
async function get(token, p) {
  return (await fetch(`${FS}/${p}`, {headers: {Authorization: `Bearer ${token}`}})).status;
}

const today = new Intl.DateTimeFormat("en-CA", {timeZone: "Europe/Rome"}).format(new Date());
const later = new Intl.DateTimeFormat("en-CA", {timeZone: "Europe/Rome"}).format(new Date(Date.now() + 5 * 86_400_000));
const both = ["createdAt", "updatedAt"];
const profile = (uid, extra = {}) => ({
  uid, name: "Sara", about: "I love dogs and cats.", experience: "", species: ["dog"], services: ["visits"],
  availability: "", city: "Milano", lat: 45.46, lng: 9.19, areaKm: 10, active: true, hidden: false, ...extra,
});
const request = (uid, extra = {}) => ({
  ownerId: uid, ownerName: "Marta", petIds: ["p1"], petNames: ["Luna"], species: ["dog"], service: "visits",
  start: later, end: later, city: "Milano", lat: 45.46, lng: 9.19, notes: "", status: "open", hidden: false, ...extra,
});
const offer = (requestId, ownerId, sitterId, extra = {}) => ({
  requestId, ownerId, sitterId, sitterName: "Sara", message: "Happy to help!", status: "pending", ...extra,
});

(async () => {
  const admin = await signUp("admin@sit.test");
  const owner = await signUp("owner@sit.test");
  const sitter = await signUp("sitter@sit.test");
  const other = await signUp("other@sit.test");
  const stranger = await signUp("stranger@sit.test");
  const old = Timestamp.fromMillis(Date.now() - 30 * 86_400_000);
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin", createdAt: old});
  await db.collection("users").doc(owner.uid).set({name: "Marta", role: "user", createdAt: Timestamp.now()});
  await db.collection("users").doc(sitter.uid).set({name: "Sara", role: "user", createdAt: old});
  await db.collection("users").doc(other.uid).set({name: "Bo", role: "user", createdAt: old});
  await db.collection("users").doc(stranger.uid).set({name: "X", role: "user", createdAt: old});

  // Settings
  ok(await write(admin.token, "config/sitting", {enabled: true, minAccountDays: 3, updatedBy: admin.uid}) === 200, "admin saves pet sitting settings");
  ok(await write(owner.token, "config/sitting", {enabled: false, minAccountDays: 3, updatedBy: owner.uid}) === 403, "users can't change them");

  // Sitter profiles
  ok(await write(sitter.token, `sitters/${sitter.uid}`, profile(sitter.uid), both) === 200, "a user creates their sitter profile");
  ok(await write(other.token, `sitters/${other.uid}`, profile(other.uid, {name: "Bo"}), both) === 200, "a second sitter joins");
  ok(await write(stranger.token, `sitters/${stranger.uid}`, profile(stranger.uid, {ratingSum: 50, reviewCount: 10}), both) === 403,
    "nobody writes their own rating");
  ok(await write(stranger.token, `sitters/${stranger.uid}`, profile(stranger.uid, {about: "hi"}), both) === 403, "an empty 'about me' is refused");
  ok(await write(stranger.token, `sitters/${sitter.uid}`, profile(sitter.uid), both) === 403, "nobody writes someone else's profile");
  ok(await patch(sitter.token, `sitters/${sitter.uid}`, {about: "Dogs, cats and rabbits welcome.", updatedAt: null}, ["updatedAt"]) === 200,
    "the sitter edits their profile");
  ok(await patch(sitter.token, `sitters/${sitter.uid}`, {completedCount: 99}) === 403, "nobody changes their completed count");
  ok(await get(owner.token, `sitters/${sitter.uid}`) === 200, "owners see sitter profiles");

  // Requests
  ok(await write(owner.token, "sittingRequests/r1", request(owner.uid), both) === 200, "an owner publishes a request");
  ok(await write(owner.token, "sittingRequests/r2", request(owner.uid, {start: today, end: today}), both) === 200, "and one starting today");
  ok(await write(owner.token, "sittingRequests/bad1", request(owner.uid, {status: "booked"}), both) === 403, "a request can't start as booked");
  ok(await write(owner.token, "sittingRequests/bad2", request(owner.uid, {end: "2020-01-01"}), both) === 403, "an end before the start is refused");
  ok(await write(owner.token, "sittingRequests/bad3", request(owner.uid, {offerCount: 9}), both) === 403, "the offer count can't be set by users");
  ok(await write(owner.token, "sittingRequests/bad4", request(owner.uid, {address: "Via Roma 1"}), both) === 403, "no address field");
  ok(await write(sitter.token, "sittingRequests/bad5", request(owner.uid), both) === 403, "nobody publishes in someone else's name");
  ok(await get(sitter.token, "sittingRequests/r1") === 200, "sitters see requests");
  ok(await patch(owner.token, "sittingRequests/r1", {notes: "Two walks a day", updatedAt: null}, ["updatedAt"]) === 200, "the owner edits the notes");
  ok(await patch(owner.token, "sittingRequests/r1", {status: "booked", updatedAt: null}, ["updatedAt"]) === 403, "the owner can't book by hand");
  ok(await patch(sitter.token, "sittingRequests/r1", {notes: "x", updatedAt: null}, ["updatedAt"]) === 403, "others can't edit a request");

  // Offers
  const o1 = `r1_${sitter.uid}`;
  ok(await write(sitter.token, `sittingOffers/${o1}`, offer("r1", owner.uid, sitter.uid), ["createdAt"]) === 200, "a sitter sends an offer");
  ok(await write(other.token, `sittingOffers/r1_${other.uid}`, offer("r1", owner.uid, other.uid, {sitterName: "Bo"}), ["createdAt"]) === 200,
    "a second sitter offers too");
  ok(await write(stranger.token, `sittingOffers/r1_${stranger.uid}`, offer("r1", owner.uid, stranger.uid), ["createdAt"]) === 403,
    "no offers without a sitter profile");
  ok(await write(sitter.token, `sittingOffers/r1_x`, offer("r1", owner.uid, sitter.uid), ["createdAt"]) === 403, "the offer ID must be the sitter's");
  ok(await write(owner.token, `sittingOffers/r1_${owner.uid}`, offer("r1", owner.uid, owner.uid), ["createdAt"]) === 403,
    "no offers on your own request");
  ok(await write(sitter.token, `sittingOffers/r2_${sitter.uid}`, offer("r2", owner.uid, sitter.uid, {status: "accepted"}), ["createdAt"]) === 403,
    "an offer starts as waiting");
  ok(await get(owner.token, `sittingOffers/${o1}`) === 200 && await get(sitter.token, `sittingOffers/${o1}`) === 200, "owner and sitter read the offer");
  ok(await get(stranger.token, `sittingOffers/${o1}`) === 403, "nobody else reads it");
  let counted;
  // The trigger can take a while to start on the emulator.
  for (let i = 0; i < 60 && counted !== 2; i++) {
    await wait(500);
    counted = (await db.collection("sittingRequests").doc("r1").get()).get("offerCount");
  }
  ok(counted === 2, "the server counts the offers");

  // Booking
  ok((await call("acceptSittingOffer", stranger.token, {requestId: "r1", sitterId: sitter.uid})).error?.status === "PERMISSION_DENIED",
    "only the owner accepts an offer");
  const accept = await call("acceptSittingOffer", owner.token, {requestId: "r1", sitterId: sitter.uid});
  const r1 = (await db.collection("sittingRequests").doc("r1").get()).data();
  ok(accept.status === 200 && r1.status === "booked" && r1.sitterId === sitter.uid, "accepting books the request with that sitter");
  ok((await db.collection("sittingOffers").doc(o1).get()).get("status") === "accepted", "the offer is accepted");
  ok((await db.collection("sittingOffers").doc(`r1_${other.uid}`).get()).get("status") === "declined", "the other offers are declined");
  ok((await call("acceptSittingOffer", owner.token, {requestId: "r1", sitterId: other.uid})).error?.status === "FAILED_PRECONDITION",
    "a booked request can't be booked again");
  ok((await call("confirmSitting", owner.token, {requestId: "r1"})).error?.status === "FAILED_PRECONDITION", "no confirming before the start");

  // Confirmation on the request starting today
  await write(sitter.token, `sittingOffers/r2_${sitter.uid}`, offer("r2", owner.uid, sitter.uid), ["createdAt"]);
  await call("acceptSittingOffer", owner.token, {requestId: "r2", sitterId: sitter.uid});
  ok((await call("confirmSitting", stranger.token, {requestId: "r2"})).error?.status === "FAILED_PRECONDITION", "outsiders can't confirm");
  ok((await call("reviewSitter", owner.token, {requestId: "r2", stars: 5})).error?.status === "FAILED_PRECONDITION", "no review before both confirm");
  const first = await call("confirmSitting", owner.token, {requestId: "r2"});
  ok(first.status === 200 && first.result.done === false, "the owner confirms; it waits for the sitter");
  ok((await call("confirmSitting", owner.token, {requestId: "r2"})).error?.status === "FAILED_PRECONDITION", "no confirming twice");
  const second = await call("confirmSitting", sitter.token, {requestId: "r2"});
  ok(second.status === 200 && second.result.done === true, "the sitter confirms too: the service is done");
  ok((await db.collection("sitters").doc(sitter.uid).get()).get("completedCount") === 1, "the sitter's completed count goes up");

  // Verified reviews
  ok((await call("reviewSitter", sitter.token, {requestId: "r2", stars: 5})).error?.status === "FAILED_PRECONDITION", "the sitter can't review themself");
  ok((await call("reviewSitter", owner.token, {requestId: "r2", stars: 5})).error?.message?.includes("too_new"),
    "a brand-new account has to wait before reviewing");
  await write(admin.token, "config/sitting", {enabled: true, minAccountDays: 0, updatedBy: admin.uid});
  ok((await call("reviewSitter", owner.token, {requestId: "r2", stars: 6})).error?.status === "INVALID_ARGUMENT", "stars are 1 to 5");
  ok((await call("reviewSitter", owner.token, {requestId: "r2", stars: 4, text: "Very kind"})).status === 200, "the owner leaves a verified review");
  ok((await call("reviewSitter", owner.token, {requestId: "r2", stars: 5})).error?.status === "ALREADY_EXISTS", "one review per service");
  let s = (await db.collection("sitters").doc(sitter.uid).get()).data();
  ok(s.ratingSum === 4 && s.reviewCount === 1, "the rating is updated by the server");
  ok(await write(owner.token, "sittingReviews/fake", {sitterId: sitter.uid, stars: 5, hidden: false}, ["createdAt"]) === 403,
    "reviews can't be written from the app");
  ok((await call("reviewSitter", owner.token, {requestId: "r1", stars: 5})).error?.status === "FAILED_PRECONDITION",
    "no review for a service that wasn't completed");
  ok((await call("adminSetReviewHidden", stranger.token, {reviewId: "r2", hidden: true})).error?.status === "PERMISSION_DENIED",
    "only staff hide reviews");
  ok((await call("adminSetReviewHidden", admin.token, {reviewId: "r2", hidden: true})).status === 200, "staff hide a review");
  s = (await db.collection("sitters").doc(sitter.uid).get()).data();
  ok(s.reviewCount === 0 && s.ratingSum === 0, "a hidden review leaves the rating");
  ok(await get(other.token, "sittingReviews/r2") === 403, "others can't read a hidden review");

  // Chats
  const [a, b] = [owner.uid, sitter.uid].sort();
  const chatId = `${a}_${b}`;
  const chat = {members: [a, b], names: {[owner.uid]: "Marta", [sitter.uid]: "Sara"}, lastMessage: "", lastSender: "", readAt: {}};
  ok(await write(owner.token, `sittingChats/${chatId}`, chat, ["createdAt"]) === 200, "an owner opens a chat with a sitter");
  ok(await write(stranger.token, `sittingChats/${chatId}x`, chat, ["createdAt"]) === 403, "nobody opens a chat for two other people");
  ok(await write(owner.token, `sittingChats/${chatId}/messages/m1`, {senderId: owner.uid, to: sitter.uid, text: "Hi Sara!"}, ["at"]) === 200,
    "a member sends a message");
  ok(await write(stranger.token, `sittingChats/${chatId}/messages/m2`, {senderId: stranger.uid, to: sitter.uid, text: "Hi"}, ["at"]) === 403,
    "outsiders can't write in the chat");
  ok(await write(owner.token, `sittingChats/${chatId}/messages/m3`, {senderId: owner.uid, to: owner.uid, text: "Hi"}, ["at"]) === 403,
    "a message goes to the other member");
  ok(await write(owner.token, `sittingChats/${chatId}/messages/m4`, {senderId: owner.uid, to: sitter.uid, text: "x".repeat(1001)}, ["at"]) === 403,
    "messages up to 1000 characters");
  ok(await get(sitter.token, `sittingChats/${chatId}/messages/m1`) === 200, "the other member reads it");
  ok(await get(stranger.token, `sittingChats/${chatId}/messages/m1`) === 403, "nobody else reads it");
  ok(await get(admin.token, `sittingChats/${chatId}`) === 403, "chats are private, even from admins");
  await db.collection("users").doc(sitter.uid).update({[`blockedUsers.${owner.uid}`]: "Marta"});
  ok(await write(owner.token, `sittingChats/${chatId}/messages/m5`, {senderId: owner.uid, to: sitter.uid, text: "Hello?"}, ["at"]) === 403,
    "a blocked user can't send messages");
  ok(await write(owner.token, "sittingRequests/r9", request(owner.uid), both) === 200 &&
    await write(sitter.token, `sittingOffers/r9_${sitter.uid}`, offer("r9", owner.uid, sitter.uid), ["createdAt"]) === 200,
  "blocking the owner doesn't stop the sitter (only the other way round)");
  await db.collection("users").doc(owner.uid).update({[`blockedUsers.${other.uid}`]: "Bo"});
  ok(await write(other.token, `sittingOffers/r9_${other.uid}`, offer("r9", owner.uid, other.uid, {sitterName: "Bo"}), ["createdAt"]) === 403,
    "someone the owner blocked can't send offers");

  // Reports
  const flag = (uid, kind, target, ownerId, extra = {}) => ({reporterId: uid, kind, targetId: target, targetOwnerId: ownerId, reason: "scam", ...extra});
  ok(await write(other.token, `sittingFlags/${other.uid}_sitter_${sitter.uid}`, flag(other.uid, "sitter", sitter.uid, sitter.uid), ["createdAt"]) === 200,
    "a user reports a sitter profile");
  ok(await write(other.token, `sittingFlags/${other.uid}_review_r2`, flag(other.uid, "sitter", "r2", sitter.uid), ["createdAt"]) === 403,
    "the report ID must match what is reported");
  ok(await write(sitter.token, `sittingFlags/${sitter.uid}_sitter_${sitter.uid}`, flag(sitter.uid, "sitter", sitter.uid, sitter.uid), ["createdAt"]) === 403,
    "nobody reports themself");
  ok(await get(admin.token, `sittingFlags/${other.uid}_sitter_${sitter.uid}`) === 200, "staff see reports");
  ok(await get(stranger.token, `sittingFlags/${other.uid}_sitter_${sitter.uid}`) === 403, "other users don't");
  ok(await patch(admin.token, `sitters/${sitter.uid}`, {hidden: true}) === 200, "staff hide a reported profile");
  ok(await get(owner.token, `sitters/${sitter.uid}`) === 403 && await get(sitter.token, `sitters/${sitter.uid}`) === 200,
    "a hidden profile is gone for others, still there for its owner");

  // Account deletion
  const del = await call("deleteAccount", sitter.token, {});
  const gone = await Promise.all([
    db.collection("sitters").doc(sitter.uid).get().then((d) => !d.exists),
    db.collection("sittingOffers").where("sitterId", "==", sitter.uid).get().then((q) => q.empty),
    db.collection("sittingChats").where("members", "array-contains", sitter.uid).get().then((q) => q.empty),
    db.collection("sittingReviews").where("sitterId", "==", sitter.uid).get().then((q) => q.empty),
  ]);
  ok(del.status === 200 && gone.every(Boolean), "deleting the account removes the profile, offers, chats and reviews about them");

  console.log(failures ? `\n${failures} check(s) failed` : "\nAll pet sitting checks passed");
  process.exit(failures ? 1 : 0);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
