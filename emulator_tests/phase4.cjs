// Places to walk and donations: settings rules, the off switch and input checks. Run with emulator_tests/README.md.
// Real Google searches are not run here (they need the live Places key).
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
  return {status: r.status, error: body.error};
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

const walks = (uid, extra = {}) => ({
  enabled: false, defaultRadiusKm: 5, groups: {dogParks: true, parks: true, green: true, trails: true},
  hiddenPlaceIds: [], hiddenNames: {}, dailySearches: 40, dailyDetails: 60, updatedBy: uid, ...extra,
});
const donations = (uid, extra = {}) => ({
  enabled: false, showInProfile: true, afterReport: true, afterFound: true, daysBetweenPrompts: 30,
  amountsCents: [100, 300, 500], paymentsReady: false, updatedBy: uid, ...extra,
});

(async () => {
  const admin = await signUp("admin@phase4.test");
  const user = await signUp("user@phase4.test");
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});
  await db.collection("users").doc(user.uid).set({name: "User", role: "user"});

  // Places to walk settings
  ok(await write(admin.token, "config/walks", walks(admin.uid)) === 200, "admin saves places to walk settings");
  ok(await get(user.token, "config/walks") === 200, "users read places to walk settings");
  ok(await write(user.token, "config/walks", walks(user.uid, {enabled: true})) === 403, "users can't turn places to walk on");
  ok(await write(admin.token, "config/walks", walks(admin.uid, {defaultRadiusKm: 7})) === 403, "distance outside the choices refused");
  ok(await write(admin.token, "config/walks", walks(admin.uid, {dailySearches: 0})) === 403, "daily search limit of 0 refused");
  ok(await write(admin.token, "config/walks", walks(admin.uid, {groups: {beaches: true}})) === 403, "unknown place type refused");
  ok(await write(admin.token, "config/walks", walks(admin.uid, {apiKey: "x"})) === 403, "extra fields refused");
  ok(await get(user.token, `walkUsage/${user.uid}`) === 403, "users can't read search counters");
  ok(await write(user.token, `walkUsage/${user.uid}`, {day: "2026-11-02", searches: 0, details: 0}) === 403,
    "users can't reset search counters");

  // Places to walk functions
  const search = {lat: 45.46, lng: 9.19, radiusKm: 5, language: "it"};
  ok((await call("findWalkPlaces", user.token, search)).error?.status === "FAILED_PRECONDITION",
    "search refused for users while the section is off");
  ok((await call("walkPlaceDetails", user.token, {placeId: "ChIJabc", language: "it"})).error?.status === "FAILED_PRECONDITION",
    "details refused for users while the section is off");
  ok((await call("findWalkPlaces", user.token, {...search, radiusKm: 7})).error?.status === "INVALID_ARGUMENT",
    "distance outside the choices refused by the server");
  ok((await call("findWalkPlaces", user.token, {...search, lat: 120})).error?.status === "INVALID_ARGUMENT",
    "impossible position refused by the server");
  ok((await call("findWalkPlaces", "", search)).error?.status === "UNAUTHENTICATED", "search needs sign-in");
  ok(await write(admin.token, "config/walks", walks(admin.uid, {enabled: true, dailySearches: 1})) === 200,
    "admin turns places to walk on");
  await db.collection("walkUsage").doc(user.uid).set({
    day: new Intl.DateTimeFormat("en-CA", {timeZone: "Europe/Rome"}).format(new Date()), searches: 1, details: 0,
  });
  ok((await call("findWalkPlaces", user.token, {...search, lat: 41.9, lng: 12.5})).error?.status === "RESOURCE_EXHAUSTED",
    "daily search limit stops the search before Google is called");

  // Donation settings
  ok(await write(admin.token, "config/donations", donations(admin.uid)) === 200, "admin saves donation settings");
  ok(await get(user.token, "config/donations") === 200, "users read donation settings");
  ok(await write(user.token, "config/donations", donations(user.uid, {enabled: true})) === 403, "users can't turn donations on");
  ok(await write(admin.token, "config/donations", donations(admin.uid, {paymentsReady: true})) === 403,
    "payments can't be marked ready from the app");
  ok(await write(admin.token, "config/donations", donations(admin.uid, {daysBetweenPrompts: 0})) === 403, "0 days between messages refused");
  ok(await write(admin.token, "config/donations", donations(admin.uid, {amountsCents: [1, 2, 3, 4, 5, 6, 7]})) === 403,
    "more than 6 amounts refused");
  ok(await write(admin.token, "config/donations", donations(admin.uid, {enabled: true})) === 200, "admin turns donations on");

  console.log(failures ? `\n${failures} check(s) failed` : "\nAll places to walk and donation checks passed");
  process.exit(failures ? 1 : 0);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
