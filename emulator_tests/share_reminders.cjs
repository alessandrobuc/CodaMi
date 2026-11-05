// Share reminders: settings for admins only, the first reminder planned on the first visit, opening and sharing counted, sharing pauses reminders, the notification switch, admin test sends, and removal with the account. Run with emulator_tests/README.md.
// The evening sweep is covered by functions/src/shareReminders.test.ts (the emulator doesn't run schedules).
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

const today = new Intl.DateTimeFormat("en-CA", {timeZone: "Europe/Rome", year: "numeric", month: "2-digit", day: "2-digit"}).format(new Date());
const plus = (days) => { const d = new Date(`${today}T12:00:00Z`); d.setUTCDate(d.getUTCDate() + days); return d.toISOString().slice(0, 10); };
const config = (uid, extra = {}) => ({enabled: true, firstDays: 3, everyDays: 7, maxCount: 8, updatedBy: uid, ...extra});

(async () => {
  const admin = await signUp("admin@remind.test");
  const user = await signUp("user@remind.test");
  const other = await signUp("other@remind.test");
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});
  await db.collection("users").doc(user.uid).set({name: "User", role: "user"});
  await db.collection("users").doc(other.uid).set({name: "Other", role: "user"});
  await db.collection("reports").doc("r1").set({ownerId: other.uid, status: "open", type: "lost", petName: "Luna"});

  // Settings
  ok(await write(admin.token, "config/shareReminders", config(admin.uid)) === 200, "admin saves the reminder settings");
  ok(await get(user.token, "config/shareReminders") === 200, "users read them");
  ok(await write(user.token, "config/shareReminders", config(user.uid)) === 403, "users can't change them");
  ok(await write(admin.token, "config/shareReminders", config(admin.uid, {everyDays: 1})) === 403, "never more often than every 3 days");
  ok(await write(admin.token, "config/shareReminders", config(admin.uid, {maxCount: 100})) === 403, "at most 52 in total");
  ok(await write(admin.token, "config/shareReminders", config(admin.uid, {firstDays: 0})) === 403, "the first one at least a day after sign-up");
  ok(await write(admin.token, "config/shareReminders", config(admin.uid, {text: "x"})) === 403, "extra fields refused");

  // Planning
  ok((await call("registerVisit", user.token, {installId: "install-remind-1"})).status === 200, "the first visit of the day is registered");
  let r = (await db.collection("shareReminders").doc(user.uid).get()).data() || {};
  ok(r.next === plus(3) && r.count === 0, "the first reminder is planned 3 days after sign-up");
  await db.collection("shareReminders").doc(user.uid).update({next: plus(1), count: 2});
  await call("registerVisit", user.token, {installId: "install-remind-1"});
  r = (await db.collection("shareReminders").doc(user.uid).get()).data() || {};
  ok(r.next === plus(1) && r.count === 2, "later visits don't reset the plan");
  ok(await get(user.token, `shareReminders/${user.uid}`) === 200, "users read their own plan");
  ok(await get(other.token, `shareReminders/${user.uid}`) === 403, "not someone else's");
  ok(await write(user.token, `shareReminders/${user.uid}`, {next: "9999-12-31", count: 0}, []) === 403, "nobody changes it from the app");

  // Events
  ok((await call("shareReminderEvent", user.token, {event: "opened", fromReminder: true})).status === 200, "opening a reminder is counted");
  ok((await call("shareReminderEvent", user.token, {event: "shared", fromReminder: true})).status === 200, "sharing from a reminder is counted");
  ok((await call("shareReminderEvent", user.token, {event: "clicked"})).status === 400, "unknown events refused");
  ok((await call("shareReminderEvent", "", {event: "opened"})).status === 401, "signing in is needed");
  r = (await db.collection("shareReminders").doc(user.uid).get()).data() || {};
  ok(r.lastSharedDay === today, "sharing pauses the next reminders");
  const stats = (await db.collection("shareReminderStats").doc(today).get()).data() || {};
  ok(stats.opened === 1 && stats.shares === 1, "daily numbers for the admin");
  ok(await get(admin.token, `shareReminderStats/${today}`) === 200 && await get(user.token, `shareReminderStats/${today}`) === 403, "only admins read the numbers");

  await call("logReportShare", other.token, {reportId: "r1", target: "whatsapp", kind: "announce"});
  ok(((await db.collection("shareReminders").doc(other.uid).get()).data() || {}).lastSharedDay === today, "sharing a report pauses the reminders too");

  // The switch
  async function merge(token, p, data) {
    const r = await fetch(`${FS}:commit`, {
      method: "POST",
      headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
      body: JSON.stringify({writes: [{update: {name: docName(p), fields: fields(data)}, updateMask: {fieldPaths: Object.keys(data)}}]}),
    });
    return r.status;
  }
  ok(await merge(user.token, `users/${user.uid}`, {notificationPrefs: {share: {enabled: false}}}) === 200, "users turn share reminders off in Notifications");
  ok(await merge(user.token, `users/${user.uid}`, {notificationPrefs: {spam: {enabled: true}}}) === 403, "unknown notification types refused");

  // Admin test
  ok((await call("testShareReminder", user.token, {})).status === 403, "only admins send test reminders");
  ok((await call("testShareReminder", admin.token, {})).status === 200, "admins send themselves a test");

  // Account deletion
  const del = await call("deleteAccount", user.token, {});
  ok(del.status === 200 && !(await db.collection("shareReminders").doc(user.uid).get()).exists, "deleting the account deletes the reminder plan");

  console.log(failures ? `\n${failures} check(s) failed` : "\nAll share reminder checks passed");
  process.exit(failures ? 1 : 0);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
