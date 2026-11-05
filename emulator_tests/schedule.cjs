// Personal schedule: the on/off switch, events private to their owner (not even admins read them), field checks, and removal with the account. Run with emulator_tests/README.md.
// The reminder sweep is covered by functions/src/schedule.test.ts (the emulator doesn't run schedules).
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
async function list(token, uid) {
  const r = await fetch(`${FS}:runQuery`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({structuredQuery: {
      from: [{collectionId: "scheduleEvents"}],
      where: {fieldFilter: {field: {fieldPath: "ownerId"}, op: "EQUAL", value: {stringValue: uid}}},
    }}),
  });
  return r.status;
}

const both = ["createdAt", "updatedAt"];
const soon = new Date(Date.now() + 3600 * 1000);
const event = (uid, extra = {}) => ({
  ownerId: uid, type: "vet", title: "Check-up", notes: "", place: "Clinic", detail: "",
  petIds: ["luna"], petNames: ["Luna"], start: "2026-11-20", time: 630,
  repeat: {freq: "none", every: 1, weekdays: [], until: null, count: null},
  remind: [1440, 60], done: [], skipped: [],
  reminders: [{at: soon, title: "Check-up · Luna", body: "In 1 hour · 10:30"}], nextRemindAt: soon,
  ...extra,
});

(async () => {
  const admin = await signUp("admin@schedule.test");
  const owner = await signUp("owner@schedule.test");
  const other = await signUp("other@schedule.test");
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});
  await db.collection("users").doc(owner.uid).set({name: "Owner", role: "user"});
  await db.collection("users").doc(other.uid).set({name: "Other", role: "user"});

  // Settings
  ok(await write(admin.token, "config/schedule", {enabled: true, updatedBy: admin.uid}) === 200, "admin switches the schedule on");
  ok(await get(owner.token, "config/schedule") === 200, "users read the switch");
  ok(await write(owner.token, "config/schedule", {enabled: true, updatedBy: owner.uid}) === 403, "users can't change it");
  ok(await write(admin.token, "config/schedule", {enabled: "yes", updatedBy: admin.uid}) === 403, "on/off must be true or false");
  ok(await write(admin.token, "config/schedule", {enabled: true, updatedBy: admin.uid, extra: 1}) === 403, "extra fields refused");

  // Events
  ok(await write(owner.token, "scheduleEvents/e1", event(owner.uid), both) === 200, "the owner adds an event with reminders");
  const weekly = {freq: "weekly", every: 2, weekdays: [1, 3], until: "2027-01-31", count: null};
  ok(await write(owner.token, "scheduleEvents/e2", event(owner.uid, {type: "feeding", time: null, repeat: weekly}), both) === 200, "an all-day repeating event");
  ok(await write(owner.token, "scheduleEvents/e3", event(owner.uid, {petIds: [], petNames: [], reminders: [], nextRemindAt: null, remind: []}), both) === 200, "a general note with no pet and no reminder");
  ok(await write(other.token, "scheduleEvents/e4", event(owner.uid), both) === 403, "nobody adds events in someone else's name");
  ok(await write(owner.token, "scheduleEvents/e5", event(owner.uid, {type: "party"}), both) === 403, "unknown types refused");
  ok(await write(owner.token, "scheduleEvents/e6", event(owner.uid, {time: 1440}), both) === 403, "a time past midnight refused");
  ok(await write(owner.token, "scheduleEvents/e7", event(owner.uid, {start: "20 Nov"}), both) === 403, "a date that isn't a day refused");
  ok(await write(owner.token, "scheduleEvents/e8", event(owner.uid, {remind: [0, 15, 60]}), both) === 403, "more than 2 reminders refused");
  ok(await write(owner.token, "scheduleEvents/e9", event(owner.uid, {repeat: {...weekly, every: 0}}), both) === 403, "repeat every 0 refused");
  ok(await write(owner.token, "scheduleEvents/e10", event(owner.uid, {repeat: {...weekly, freq: "hourly"}}), both) === 403, "unknown repeat refused");
  ok(await write(owner.token, "scheduleEvents/e11", event(owner.uid, {notes: "x".repeat(1001)}), both) === 403, "notes over 1000 characters refused");
  ok(await write(owner.token, "scheduleEvents/e12", event(owner.uid, {title: "x".repeat(81)}), both) === 403, "titles over 80 characters refused");
  ok(await write(owner.token, "scheduleEvents/e13", event(owner.uid, {reminders: Array(61).fill({at: soon, title: "t", body: ""})}), both) === 403, "more than 60 planned reminders refused");
  ok(await write(owner.token, "scheduleEvents/e14", event(owner.uid, {shared: true}), both) === 403, "extra fields refused");

  // Privacy
  ok(await get(owner.token, "scheduleEvents/e1") === 200, "the owner reads their event");
  ok(await list(owner.token, owner.uid) === 200, "the owner lists their schedule");
  ok(await get(other.token, "scheduleEvents/e1") === 403, "other users can't read it");
  ok(await list(other.token, owner.uid) === 403, "other users can't list someone else's schedule");
  ok(await get(admin.token, "scheduleEvents/e1") === 403, "admins can't read it either (private)");
  ok(await get(owner.token, "scheduleEvents/missing") === 404, "a missing event reads as not there, not as refused");

  // Edits
  ok(await patch(owner.token, "scheduleEvents/e1", {done: ["2026-11-20"], reminders: [], nextRemindAt: null}) === 200, "the owner marks it done and clears its reminders");
  ok(await patch(owner.token, "scheduleEvents/e2", {skipped: ["2026-11-25"]}) === 200, "the owner skips one day of a series");
  ok(await patch(owner.token, "scheduleEvents/e1", {ownerId: other.uid}) === 403, "an event can't be given to someone else");
  ok(await patch(owner.token, "scheduleEvents/e1", {createdAt: "2020-01-01"}) === 403, "the creation time can't be changed");
  ok(await patch(other.token, "scheduleEvents/e1", {title: "x"}) === 403, "other users can't edit it");
  ok(await remove(other.token, "scheduleEvents/e1") === 403, "other users can't delete it");
  ok(await remove(owner.token, "scheduleEvents/e3") === 200, "the owner deletes an event");

  // Account deletion
  const del = await call("deleteAccount", owner.token, {});
  const left = await db.collection("scheduleEvents").where("ownerId", "==", owner.uid).get();
  ok(del.status === 200 && left.empty, "deleting the account deletes the schedule");

  console.log(failures ? `\n${failures} check(s) failed` : "\nAll schedule checks passed");
  process.exit(failures ? 1 : 0);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
