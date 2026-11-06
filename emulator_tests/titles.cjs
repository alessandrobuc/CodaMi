// Titles and achievements: counting, levels, bonus points, public titles, donor titles and admin tools. Run with emulator_tests/README.md.
const path = require("path");
const req = require("module").createRequire(path.join(__dirname, "../functions/package.json"));
const {initializeApp} = req("firebase-admin/app");
const {getFirestore, FieldValue} = req("firebase-admin/firestore");

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
async function get(token, p) {
  return (await fetch(`${FS}/${p}`, {headers: {Authorization: `Bearer ${token}`}})).status;
}

const levels = async (uid) => (await db.collection("achievements").doc(uid).get()).get("levels") ?? {};
const pub = async (uid) => (await db.collection("publicProfiles").doc(uid).get()).data() ?? {};
const points = async (uid) => (await db.collection("users").doc(uid).get()).get("points") ?? 0;
// The app's refresh waits 30 seconds between counts; tests clear that wait.
async function refresh(user) {
  await db.collection("achievements").doc(user.uid).set({refreshedAt: FieldValue.delete()}, {merge: true});
  return call("refreshMyTitles", user.token, {});
}
const config = (uid, extra = {}) => ({
  enabled: true, off: [], levels: {contributor: [1, 2, 3]}, bonus: [10, 25, 50],
  donorCents: [1000, 2500, 5000, 10000, 25000], updatedBy: uid, ...extra,
});

