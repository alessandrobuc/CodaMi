// AI photo moderation end to end, with fake Vision results. Run with emulator_tests/README.md.
const path = require("path");
const crypto = require("crypto");
const req = require("module").createRequire(path.join(__dirname, "../functions/package.json"));
const {initializeApp} = req("firebase-admin/app");
const {getFirestore} = req("firebase-admin/firestore");
const {getStorage} = req("firebase-admin/storage");

const PROJECT = "demo-codami";
const BUCKET = `${PROJECT}.appspot.com`;
initializeApp({projectId: PROJECT, storageBucket: BUCKET});
const db = getFirestore();
const bucket = getStorage().bucket();
const checkId = (p) => crypto.createHash("sha256").update(p).digest("hex").slice(0, 40);

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
    await sleep(500);
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

const JPEG = Buffer.from("/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDAoMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAz/wAALCAABAAEBAREA/8QAFAABAAAAAAAAAAAAAAAAAAAACf/EABQQAQAAAAAAAAAAAAAAAAAAAAD/2gAIAQEAAD8AKp//2Q==", "base64");
const safe = {adult: "VERY_UNLIKELY", racy: "UNLIKELY", violence: "UNLIKELY", medical: "UNLIKELY", spoof: "UNLIKELY"};

// The emulated function reads `fakeSafeSearch` instead of calling Vision.
async function upload(p, scores) {
  await bucket.file(p).save(JPEG, {
    contentType: "image/jpeg",
    metadata: {metadata: {fakeSafeSearch: JSON.stringify(scores), firebaseStorageDownloadTokens: "tok"}},
  });
  return `https://firebasestorage.googleapis.com/v0/b/${BUCKET}/o/${encodeURIComponent(p)}?alt=media&token=tok`;
}

async function check(p) {
  return waitFor(async () => {
    const s = await db.collection("photoChecks").doc(checkId(p)).get();
    return s.exists && s.get("status") !== "error" ? s.data() : null;
  });
}

const exists = async (p) => (await bucket.file(p).exists())[0];

async function callModerate(token, data) {
  const r = await fetch(`http://127.0.0.1:5001/${PROJECT}/europe-west1/moderatePhoto`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({data}),
  });
  return {status: r.status, body: await r.json()};
}

async function firestoreGet(token, docPath) {
  const r = await fetch(`http://127.0.0.1:8080/v1/projects/${PROJECT}/databases/(default)/documents/${docPath}`, {
    headers: {Authorization: `Bearer ${token}`},
  });
  return r.status;
}

async function storageGet(token, p) {
  const r = await fetch(`http://127.0.0.1:9199/v0/b/${BUCKET}/o/${encodeURIComponent(p)}?alt=media`, {
    headers: {Authorization: `Firebase ${token}`},
  });
  return r.status;
}

