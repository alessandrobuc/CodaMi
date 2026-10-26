// Petitions: who can read and write them, field checks and image rules. Run with emulator_tests/README.md.
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

const FS = `http://127.0.0.1:8080/v1/projects/${PROJECT}/databases/(default)/documents`;
const docName = (id) => `projects/${PROJECT}/databases/(default)/documents/petitions/${id}`;

function value(v) {
  if (v instanceof Date) return {timestampValue: v.toISOString()};
  if (typeof v === "string") return {stringValue: v};
  if (typeof v === "number") return Number.isInteger(v) ? {integerValue: String(v)} : {doubleValue: v};
  if (typeof v === "boolean") return {booleanValue: v};
  if (Array.isArray(v)) return {arrayValue: {values: v.map(value)}};
  if (v && typeof v === "object") return {mapValue: {fields: fields(v)}};
  return {nullValue: null};
}
const fields = (obj) => Object.fromEntries(Object.entries(obj).map(([k, v]) => [k, value(v)]));

// Writes the whole document, with the given fields set to the request time.
async function write(token, id, data, {create = false, stamps = ["updatedAt"]} = {}) {
  const r = await fetch(`${FS}:commit`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({writes: [{
      update: {name: docName(id), fields: fields(data)},
      ...(create ? {currentDocument: {exists: false}} : {}),
      updateTransforms: stamps.map((fieldPath) => ({fieldPath, setToServerValue: "REQUEST_TIME"})),
    }]}),
  });
  return r.status;
}
async function get(token, id) {
  return (await fetch(`${FS}/petitions/${id}`, {headers: {Authorization: `Bearer ${token}`}})).status;
}
async function remove(token, id) {
  return (await fetch(`${FS}/petitions/${id}`, {method: "DELETE", headers: {Authorization: `Bearer ${token}`}})).status;
}
async function listPublished(token) {
  const r = await fetch(`${FS}:runQuery`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({structuredQuery: {
      from: [{collectionId: "petitions"}],
      where: {fieldFilter: {field: {fieldPath: "review"}, op: "EQUAL", value: {stringValue: "published"}}},
    }}),
  });
  const body = await r.json();
  return {status: r.status, count: Array.isArray(body) ? body.filter((x) => x.document).length : 0};
}
async function listAll(token) {
  const r = await fetch(`${FS}:runQuery`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({structuredQuery: {from: [{collectionId: "petitions"}]}}),
  });
  return r.status;
}
// Same multipart upload as the Firebase SDKs, so the Storage rules apply.
async function upload(token, p, contentType = "image/jpeg", size = 1000) {
  const boundary = "petitiontest";
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

const allChecks = {exists: true, genuine: true, clearGoal: true, notMisleading: true};
function petition(uid, extra = {}) {
  return {
    url: "https://www.change.org/p/ban-wild-animals-in-circuses",
    title: "Ban wild animals in circuses",
    source: "Change.org",
    topic: "entertainment",
    summary: "A call to end wild animal acts.",
    issue: "Wild animals are kept in small cages on the road.",
    action: "Pass a national ban.",
    why: "Travelling shows cause lasting stress.",
    imagePermission: false,
    review: "pending",
    status: "active",
    checks: {exists: false, genuine: false, clearGoal: false, notMisleading: false},
    createdBy: uid,
    updatedBy: uid,
    ...extra,
  };
}

(async () => {
  const admin = await signUp("admin@petitions.test");
  const support = await signUp("support@petitions.test");
  const user = await signUp("user@petitions.test");
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});
  await db.collection("users").doc(support.uid).set({name: "Support", role: "support"});
  await db.collection("users").doc(user.uid).set({name: "User", role: "user"});
  const create = {create: true, stamps: ["createdAt", "updatedAt"]};

  // ---------- Who can write ----------
  ok(await write(user.token, "u1", petition(user.uid), create) === 403, "users can't add petitions");
  ok(await write(support.token, "s1", petition(support.uid), create) === 403, "support staff can't add petitions");
  ok(await write(admin.token, "p1", petition(admin.uid), create) === 200, "admin adds a petition to review");
  ok(await write(admin.token, "p2", petition(user.uid), create) === 403, "admin can't add a petition in someone else's name");

  // ---------- Field checks ----------
  ok(await write(admin.token, "bad1", petition(admin.uid, {url: "http://www.change.org/p/x"}), create) === 403, "http links refused");
  ok(await write(admin.token, "bad2", petition(admin.uid, {url: "javascript:alert(1)"}), create) === 403, "script links refused");
  ok(await write(admin.token, "bad3", petition(admin.uid, {url: "https://user@evil.com/p"}), create) === 403, "links with a user name refused");
  ok(await write(admin.token, "bad4", petition(admin.uid, {title: ""}), create) === 403, "empty title refused");
  ok(await write(admin.token, "bad5", petition(admin.uid, {summary: "x".repeat(301)}), create) === 403, "summary over 300 characters refused");
  ok(await write(admin.token, "bad6", petition(admin.uid, {topic: "politics"}), create) === 403, "unknown topic refused");
  ok(await write(admin.token, "bad7", petition(admin.uid, {status: "deleted"}), create) === 403, "unknown status refused");
  ok(await write(admin.token, "bad8", petition(admin.uid, {signatures: 5000}), create) === 403, "extra fields such as signature counts refused");
  ok(await write(admin.token, "bad9", petition(admin.uid), {create: true, stamps: ["createdAt"]}) === 403, "updatedAt must be the server time");

  // ---------- Editorial control ----------
  const p1Created = (await db.collection("petitions").doc("p1").get()).get("createdAt").toDate();
  ok(await write(admin.token, "p1", {...petition(admin.uid, {review: "approved"}), createdAt: p1Created}) === 403,
    "approving without the verification checks refused");
  ok(await write(admin.token, "p1", {...petition(admin.uid, {review: "approved", checks: allChecks}), createdAt: p1Created}) === 200,
    "approving with every check works");
  ok(await write(admin.token, "p1", {...petition(admin.uid), createdAt: p1Created}) === 200, "back to review");
  ok(await write(admin.token, "p3", petition(admin.uid, {review: "published", checks: allChecks}), create) === 403,
    "publishing without a publish date refused");
  ok(await write(admin.token, "p3", petition(admin.uid, {review: "published", checks: allChecks}),
    {create: true, stamps: ["createdAt", "updatedAt", "publishedAt"]}) === 200, "admin publishes a verified petition");
  ok(await write(admin.token, "p4", petition(admin.uid, {review: "rejected", rejectReason: "Not about animals"}), create) === 200,
    "admin rejects a petition with a reason");
  const p3 = await db.collection("petitions").doc("p3").get();
  ok(await write(admin.token, "p3", {...petition(admin.uid, {review: "published", checks: allChecks, status: "closed"}),
    publishedAt: p3.get("publishedAt").toDate()}, {stamps: ["updatedAt", "createdAt"]}) === 403,
    "createdAt can't be changed on update");

  // ---------- Who can read ----------
  ok(await get(user.token, "p3") === 200, "users can read a published petition");
  ok(await get(user.token, "p1") === 403, "users can't read a petition still under review");
  ok(await get(user.token, "p4") === 403, "users can't read a rejected petition");
  ok((await listPublished(user.token)).count === 1, "users' list shows only published petitions");
  ok(await listAll(user.token) === 403, "users can't list every petition");
  ok(await listAll(support.token) === 403, "support staff can't list every petition");
  ok(await listAll(admin.token) === 200, "admin lists every petition");

  // ---------- Images ----------
  ok(await upload(admin.token, "petitions/p1/image_1.jpg") === 200, "admin uploads a petition image");
  ok(await upload(user.token, "petitions/p1/image_2.jpg") === 403, "users can't upload petition images");
  ok(await upload(admin.token, "petitions/p1/image_3.gif", "image/gif") === 403, "other file names refused");
  ok(await upload(admin.token, "petitions/p1/image_4.jpg", "text/html") === 403, "non-images refused");
  ok(await upload(admin.token, "petitions/p1/image_5.jpg", "image/jpeg", 5 * 1024 * 1024 + 1) === 403, "images over 5 MB refused");
  const withImage = (extra) => petition(admin.uid, {imageUrl: "https://example.com/i.jpg", imagePath: "petitions/p1/image_1.jpg", ...extra});
  ok(await write(admin.token, "p1", {...withImage({}), createdAt: p1Created}) === 403, "image without the permission box refused");
  ok(await write(admin.token, "p1", {...withImage({imagePermission: true, imagePath: "petitions/p9/image_1.jpg"}), createdAt: p1Created}) === 403,
    "image from another petition's folder refused");
  ok(await write(admin.token, "p1", {...withImage({imagePermission: true}), createdAt: p1Created}) === 200, "image with permission saved");

  // ---------- Delete ----------
  ok(await remove(user.token, "p3") === 403, "users can't delete petitions");
  ok(await remove(admin.token, "p4") === 200, "admin deletes a petition");

  console.log(failures ? `\n${failures} check(s) failed` : "\nAll petition checks passed");
  process.exit(failures ? 1 : 0);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