(async () => {
  const ana = await signUp("ana@titles.test");
  const ben = await signUp("ben@titles.test");
  const admin = await signUp("admin@titles.test");
  await db.collection("users").doc(ana.uid).set({name: "Ana", role: "user", language: "it", activity: {days: 2}});
  await db.collection("users").doc(ben.uid).set({name: "Ben", role: "user"});
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});

  // ---------- Settings ----------
  ok(await write(admin.token, "config/titles", config(admin.uid)) === 200, "admins save the title settings");
  ok(await get(ana.token, "config/titles") === 200, "users read them");
  ok(await write(ana.token, "config/titles", config(ana.uid)) === 403, "users can't change them");
  ok(await write(admin.token, "config/titles", config(admin.uid, {levels: {king: [1, 2, 3]}})) === 403, "unknown titles refused");
  ok(await write(admin.token, "config/titles", config(admin.uid, {bonus: [1, 2]})) === 403, "three bonus numbers needed");
  ok(await write(admin.token, "config/titles", config(admin.uid, {extra: true})) === 403, "extra fields refused");

  // ---------- Counting ----------
  await db.collection("reports").doc("t-lost").set({ownerId: ana.uid, type: "lost", status: "open", petName: "Rex"});
  await db.collection("reports").doc("t-found").set({ownerId: ana.uid, type: "found", status: "resolved", petName: "Mia"});
  await db.collection("reports").doc("t-hidden").set({ownerId: ana.uid, type: "lost", status: "hidden", petName: "X"});
  ok((await refresh(ana)).status === 200, "the achievements screen asks for a fresh count");
  let a = (await db.collection("achievements").doc(ana.uid).get()).data() ?? {};
  ok(a.counts?.reports === 2, "hidden reports don't count");
  ok(a.levels?.contributor === 2 && a.levels?.rescuer === 1, "two reports give Community Contributor ★★, a found pet home gives Animal Rescuer ★");
  ok(await points(ana.uid) === 10 + 25 + 10, "bonus points for each new level");
  const ledger = await db.collection("users").doc(ana.uid).collection("pointsLedger").doc("title_contributor_2").get();
  ok(ledger.exists && ledger.get("action") === "title", "bonus points are ledger lines");
  ok(a.unlockedAt?.contributor_2 != null, "the unlock time is kept");
  await refresh(ana);
  ok(await points(ana.uid) === 45, "the same level never pays twice");

  await db.collection("emergencies").doc("t-em").set({ownerId: ben.uid, status: "open", type: "injured", species: "dog"});
  ok((await call("updateEmergency", ana.token, {emergencyId: "t-em", action: "helping"})).status === 200, "Ana helps in an emergency");
  ok((await levels(ana.uid)).volunteer === 1, "helping gives Active Volunteer ★ straight away");
  ok((await call("updateEmergency", ben.token, {emergencyId: "t-em", action: "resolved"})).status === 200, "Ben resolves it");
  ok((await levels(ben.uid)).rescuer === 1, "the owner of a resolved emergency is an Animal Rescuer");
  a = (await db.collection("achievements").doc(ana.uid).get()).data() ?? {};
  ok(a.counts?.rescues === 2, "and the helper's rescue counts too");

  for (let i = 0; i < 4; i++) await call("logReportShare", ben.token, {reportId: "t-lost", target: "whatsapp", kind: "announce"});
  a = (await db.collection("achievements").doc(ben.uid).get()).data() ?? {};
  ok(a.shares === 3, "only 3 shares a day count");

  await db.collection("users").doc(ana.uid).update({activity: {days: 40, lastDay: "2026-11-06"}});
  await refresh(ana);
  ok((await levels(ana.uid)).trusted === 1, "40 active days give Trusted Member ★");
  await db.collection("photoChecks").doc("t-removed").set({ownerId: ana.uid, status: "removed", reviewedAt: FieldValue.serverTimestamp()});
  await refresh(ana);
  ok((await levels(ana.uid)).trusted === undefined, "a photo removed by moderators puts it on hold");
  ok((await levels(ana.uid)).contributor === 2, "activity titles are kept");
  await db.collection("photoChecks").doc("t-removed").delete();

  // ---------- Public title ----------
  let p = await pub(ana.uid);
  ok(p.title?.id === "contributor" && p.title?.level === 2 && p.tags?.length === 3,
    "the highest title shows to others (Contributor ★★), with up to 3 tags");
  ok(await get(ben.token, `publicProfiles/${ana.uid}`) === 200, "other users read the public titles");
  ok(await get(ben.token, `achievements/${ana.uid}`) === 403, "but not the counts");
  ok(await get(ana.token, `achievements/${ana.uid}`) === 200, "users read their own");
  ok(await write(ana.token, `achievements/${ana.uid}`, {levels: {team: 1}}, []) === 403, "nobody writes titles from the app");
  ok((await call("setTitlePrefs", ana.token, {main: "trusted", hideDonor: false})).status === 400, "a locked title can't be the main one");
  ok((await call("setTitlePrefs", ana.token, {main: "volunteer", hideDonor: false})).status === 200, "users choose their main title");
  ok((await pub(ana.uid)).title?.id === "volunteer", "and others see it");

  // ---------- Donor titles ----------
  ok((await call("adminRecordDonation", ana.token, {uid: ana.uid, cents: 5000})).status === 403, "users can't record donations");
  const pointsBefore = await points(ana.uid);
  const don = await call("adminRecordDonation", admin.token, {uid: ana.uid, cents: 2500, note: "Bank transfer"});
  ok(don.status === 200 && (await levels(ana.uid)).donor === 3, "€25 recorded by an admin gives Silver Donor");
  ok(await get(ana.token, `donations/${don.result?.id}`) === 403, "donations are for admins only");
  ok(await get(admin.token, `donations/${don.result?.id}`) === 200, "admins read them");
  ok(await points(ana.uid) === pointsBefore, "no points for donor titles");
  await call("setTitlePrefs", ana.token, {main: "donor", hideDonor: true});
  p = await pub(ana.uid);
  ok(p.title?.id !== "donor" && !p.tags.some((t) => t.id === "donor"), "a hidden donor title never shows to others");
  ok((await call("adminDeleteDonation", admin.token, {id: don.result?.id})).status === 200 && (await levels(ana.uid)).donor === undefined,
    "deleting a mistaken donation takes the donor title away");

  // ---------- Admin tools ----------
  ok((await call("adminSetTitle", ana.token, {uid: ana.uid, id: "team", level: 1})).status === 403, "users can't give titles");
  ok((await call("adminSetTitle", admin.token, {uid: ben.uid, id: "partner", level: 1})).status === 200 &&
    (await pub(ben.uid)).title?.id === "partner", "admins give Partner Shelter, shown first");
  await call("adminSetTitle", admin.token, {uid: ben.uid, id: "rescuer", level: 0});
  ok((await levels(ben.uid)).rescuer === undefined, "admins can take a title away");
  await call("adminSetTitle", admin.token, {uid: ben.uid, id: "rescuer", level: null});
  ok((await levels(ben.uid)).rescuer === 1, "and allow it again");
  ok((await call("adminSetTitle", admin.token, {uid: ben.uid, id: "rescuer", level: 9})).status === 400, "levels above the top are refused");

  // ---------- Switched off ----------
  await db.collection("config").doc("titles").set({enabled: false});
  await db.collection("reports").doc("t-ben").set({ownerId: ben.uid, type: "lost", status: "open"});
  const before = await points(ben.uid);
  await refresh(ben);
  ok((await levels(ben.uid)).contributor === 1 && await points(ben.uid) === before, "while off, titles are counted but no points are given");

  // ---------- Account deletion ----------
  ok((await call("deleteAccount", ana.token, {})).status === 200, "account deletion runs");
  const left = await Promise.all([
    db.collection("achievements").doc(ana.uid).get(),
    db.collection("publicProfiles").doc(ana.uid).get(),
    db.collection("donations").where("uid", "==", ana.uid).get(),
  ]);
  ok(!left[0].exists && !left[1].exists && left[2].empty, "titles, public titles and donations are removed");

  console.log(failures === 0 ? "\nAll title checks passed" : `\n${failures} check(s) FAILED`);
  process.exit(failures === 0 ? 0 : 1);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
