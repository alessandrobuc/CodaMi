// Internal feedback: types, screenshots, the team's inbox and the question rules. Run with emulator_tests/README.md.
const path = require("path");
const req = require("module").createRequire(path.join(__dirname, "../functions/package.json"));
const {initializeApp} = req("firebase-admin/app");
const {getFirestore} = req("firebase-admin/firestore");

const PROJECT = "demo-codami";
const BUCKET = `${PROJECT}.appspot.com`;
initializeApp({projectId: PROJECT});
const db = getFirestore();

let failures = 0;
function ok(cond, msg) {
  console.log(`${cond ? "PASS" : "FAIL"}  ${msg}`);
  if (!cond) failures++;
}

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
  if (v instanceof Date) return {timestampValue: v.toISOString()};
  if (Array.isArray(v)) return {arrayValue: {values: v.map(value)}};
  if (v && typeof v === "object") return {mapValue: {fields: fields(v)}};
  return {nullValue: null};
}
const fields = (obj) => Object.fromEntries(Object.entries(obj).map(([k, v]) => [k, value(v)]));
async function write(token, p, data, stamps = ["updatedAt"]) {
  const r = await fetch(`${FS}:commit`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({writes: [{
      update: {name: docName(p), fields: fields(data)},
      updateTransforms: stamps.map((f) => ({fieldPath: f, setToServerValue: "REQUEST_TIME"})),
    }]}),
  });
  return r.status;
}
// Changes only the given fields, like the app's update().
async function patch(token, p, data) {
  const r = await fetch(`${FS}:commit`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({writes: [{
      update: {name: docName(p), fields: fields(data)},
      updateMask: {fieldPaths: Object.keys(data)},
    }]}),
  });
  return r.status;
}
async function get(token, p) {
  return (await fetch(`${FS}/${p}`, {headers: {Authorization: `Bearer ${token}`}})).status;
}
// Same multipart upload as the Firebase SDKs, so the Storage rules apply.
async function upload(token, p, contentType = "image/jpeg", size = 1000) {
  const boundary = "feedbacktest";
  const body = Buffer.concat([
    Buffer.from(`--${boundary}\r\nContent-Type: application/json; charset=utf-8\r\n\r\n${JSON.stringify({name: p, contentType})}\r\n` +
      `--${boundary}\r\nContent-Type: ${contentType}\r\n\r\n`),
    Buffer.alloc(size, 1),
    Buffer.from(`\r\n--${boundary}--`),
  ]);
  const r = await fetch(`http://127.0.0.1:9199/v0/b/${BUCKET}/o?name=${encodeURIComponent(p)}`, {
    method: "POST",
    headers: {
      "Content-Type": `multipart/related; boundary=${boundary}`,
      "X-Goog-Upload-Protocol": "multipart",
      "Authorization": `Firebase ${token}`,
    },
    body,
  });
  return r.status;
}
async function download(token, p) {
  return (await fetch(`http://127.0.0.1:9199/v0/b/${BUCKET}/o/${encodeURIComponent(p)}?alt=media`, {
    headers: {Authorization: `Firebase ${token}`},
  })).status;
}
const askConfig = (uid, extra = {}) => ({enabled: true, usesMin: 10, usesMax: 20, pauseDays: 14, maxAsks: 4, updatedBy: uid, ...extra});
const feedbackOf = async (uid) => (await db.collection("feedback").where("uid", "==", uid).get()).docs;