(async () => {
  const owner = await signUp("owner@test.com");
  const other = await signUp("other@test.com");
  const staff = await signUp("staff@test.com");
  await db.collection("users").doc(owner.uid).set({name: "Owner", role: "user"});
  await db.collection("users").doc(other.uid).set({name: "Other", role: "user"});
  await db.collection("users").doc(staff.uid).set({name: "Staff", role: "support"});

  // Same layout as the app: {folder}/{uid}/{docId}/{file}
  const clearPath = `pets/${owner.uid}/pet1/1_0.jpg`;
  const racyPath = `pets/${owner.uid}/pet1/2_0.jpg`;
  const adultPath = `reports/${owner.uid}/r1/3_0.jpg`;
  const bloodPath = `reports/${owner.uid}/r1/4_0.jpg`;
  const mildPath = `reports/${owner.uid}/r1/5_0.jpg`;
  const emergencyPath = `emergencies/${owner.uid}/e1/1_0.jpg`;

  const clearUrl = await upload(clearPath, safe);
  const racyUrl = await upload(racyPath, {...safe, racy: "LIKELY"});
  const adultUrl = await upload(adultPath, {...safe, adult: "VERY_LIKELY"});
  await upload(bloodPath, {...safe, violence: "VERY_LIKELY", medical: "VERY_LIKELY"});
  await upload(mildPath, {...safe, violence: "LIKELY", medical: "VERY_LIKELY"});
  await upload(emergencyPath, {...safe, adult: "POSSIBLE"});
  await upload(`videos/v1/thumbnail.jpg`, {...safe, adult: "VERY_LIKELY"});

  const c1 = await check(clearPath);
  ok(c1?.status === "clear", "safe photo is clear");
  ok(await exists(clearPath), "safe photo stays in place");

  const c2 = await check(racyPath);
  ok(c2?.status === "pending" && c2.result === "review" && c2.reason === "racy", "likely racy photo goes to review");
  ok(!(await exists(racyPath)) && await exists(`quarantine/${racyPath}`), "review photo moved to quarantine");
  ok(c2?.ownerName === "Owner", "owner name saved for moderators");
  ok(c2?.url === racyUrl, "original link saved so the app can finish saving");

  const c3 = await check(adultPath);
  ok(c3?.status === "pending" && c3.result === "blocked", "very likely adult photo is blocked and pending");

  const c4 = await check(bloodPath);
  ok(c4?.result === "review" && c4.reason === "violence", "very bloody photo goes to review, not blocked");

  const c5 = await check(mildPath);
  ok(c5?.status === "clear", "mild injury and medical photo is allowed");

  const c6 = await check(emergencyPath);
  ok(c6?.status === "pending" && c6.folder === "emergencies", "emergency photos are checked too");

  await sleep(2000);
  ok(!(await db.collection("photoChecks").doc(checkId("videos/v1/thumbnail.jpg")).get()).exists, "admin videos are not checked");

  // Rules
  ok(await firestoreGet(owner.token, `photoChecks/${checkId(racyPath)}`) === 200, "owner can read own photo check");
  ok(await firestoreGet(other.token, `photoChecks/${checkId(racyPath)}`) === 403, "other users can't read photo checks");
  ok(await firestoreGet(staff.token, `photoChecks/${checkId(racyPath)}`) === 200, "staff can read photo checks");
  ok(await storageGet(staff.token, `quarantine/${racyPath}`) === 200, "staff can see held photos");
  ok(await storageGet(owner.token, `quarantine/${racyPath}`) === 403, "owner can't see held photos in quarantine");
  ok(await storageGet(other.token, racyPath) === 404, "held photo link no longer works");

  const pet = await db.collection("pets").add({ownerId: owner.uid, name: "Luna", photoUrls: [racyUrl, clearUrl]});
  const report = await db.collection("reports").add({ownerId: owner.uid, petName: "Luna", photoUrls: [adultUrl, clearUrl], status: "open"});

  // Review actions
  const denied = await callModerate(other.token, {checkId: checkId(racyPath), action: "approve"});
  ok(denied.status === 403, "normal users can't review photos");

  const approved = await callModerate(staff.token, {checkId: checkId(racyPath), action: "approve"});
  ok(approved.status === 200 && approved.body.result?.status === "approved", "staff approves a photo");
  ok(await exists(racyPath) && !(await exists(`quarantine/${racyPath}`)), "approved photo moved back");
  const [meta] = await bucket.file(racyPath).getMetadata();
  ok(meta.metadata?.firebaseStorageDownloadTokens === "tok", "approved photo keeps its old download link");
  const linkStatus = (await fetch(`http://127.0.0.1:9199/v0/b/${BUCKET}/o/${encodeURIComponent(racyPath)}?alt=media&token=tok`)).status;
  ok(linkStatus === 200, "old download link works again");
  await sleep(2000);
  ok((await db.collection("photoChecks").doc(checkId(racyPath)).get()).get("status") === "approved", "approved photo is not checked again after moving back");
  ok((await pet.get()).get("photoUrls").length === 2, "approved photo stays on the pet");

  const again = await callModerate(staff.token, {checkId: checkId(racyPath), action: "remove"});
  ok(again.status === 400 || again.status === 412 || again.body.error?.status === "FAILED_PRECONDITION", "a photo can't be reviewed twice");

  const removed = await callModerate(staff.token, {checkId: checkId(adultPath), action: "remove"});
  ok(removed.status === 200 && removed.body.result?.status === "removed", "staff removes a photo");
  const reportPhotos = (await report.get()).get("photoUrls");
  ok(reportPhotos.length === 1 && reportPhotos[0] === clearUrl, "removed photo taken out of the listing");
  const c3after = (await db.collection("photoChecks").doc(checkId(adultPath)).get()).data();
  ok(c3after.status === "removed" && c3after.purgeAt && c3after.reviewedBy === staff.uid, "removal recorded with reviewer and purge date");
  const purgeDays = (c3after.purgeAt.toMillis() - Date.now()) / 86_400_000;
  ok(purgeDays > 6.9 && purgeDays <= 7, "removed photo is kept in quarantine for 7 days");
  ok(await exists(`quarantine/${adultPath}`), "removed photo still in quarantine until then");

  const bad = await callModerate(staff.token, {checkId: "x/y", action: "remove"});
  ok(bad.status === 400, "bad check id rejected");

  console.log(failures === 0 ? "\nALL PASSED" : `\n${failures} FAILED`);
  process.exit(failures === 0 ? 0 : 1);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
