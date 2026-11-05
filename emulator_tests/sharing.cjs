// Social sharing: the pop-up switch, share counts written only by the server, who reads them, the public report page (only public fields, hidden and missing reports, visit counts) and removal with the account. Run with emulator_tests/README.md.
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

const BASE = `http://127.0.0.1:5001/${PROJECT}/europe-west1`;
async function page(p, ua = "Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X)") {
  const r = await fetch(`${BASE}/reportPage${p}`, {headers: {"User-Agent": ua, "Accept-Language": "it-IT,it;q=0.9"}});
  return {status: r.status, html: await r.text()};
}
const report = (uid, extra = {}) => ({
  ownerId: uid, ownerName: "Mario Rossi", type: "lost", status: "open", petName: "Luna", species: "dog",
  description: "Shy, red collar", city: "Milano", placeDetail: "Città Studi", areaRadius: 500,
  eventAt: "2026-11-03T08:00:00.000Z", reward: 100, contactPhone: "+39 333 1234567", contactEmail: "mario@example.com",
  photoUrls: [], lat: 45.47, lng: 9.22, ...extra,
});

(async () => {
  const admin = await signUp("admin@share.test");
  const owner = await signUp("owner@share.test");
  const other = await signUp("other@share.test");
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});
  await db.collection("users").doc(owner.uid).set({name: "Owner", role: "user"});
  await db.collection("users").doc(other.uid).set({name: "Other", role: "user"});
  await db.collection("reports").doc("luna").set(report(owner.uid));
  await db.collection("reports").doc("hid").set(report(owner.uid, {status: "hidden"}));
  await db.collection("reports").doc("home").set(report(owner.uid, {status: "resolved"}));

  // Settings
  ok(await write(admin.token, "config/sharing", {popup: true, updatedBy: admin.uid}) === 200, "admin switches the share pop-up on");
  ok(await get(owner.token, "config/sharing") === 200, "users read the switch");
  ok(await write(owner.token, "config/sharing", {popup: false, updatedBy: owner.uid}) === 403, "users can't change it");
  ok(await write(admin.token, "config/sharing", {popup: "yes", updatedBy: admin.uid}) === 403, "on/off must be true or false");

  // Counting shares
  ok((await call("logReportShare", other.token, {reportId: "luna", target: "whatsapp", kind: "announce"})).status === 200, "anyone signed in can share a report and it's counted");
  ok((await call("logReportShare", owner.token, {reportId: "luna", target: "instagram", kind: "announce"})).status === 200, "the owner's own shares count too");
  ok((await call("logReportShare", owner.token, {reportId: "luna", target: "myspace", kind: "announce"})).status === 400, "unknown apps refused");
  ok((await call("logReportShare", owner.token, {reportId: "hid", target: "copy", kind: "announce"})).status === 404, "hidden reports can't be shared");
  ok((await call("logReportShare", owner.token, {reportId: "nope", target: "copy", kind: "announce"})).status === 404, "missing reports can't be shared");
  ok((await call("logReportShare", "", {reportId: "luna", target: "copy", kind: "announce"})).status === 401, "signing in is needed");
  const counts = (await db.collection("reportShares").doc("luna").get()).data() || {};
  ok(counts.shares === 2 && counts.byTarget?.whatsapp === 1 && counts.byTarget?.instagram === 1 && counts.ownerId === owner.uid, "counts per report and per app");

  // Who reads the numbers
  ok(await get(owner.token, "reportShares/luna") === 200, "the owner sees how far their report travelled");
  ok(await get(other.token, "reportShares/luna") === 403, "other users don't");
  ok(await get(admin.token, "reportShares/luna") === 200, "admins do");
  ok(await write(owner.token, "reportShares/luna", {ownerId: owner.uid, shares: 9999}, []) === 403, "nobody writes the numbers from the app");
  const days = await db.collection("shareStats").get();
  ok(days.size === 1 && await get(admin.token, `shareStats/${days.docs[0].id}`) === 200, "admins read the daily totals");
  ok(await get(owner.token, `shareStats/${days.docs[0].id}`) === 403, "users don't");

  // The public page
  const p = await page("/r/luna?s=qr");
  ok(p.status === 200 && p.html.includes("Luna") && p.html.includes("SMARRITO"), "the page shows the report, in the visitor's language");
  ok(p.html.includes("property=\"og:title\"") && p.html.includes("og:image"), "with a link preview for chat apps");
  ok(!p.html.includes("333 1234567") && !p.html.includes("mario@example.com") && !p.html.includes("Mario Rossi") && !p.html.includes("45.47"), "no phone, email, name or exact position");
  ok(p.html.includes("intent://report/luna"), "with an Open in CodaMi button");
  ok((await page("/r/luna?l=de")).html.includes("VERMISST"), "the sharer's language wins over the visitor's");
  const views = (await db.collection("reportShares").doc("luna").get()).data() || {};
  ok(views.views === 2 && views.viewsBy?.qr === 1 && views.viewsBy?.direct === 1, "visits are counted by where they came from");
  await page("/r/luna", "facebookexternalhit/1.1");
  ok(((await db.collection("reportShares").doc("luna").get()).data() || {}).views === 2, "link previews aren't counted as visits");
  const hidden = await page("/r/hid");
  ok(hidden.status === 404 && !hidden.html.includes("Luna"), "hidden reports show as no longer available");
  ok((await page("/r/missing")).status === 404, "deleted reports show as no longer available");
  ok((await page("/r/home")).html.includes("tornato a casa"), "a resolved report celebrates");

  // Account deletion
  const del = await call("deleteAccount", owner.token, {});
  ok(del.status === 200 && !(await db.collection("reportShares").doc("luna").get()).exists, "deleting the account deletes its share numbers");

  console.log(failures ? `\n${failures} check(s) failed` : "\nAll sharing checks passed");
  process.exit(failures ? 1 : 0);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
