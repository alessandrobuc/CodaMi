// Breed scanner: settings rules, the off switch, photo checks, daily limit and the cleaned answer. Run with emulator_tests/README.md.
// Gemini is not called here: in the emulator the function answers with a fixed Labrador result.
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
  const body = await r.json();
  return {status: r.status, result: body.result, error: body.error};
}

const FS = `http://127.0.0.1:8080/v1/projects/${PROJECT}/databases/(default)/documents`;
const docName = (p) => `projects/${PROJECT}/databases/(default)/documents/${p}`;
function value(v) {
  if (typeof v === "string") return {stringValue: v};
  if (typeof v === "number") return Number.isInteger(v) ? {integerValue: String(v)} : {doubleValue: v};
  if (typeof v === "boolean") return {booleanValue: v};
  return {nullValue: null};
}
const fields = (obj) => Object.fromEntries(Object.entries(obj).map(([k, v]) => [k, value(v)]));
async function write(token, p, data) {
  const r = await fetch(`${FS}:commit`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({writes: [{
      update: {name: docName(p), fields: fields(data)},
      updateTransforms: [{fieldPath: "updatedAt", setToServerValue: "REQUEST_TIME"}],
    }]}),
  });
  return r.status;
}
async function get(token, p) {
  return (await fetch(`${FS}/${p}`, {headers: {Authorization: `Bearer ${token}`}})).status;
}

const scanner = (uid, extra = {}) => ({enabled: false, dailyScans: 2, model: "gemini-3.8-flash", updatedBy: uid, ...extra});
// A small JPEG-looking file: the right first bytes and enough size to pass the checks.
const jpeg = Buffer.concat([Buffer.from([0xff, 0xd8, 0xff, 0xe0]), Buffer.alloc(4000, 7)]).toString("base64");
const pdf = Buffer.concat([Buffer.from("%PDF-1.7"), Buffer.alloc(4000, 7)]).toString("base64");
const today = new Intl.DateTimeFormat("en-CA", {timeZone: "Europe/Rome"}).format(new Date());

(async () => {
  const admin = await signUp("admin@scanner.test");
  const user = await signUp("user@scanner.test");
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});
  await db.collection("users").doc(user.uid).set({name: "User", role: "user"});

  // Settings
  ok(await write(admin.token, "config/scanner", scanner(admin.uid)) === 200, "admin saves scanner settings");
  ok(await get(user.token, "config/scanner") === 200, "users read scanner settings");
  ok(await write(user.token, "config/scanner", scanner(user.uid, {enabled: true})) === 403, "users can't turn the scanner on");
  ok(await write(admin.token, "config/scanner", scanner(admin.uid, {dailyScans: 0})) === 403, "0 scans a day refused");
  ok(await write(admin.token, "config/scanner", scanner(admin.uid, {dailyScans: 101})) === 403, "more than 100 scans a day refused");
  ok(await write(admin.token, "config/scanner", scanner(admin.uid, {model: "gpt-5"})) === 403, "only Gemini model names accepted");
  ok(await write(admin.token, "config/scanner", scanner(admin.uid, {apiKey: "x"})) === 403, "extra fields refused");

  // Model list for the admin's picker (Google's list isn't reachable in the emulator, so the usual models come back)
  ok((await call("scannerModels", user.token, {})).error?.status === "PERMISSION_DENIED", "only admins get the model list");
  const models = await call("scannerModels", admin.token, {});
  ok(models.status === 200 && models.result?.models?.some((m) => m.id === "gemini-3.8-flash" && m.tier === "flash"),
    "admins get the Gemini models with their tier");
  ok(models.result?.recommended === "gemini-3.8-flash" && models.result?.fromGoogle === false,
    "the recommended model is marked, and the list says when it's the usual one");

  // Off, sign-in and photo checks
  const scan = {image: jpeg, language: "it"};
  ok((await call("scanBreed", "", scan)).error?.status === "UNAUTHENTICATED", "scanning needs sign-in");
  ok((await call("scanBreed", user.token, scan)).error?.status === "FAILED_PRECONDITION", "users can't scan while the scanner is off");
  const adminScan = await call("scanBreed", admin.token, scan);
  ok(adminScan.status === 200 && adminScan.result?.breeds?.[0]?.name === "Labrador Retriever", "admins can try the scanner while it's off");
  ok((await call("scanBreed", user.token, {image: pdf})).error?.status === "INVALID_ARGUMENT", "a file that isn't a photo is refused");
  ok((await call("scanBreed", user.token, {image: "abc"})).error?.status === "INVALID_ARGUMENT", "a tiny or broken photo is refused");
  ok((await call("scanBreed", user.token, {})).error?.status === "INVALID_ARGUMENT", "a scan without a photo is refused");

  // On for users: the answer and the daily limit
  ok(await write(admin.token, "config/scanner", scanner(admin.uid, {enabled: true})) === 200, "admin turns the scanner on");
  const first = await call("scanBreed", user.token, scan);
  const r = first.result ?? {};
  ok(first.status === 200 && r.animalFound === true && r.species === "dog", "the scan finds the animal and its species");
  ok(r.breeds?.length === 2 && r.breeds[0].confidence === 74 && r.breeds[1].name === "Golden Retriever",
    "the most likely breed comes first, with the alternatives and their %");
  ok(r.info?.weight === "25-36 kg" && r.info?.lifeSpan === "10-12 years", "breed facts are included");
  ok(!("image" in r), "the photo isn't sent back");
  ok((await db.collection("scanUsage").doc(user.uid).get()).get("scans") === 1, "each scan is counted for the day");
  await call("scanBreed", user.token, scan);
  ok((await call("scanBreed", user.token, scan)).error?.status === "RESOURCE_EXHAUSTED", "the daily limit stops the third scan");
  await db.collection("scanUsage").doc(user.uid).set({day: "2020-01-01", scans: 2});
  ok((await call("scanBreed", user.token, scan)).status === 200, "the limit starts again the next day");
  ok((await db.collection("scanUsage").doc(user.uid).get()).get("day") === today, "the counter moves to today");
  ok(await get(user.token, `scanUsage/${user.uid}`) === 403, "users can't read scan counters");
  ok(await write(user.token, `scanUsage/${user.uid}`, {day: today, scans: 0}) === 403, "users can't reset scan counters");
  ok((await db.collection("scanUsage").limit(5).get()).docs.every((d) => Object.keys(d.data()).sort().join() === "day,scans"),
    "only the day and the count are kept, no photos or results");

  // Account deletion removes the counter
  const del = await call("deleteAccount", user.token, {});
  ok(del.status === 200 && !(await db.collection("scanUsage").doc(user.uid).get()).exists, "deleting the account deletes the scan counter");

  console.log(failures ? `\n${failures} check(s) failed` : "\nAll breed scanner checks passed");
  process.exit(failures ? 1 : 0);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
