// Feedback points, "What's new" notes and their rules. Run with emulator_tests/README.md.
const path = require("path");
const req = require("module").createRequire(path.join(__dirname, "../functions/package.json"));
const {initializeApp} = req("firebase-admin/app");
const {getFirestore, FieldValue, Timestamp} = req("firebase-admin/firestore");

const PROJECT = "demo-codami";
initializeApp({projectId: PROJECT});
const db = getFirestore();

let failures = 0;
function ok(cond, msg) {
  console.log(`${cond ? "PASS" : "FAIL"}  ${msg}`);
  if (!cond) failures++;
}
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
async function waitFor(fn, ms = 20000) {
  const end = Date.now() + ms;
  while (Date.now() < end) {
    const v = await fn();
    if (v) return v;
    await sleep(400);
  }
  return null;
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
async function restGet(token, docPath) {
  return (await fetch(`${FS}/${docPath}`, {headers: {Authorization: `Bearer ${token}`}})).status;
}
async function restPatch(token, docPath, fields, mask) {
  const q = mask.map((m) => `updateMask.fieldPaths=${m}`).join("&");
  return (await fetch(`${FS}/${docPath}?${q}`, {
    method: "PATCH",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({fields}),
  })).status;
}
function value(v) {
  if (typeof v === "string") return {stringValue: v};
  if (typeof v === "number") return Number.isInteger(v) ? {integerValue: String(v)} : {doubleValue: v};
  if (typeof v === "boolean") return {booleanValue: v};
  if (Array.isArray(v)) return {arrayValue: {values: v.map(value)}};
  return {nullValue: null};
}
function mapValue(obj) {
  return {mapValue: {fields: Object.fromEntries(Object.entries(obj).map(([k, v]) =>
    [k, typeof v === "object" && v !== null && !Array.isArray(v) ? mapValue(v) : value(v)]))}};
}
async function restPatchMap(token, docPath, obj) {
  return (await fetch(`${FS}/${docPath}`, {
    method: "PATCH",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({fields: mapValue(obj).mapValue.fields}),
  })).status;
}
const points = async (uid) => (await db.collection("users").doc(uid).get()).get("points") ?? 0;

(async () => {
  const newbie = await signUp("newbie@feedback.test");
  const regular = await signUp("regular@feedback.test");
  const admin = await signUp("admin@feedback.test");
  const support = await signUp("support@feedback.test");
  await db.collection("users").doc(newbie.uid).set({name: "Nina Nuova", email: "newbie@feedback.test", role: "user"});
  await db.collection("users").doc(regular.uid).set({name: "Rita", email: "regular@feedback.test", role: "user"});
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});
  await db.collection("users").doc(support.uid).set({name: "Staff", role: "support"});
  await db.collection("config").doc("points").delete();

  // ---------- Feedback ----------
  const f1 = await call("submitFeedback", newbie.token, {rating: 4, comment: " Nice app ", appVersion: "1.1.0", platform: "android", lang: "it"});
  ok(f1.status === 200 && f1.result.points === 0, "feedback from a brand new account is saved without points");
  const saved = await db.collection("feedback").where("uid", "==", newbie.uid).get();
  ok(saved.size === 1 && saved.docs[0].get("comment") === "Nice app" && saved.docs[0].get("rating") === 4 && saved.docs[0].get("name") === "Nina Nuova", "feedback is stored with rating, comment and name");
  const f2 = await call("submitFeedback", newbie.token, {rating: 5});
  ok(f2.status === 429 || f2.error?.status === "RESOURCE_EXHAUSTED", "only one feedback per day");
  ok((await call("submitFeedback", regular.token, {rating: 7})).status === 400, "stars must be 1 to 5");
  ok((await call("submitFeedback", regular.token, {rating: 3, comment: "x".repeat(1001)})).status === 400, "comment is limited to 1000 characters");

  await db.collection("config").doc("points").set({feedbackAfterDays: 0, feedbackPoints: 20});
  const f3 = await call("submitFeedback", regular.token, {rating: 5, comment: "Love it"});
  ok(f3.status === 200 && f3.result.points === 20 && await points(regular.uid) === 20, "first feedback after the waiting days gives 20 points");
  await db.collection("users").doc(regular.uid).update({feedbackDay: "2000-01-01"});
  const f4 = await call("submitFeedback", regular.token, {rating: 2, comment: "Bug on map"});
  ok(f4.status === 200 && f4.result.points === 0 && await points(regular.uid) === 20, "later feedback is saved but gives no more points");
  const ledger = await db.collection("users").doc(regular.uid).collection("pointsLedger").doc("feedback_first").get();
  ok(ledger.exists && ledger.get("action") === "feedback", "feedback points are one ledger line");

  ok(await restGet(regular.token, `feedback/${saved.docs[0].id}`) === 403, "users can't read feedback");
  ok(await restGet(support.token, `feedback/${saved.docs[0].id}`) === 200, "support staff can read feedback");
  ok(await restGet(admin.token, `feedback/${saved.docs[0].id}`) === 200, "admins can read feedback");
  ok(await restPatch(regular.token, `users/${regular.uid}`, {feedbackDay: value("1999-01-01")}, ["feedbackDay"]) === 403, "users can't reset their feedback day");

  // ---------- Settings ----------
  ok(await restPatchMap(admin.token, "config/points", {feedbackPoints: 30, feedbackAfterDays: 5, reviewAfterDays: 10, reviewMinActiveDays: 5, reviewEveryDays: 120}) === 200, "admins can save the feedback and review settings");
  ok(await restPatchMap(admin.token, "config/points", {feedbackPoints: 30, somethingElse: 1}) === 403, "unknown settings are refused");

  // ---------- What's new ----------
  const notes = {en: {new: ["Map pins"], improved: [], fixed: ["Google sign-in"]}, it: {new: ["Pin sulla mappa"]}};
  ok(await restPatchMap(admin.token, "releaseNotes/1.1.0", {version: "1.1.0", code: 1001000, published: false, notes}) === 200, "admins can write version notes");
  ok(await restGet(regular.token, "releaseNotes/1.1.0") === 403, "users can't see draft notes");
  ok(await restPatchMap(admin.token, "releaseNotes/1.1.0", {version: "1.1.0", code: 1001000, published: true, notes}) === 200, "admins can publish notes");
  ok(await restGet(regular.token, "releaseNotes/1.1.0") === 200, "users can read published notes");
  ok(await restPatchMap(regular.token, "releaseNotes/1.2.0", {version: "1.2.0", code: 1002000, published: true, notes}) === 403, "users can't write notes");
  ok(await restPatchMap(support.token, "releaseNotes/1.2.0", {version: "1.2.0", code: 1002000, published: true, notes}) === 403, "support staff can't write notes");
  ok(await restPatchMap(admin.token, "releaseNotes/v1", {version: "v1", code: 1, published: true, notes}) === 403, "the document ID must be a version number");
  ok(await restPatchMap(admin.token, "releaseNotes/1.3.0", {version: "1.4.0", code: 1004000, published: true, notes}) === 403, "the version must match the document ID");
  ok(await restPatchMap(admin.token, "releaseNotes/1.5.0", {version: "1.5.0", published: true, notes}) === 403, "notes need their sortable code");

  // ---------- Account deletion ----------
  const del = await call("deleteAccount", newbie.token, {});
  ok(del.status === 200, "account deletion runs");
  const left = await waitFor(async () => (await db.collection("feedback").where("uid", "==", newbie.uid).get()).empty);
  ok(left === true, "deleting an account deletes its feedback");

  console.log(failures === 0 ? "\nAll feedback and notes checks passed" : `\n${failures} check(s) FAILED`);
  process.exit(failures === 0 ? 0 : 1);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
