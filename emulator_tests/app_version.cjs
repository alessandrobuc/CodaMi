// App version settings (config/appVersion): who can read and write them, value checks. Run with emulator_tests/README.md.
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

const FS = `http://127.0.0.1:8080/v1/projects/${PROJECT}/databases/(default)/documents`;
const DOC = `projects/${PROJECT}/databases/(default)/documents/config/appVersion`;

function value(v) {
  if (typeof v === "string") return {stringValue: v};
  if (typeof v === "number") return {integerValue: String(v)};
  if (typeof v === "boolean") return {booleanValue: v};
  return {nullValue: null};
}
const fields = (obj) => Object.fromEntries(Object.entries(obj).map(([k, v]) => [k, value(v)]));

// Same write as the app: the whole document with a server time.
async function save(token, data) {
  const r = await fetch(`${FS}:commit`, {
    method: "POST",
    headers: {"Content-Type": "application/json", ...(token ? {Authorization: `Bearer ${token}`} : {})},
    body: JSON.stringify({writes: [{
      update: {name: DOC, fields: fields(data)},
      updateTransforms: [{fieldPath: "updatedAt", setToServerValue: "REQUEST_TIME"}],
    }]}),
  });
  return r.status;
}
async function read(token) {
  return (await fetch(`${FS}/config/appVersion`, {headers: token ? {Authorization: `Bearer ${token}`} : {}})).status;
}

const valid = {
  androidLatest: "1.2.0",
  androidMinimum: "1.0.0",
  iosLatest: "1.2",
  iosMinimum: "",
  appStoreId: "1234567890",
};

(async () => {
  const admin = await signUp("admin@version.test");
  const support = await signUp("support@version.test");
  const user = await signUp("user@version.test");
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});
  await db.collection("users").doc(support.uid).set({name: "Support", role: "support"});
  await db.collection("users").doc(user.uid).set({name: "User", role: "user"});

  // ---------- Who can write ----------
  ok(await save(null, valid) === 403, "signed-out visitors can't change versions");
  ok(await save(user.token, valid) === 403, "users can't change versions");
  ok(await save(support.token, valid) === 403, "support staff can't change versions");
  ok(await save(admin.token, valid) === 200, "admin saves the versions");
  const saved = (await db.doc("config/appVersion").get()).data();
  ok(saved?.androidLatest === "1.2.0" && saved?.appStoreId === "1234567890" && saved?.updatedAt, "saved with all fields and the time");
  ok(await save(admin.token, {androidLatest: "", androidMinimum: "", iosLatest: "", iosMinimum: "", appStoreId: ""}) === 200,
    "empty values save (checks turned off)");

  // ---------- Who can read ----------
  ok(await read(null) === 200, "readable before sign-in (checked on the login screen)");
  ok(await read(user.token) === 200, "users read the versions");

  // ---------- Value checks ----------
  ok(await save(admin.token, {...valid, androidLatest: "v1.2"}) === 403, "a version with letters is refused");
  ok(await save(admin.token, {...valid, iosMinimum: "1"}) === 403, "a version with one number is refused");
  ok(await save(admin.token, {...valid, androidMinimum: "1.0.0.0"}) === 403, "a version with four numbers is refused");
  ok(await save(admin.token, {...valid, iosLatest: 2}) === 403, "a version that isn't text is refused");
  ok(await save(admin.token, {...valid, appStoreId: "id123456"}) === 403, "an App Store ID with letters is refused");
  ok(await save(admin.token, {...valid, appStoreId: "123"}) === 403, "a too short App Store ID is refused");
  ok(await save(admin.token, {...valid, forceAll: true}) === 403, "unknown fields are refused");

  console.log(failures ? `\n${failures} check(s) failed` : "\nAll app version checks passed");
  process.exit(failures ? 1 : 0);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