(async () => {
  const user = await signUp("user@fbasks.test");
  const other = await signUp("other@fbasks.test");
  const admin = await signUp("admin@fbasks.test");
  const support = await signUp("support@fbasks.test");
  await db.collection("users").doc(user.uid).set({name: "Ugo", email: "user@fbasks.test", role: "user", language: "it"});
  await db.collection("users").doc(other.uid).set({name: "Olga", email: "other@fbasks.test", role: "user"});
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});
  await db.collection("users").doc(support.uid).set({name: "Staff", role: "support"});

  // ---------- Sending ----------
  const shot = `feedback/${user.uid}/1730000000000.jpg`;
  ok(await upload(user.token, shot) === 200, "users upload a screenshot to their own folder");
  ok(await upload(user.token, `feedback/${other.uid}/1730000000001.jpg`) === 403, "not into someone else's folder");
  ok(await upload(user.token, `feedback/${user.uid}/notes.txt`, "text/plain") === 403, "only images with a numbered name");
  ok(await upload(user.token, `feedback/${user.uid}/1730000000002.jpg`, "image/jpeg", 6 * 1024 * 1024) === 403, "at most 5 MB");
  ok(await download(other.token, shot) === 403, "other users can't open the screenshot");
  ok(await download(user.token, shot) === 403, "not even the sender, once sent");
  ok(await download(support.token, shot) === 200, "support staff can open it");

  const bug = await call("submitFeedback", user.token, {
    type: "bug", area: "map", rating: 2, comment: " Pins disappear when I zoom ", asked: true,
    screenshotPath: shot, appVersion: "1.4.0", platform: "android", device: "samsung SM-S911B · Android 14", lang: "it",
  });
  ok(bug.status === 200, "a bug report with stars, text and a screenshot is sent");
  let docs = await feedbackOf(user.uid);
  const saved = docs[0]?.data() ?? {};
  ok(docs.length === 1 && saved.type === "bug" && saved.area === "map" && saved.rating === 2 &&
    saved.comment === "Pins disappear when I zoom" && saved.asked === true && saved.status === "new" &&
    saved.screenshotPath === shot && saved.device === "samsung SM-S911B · Android 14" && saved.name === "Ugo",
  "it is stored with type, part of the app, stars, text, screenshot, phone and status New");
  const bugId = docs[0]?.id;

  const idea = await call("submitFeedback", user.token, {type: "suggestion", area: "shop", comment: "Add a wishlist"});
  ok(idea.status === 200, "stars are optional when there are a few words");
  docs = await feedbackOf(user.uid);
  ok(docs.some((d) => d.get("comment") === "Add a wishlist" && d.get("rating") === 0 && d.get("asked") === false),
    "no stars is stored as 0, sent from Profile");
  ok((await call("submitFeedback", user.token, {comment: "ok"})).status === 400, "nothing useful is refused");
  ok((await call("submitFeedback", user.token, {rating: 4, screenshotPath: `feedback/${other.uid}/1.jpg`})).status === 400,
    "someone else's screenshot is refused");
  const odd = await call("submitFeedback", user.token, {type: "rant", area: "moon", rating: 5});
  docs = await feedbackOf(user.uid);
  ok(odd.status === 200 && docs.some((d) => d.get("rating") === 5 && d.get("type") === "general" && d.get("area") === "general"),
    "unknown types and parts become general");
  ok((await call("submitFeedback", user.token, {rating: 3})).status === 200, "a fourth one the same day is fine");
  ok((await call("submitFeedback", user.token, {rating: 3})).status === 200, "a fifth one too");
  const sixth = await call("submitFeedback", user.token, {rating: 3});
  ok(sixth.status === 429 || sixth.error?.status === "RESOURCE_EXHAUSTED", "the sixth one that day waits for tomorrow");
  ok(await patch(user.token, `users/${user.uid}`, {feedbackDayCount: 0}) === 403, "users can't reset their daily count");

  // ---------- The team's inbox ----------
  ok(await get(user.token, `feedback/${bugId}`) === 403, "users can't read feedback");
  ok(await patch(admin.token, `feedback/${bugId}`, {status: "done"}) === 403, "nobody edits feedback directly");
  ok((await call("updateFeedback", user.token, {id: bugId, status: "done"})).status === 403, "users can't change the status");
  const progress = await call("updateFeedback", support.token, {id: bugId, status: "in_progress", note: " Seen on Samsung "});
  let f = (await db.collection("feedback").doc(bugId).get()).data() ?? {};
  ok(progress.status === 200 && f.status === "in_progress" && f.note === "Seen on Samsung" && f.handledBy === support.uid,
    "support staff set In progress and a private note");
  ok((await call("updateFeedback", admin.token, {id: bugId, status: "closed"})).status === 400, "unknown statuses are refused");
  ok((await call("updateFeedback", admin.token, {id: "missing123", status: "done"})).status === 404, "missing feedback is reported");
  const done = await call("updateFeedback", admin.token, {id: bugId, status: "done", notify: true});
  f = (await db.collection("feedback").doc(bugId).get()).data() ?? {};
  ok(done.status === 200 && f.status === "done" && f.thankedAt != null, "marking it done can thank the user");
  ok(done.result?.notified === false, "no phone registered in the emulator, so nothing was actually pushed");
  const firstThanks = f.thankedAt.toMillis();
  await call("updateFeedback", admin.token, {id: bugId, status: "new"});
  await call("updateFeedback", admin.token, {id: bugId, status: "done", notify: true});
  f = (await db.collection("feedback").doc(bugId).get()).data() ?? {};
  ok(f.thankedAt.toMillis() === firstThanks, "a user is thanked only once for the same feedback");

  // ---------- The question rules ----------
  ok(await write(admin.token, "config/feedbackAsks", askConfig(admin.uid)) === 200, "admins save the question settings");
  ok(await get(user.token, "config/feedbackAsks") === 200, "users read them");
  ok(await write(user.token, "config/feedbackAsks", askConfig(user.uid)) === 403, "users can't change them");
  ok(await write(admin.token, "config/feedbackAsks", askConfig(admin.uid, {usesMin: 15, usesMax: 12})) === 403, "\"to\" can't be below \"from\"");
  ok(await write(admin.token, "config/feedbackAsks", askConfig(admin.uid, {pauseDays: 1})) === 403, "the pause is at least 3 days");
  ok(await write(admin.token, "config/feedbackAsks", askConfig(admin.uid, {maxAsks: 50})) === 403, "at most 20 questions per user");
  ok(await write(admin.token, "config/feedbackAsks", askConfig(admin.uid, {text: "x"})) === 403, "extra fields refused");

  const ask = {lastAt: new Date(), count: 1, asked: ["map"], optOut: false};
  ok(await patch(user.token, `users/${user.uid}`, {feedbackAsk: ask}) === 200, "the app saves when it asked the user");
  ok(await patch(user.token, `users/${user.uid}`, {feedbackAsk: {...ask, optOut: true}}) === 200, "and \"don't ask again\"");
  ok(await patch(user.token, `users/${user.uid}`, {feedbackAsk: {...ask, extra: 1}}) === 403, "unknown keys are refused");
  ok(await patch(user.token, `users/${user.uid}`, {feedbackAsk: {...ask, asked: Array(21).fill("map")}}) === 403, "the list stays short");
  ok(await patch(user.token, `users/${user.uid}`, {feedbackAsk: {...ask, lastAt: "yesterday"}}) === 403, "the time must be a real time");
  ok(await patch(other.token, `users/${user.uid}`, {feedbackAsk: ask}) === 403, "nobody else changes it");

  // ---------- Account deletion ----------
  ok((await call("deleteAccount", user.token, {})).status === 200, "account deletion runs");
  ok((await feedbackOf(user.uid)).length === 0, "the feedback is removed");
  ok(await download(support.token, shot) === 404, "and the screenshot too");

  console.log(failures === 0 ? "\nAll feedback question checks passed" : `\n${failures} check(s) FAILED`);
  process.exit(failures === 0 ? 0 : 1);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
