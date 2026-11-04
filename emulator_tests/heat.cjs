// Heat calendar: settings rules, private cycles and reminders, and removal with the account. Run with emulator_tests/README.md.
// The daily reminder sweep is covered by functions/src/heat.test.ts (the emulator doesn't run schedules).
const path = require("path");
const req = require("module").createRequire(path.join(__dirname, "../functions/package.json"));
const {initializeApp} = req("firebase-admin/app");
const {getFirestore} = req("firebase-admin/firestore");

const PROJECT = "demo-codami";
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
  return {status: r.status};
}

const FS = `http://127.0.0.1:8080/v1/projects/${PROJECT}/databases/(default)/documents`;
const docName = (p) => `projects/${PROJECT}/databases/(default)/documents/${p}`;
function value(v) {
  if (typeof v === "string") return {stringValue: v};
  if (typeof v === "number") return Number.isInteger(v) ? {integerValue: String(v)} : {doubleValue: v};
  if (typeof v === "boolean") return {booleanValue: v};
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
      updateTransforms: [{fieldPath: "updatedAt", setToServerValue: "REQUEST_TIME"}],
    }]}),
  });
  return r.status;
}
async function remove(token, p) {
  return (await fetch(`${FS}/${p}`, {method: "DELETE", headers: {Authorization: `Bearer ${token}`}})).status;
}
async function get(token, p) {
  return (await fetch(`${FS}/${p}`, {headers: {Authorization: `Bearer ${token}`}})).status;
}

const config = (uid, extra = {}) => ({
  enabled: true, cycleDays: {dog: 180, cat: 21, other: 0}, heatDays: {dog: 18, cat: 7, other: 7}, updatedBy: uid, ...extra,
});
const heat = (uid, petId, extra = {}) => ({ownerId: uid, petId, start: "2026-06-01", end: "2026-06-18", notes: "", ...extra});
const both = ["createdAt", "updatedAt"];
const reminder = (uid, petId, extra = {}) => ({
  ownerId: uid, petId, petName: "Luna", nextStart: "2026-11-28", remindOn: "2026-11-25", cycleDays: 180, daysBefore: 3, ...extra,
});

(async () => {
  const admin = await signUp("admin@heat.test");
  const owner = await signUp("owner@heat.test");
  const other = await signUp("other@heat.test");
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});
  await db.collection("users").doc(owner.uid).set({name: "Owner", role: "user"});
  await db.collection("users").doc(other.uid).set({name: "Other", role: "user"});
  await db.collection("pets").doc("luna").set({ownerId: owner.uid, name: "Luna", species: "dog", sex: "F"});
  await db.collection("pets").doc("rex").set({ownerId: other.uid, name: "Rex", species: "dog", sex: "F"});

  // Settings
  ok(await write(admin.token, "config/heat", config(admin.uid)) === 200, "admin saves heat calendar settings");
  ok(await get(owner.token, "config/heat") === 200, "users read the settings");
  ok(await write(owner.token, "config/heat", config(owner.uid)) === 403, "users can't change the settings");
  ok(await write(admin.token, "config/heat", config(admin.uid, {cycleDays: {horse: 21}})) === 403, "unknown species refused");
  ok(await write(admin.token, "config/heat", config(admin.uid, {apiKey: "x"})) === 403, "extra fields refused");

  // Cycles
  ok(await write(owner.token, "heatCycles/c1", heat(owner.uid, "luna"), both) === 200, "the owner records a heat for their pet");
  ok(await write(owner.token, "heatCycles/c2", heat(owner.uid, "luna", {end: null}), both) === 200, "an ongoing heat has no end yet");
  ok(await write(owner.token, "heatCycles/c3", heat(owner.uid, "rex"), both) === 403, "nobody records heats for someone else's pet");
  ok(await write(other.token, "heatCycles/c4", heat(owner.uid, "luna"), both) === 403, "nobody records heats in someone else's name");
  ok(await write(owner.token, "heatCycles/c5", heat(owner.uid, "luna", {end: "2026-05-01"}), both) === 403, "an end before the start is refused");
  ok(await write(owner.token, "heatCycles/c6", heat(owner.uid, "luna", {start: "1 June"}), both) === 403, "a date that isn't a day is refused");
  ok(await write(owner.token, "heatCycles/c7", heat(owner.uid, "luna", {notes: "x".repeat(501)}), both) === 403, "notes over 500 characters refused");
  ok(await write(owner.token, "heatCycles/c8", heat(owner.uid, "luna", {weight: 3}), both) === 403, "extra fields refused");
  ok(await get(owner.token, "heatCycles/c1") === 200, "the owner reads their pet's heats");
  ok(await get(other.token, "heatCycles/c1") === 403, "other users can't read them");
  ok(await get(admin.token, "heatCycles/c1") === 403, "admins can't read them either (private)");
  ok(await patch(owner.token, "heatCycles/c1", {notes: "vet visit", end: "2026-06-20"}) === 200, "the owner edits a heat");
  ok(await patch(owner.token, "heatCycles/c1", {petId: "rex"}) === 403, "a heat can't be moved to another pet");
  ok(await patch(owner.token, "heatCycles/c1", {createdAt: "2020-01-01"}) === 403, "the creation time can't be changed");
  ok(await patch(other.token, "heatCycles/c1", {notes: "x"}) === 403, "other users can't edit it");
  ok(await remove(other.token, "heatCycles/c1") === 403, "other users can't delete a heat");
  ok(await remove(owner.token, "heatCycles/c2") === 200, "the owner deletes a heat");

  // Reminders
  ok(await write(owner.token, "heatReminders/luna", reminder(owner.uid, "luna")) === 200, "the owner turns reminders on");
  ok(await get(owner.token, "heatReminders/luna") === 200, "the owner reads the reminder");
  ok(await get(owner.token, "heatReminders/none") === 404, "a missing reminder reads as not there, not as refused");
  ok(await get(other.token, "heatReminders/luna") === 403, "other users can't read it");
  ok(await write(owner.token, "heatReminders/luna", reminder(owner.uid, "luna", {daysBefore: 5})) === 403, "only 1, 3, 7 or 14 days before");
  ok(await write(owner.token, "heatReminders/luna", reminder(owner.uid, "luna", {cycleDays: 3})) === 403, "a cycle under 7 days refused");
  ok(await write(owner.token, "heatReminders/rex", reminder(owner.uid, "rex")) === 403, "no reminders for someone else's pet");
  ok(await write(owner.token, "heatReminders/luna", reminder(owner.uid, "other-id")) === 403, "the reminder belongs to its own pet");
  ok(await remove(owner.token, "heatReminders/missing") === 200, "turning off a reminder that isn't there is fine");

  // Account deletion
  const del = await call("deleteAccount", owner.token, {});
  const left = await Promise.all(["heatCycles", "heatReminders"].map((c) => db.collection(c).where("ownerId", "==", owner.uid).get()));
  ok(del.status === 200 && left.every((s) => s.empty), "deleting the account deletes heats and reminders");

  console.log(failures ? `\n${failures} check(s) failed` : "\nAll heat calendar checks passed");
  process.exit(failures ? 1 : 0);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
