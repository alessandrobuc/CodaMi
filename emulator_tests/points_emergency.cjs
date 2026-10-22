// Points, invites and emergencies end to end. Run with emulator_tests/README.md.
const path = require("path");
const req = require("module").createRequire(path.join(__dirname, "../functions/package.json"));
const {initializeApp} = req("firebase-admin/app");
const {getFirestore, FieldValue, Timestamp} = req("firebase-admin/firestore");

const PROJECT = "demo-codami";
initializeApp({projectId: PROJECT});
const db = getFirestore();

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
    await sleep(400);
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
async function restGet(token, docPath) {
  return (await fetch(`${FS}/${docPath}`, {headers: {Authorization: `Bearer ${token}`}})).status;
}
async function restPatch(token, docPath, fields, mask) {
  const q = mask.map((m) => `updateMask.fieldPaths=${m}`).join("&");
  return (await fetch(`${FS}/${docPath}?${q}`, {
    method: "PATCH",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({fields}),
  })).status;
}
function value(v) {
  if (typeof v === "string") return {stringValue: v};
  if (typeof v === "number") return Number.isInteger(v) ? {integerValue: String(v)} : {doubleValue: v};
  if (typeof v === "boolean") return {booleanValue: v};
  if (Array.isArray(v)) return {arrayValue: {values: v.map(value)}};
  return {nullValue: null};
}
async function restCreateEmergency(token, id, fields) {
  const r = await fetch(`${FS}:commit`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({writes: [{
      update: {
        name: `projects/${PROJECT}/databases/(default)/documents/emergencies/${id}`,
        fields: Object.fromEntries(Object.entries(fields).map(([k, v]) => [k, value(v)])),
      },
      currentDocument: {exists: false},
      updateTransforms: ["createdAt", "updatedAt", "lastActivityAt"].map((fieldPath) => ({fieldPath, setToServerValue: "REQUEST_TIME"})),
    }]}),
  });
  return r.status;
}

const points = async (uid) => (await db.collection("users").doc(uid).get()).get("points") ?? 0;

(async () => {
  // ---------- Points and daily rewards ----------
  const inviter = await signUp("inviter@points.test");
  const friend = await signUp("friend@points.test");
  const friend2 = await signUp("friend2@points.test");
  const other = await signUp("other@points.test");
  const admin = await signUp("admin@points.test");
  const support = await signUp("support@points.test");
  const milan = {homeLat: 45.4642, homeLng: 9.19, city: "Milano", cityKey: "milano-mi-it"};
  await db.collection("users").doc(inviter.uid).set({name: "Ivo Rossi", role: "user", ...milan});
  await db.collection("users").doc(friend.uid).set({name: "Fede Bianchi", role: "user"});
  await db.collection("users").doc(friend2.uid).set({name: "Gina", role: "user"});
  await db.collection("users").doc(other.uid).set({name: "Other", role: "user", homeLat: 45.47, homeLng: 9.2, city: "Milano"});
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});
  await db.collection("users").doc(support.uid).set({name: "Staff", role: "support"});

  ok((await call("registerVisit", inviter.token, {installId: "install-inviter-0001"})).status === 200, "app registers a daily visit");
  const u1 = (await db.collection("users").doc(inviter.uid).get()).data();
  ok(u1.activity?.days === 1 && u1.installHashes?.length === 1 && u1.installHashes[0] !== "install-inviter-0001", "visit counts the day and keeps only a hash of the install ID");
  await call("registerVisit", inviter.token, {installId: "install-inviter-0001"});
  ok((await db.collection("users").doc(inviter.uid).get()).get("activity").days === 1, "a second visit on the same day doesn't count twice");

  const c1 = await call("claimDailyTask", inviter.token, {task: "checkin"});
  ok(c1.status === 200 && c1.result.points === 5 && c1.result.streak === 1, "daily check-in gives 5 points");
  const c2 = await call("claimDailyTask", inviter.token, {task: "checkin"});
  ok(c2.status === 409 || c2.error?.status === "ALREADY_EXISTS", "check-in can't be claimed twice a day");
  const c3 = await call("claimDailyTask", inviter.token, {task: "active"});
  ok(c3.status === 200 && c3.result.points === 10, "active today gives 10 points");
  ok(await points(inviter.uid) === 15, "points total is 15");
  const ledger = await db.collection("users").doc(inviter.uid).collection("pointsLedger").get();
  ok(ledger.size === 2, "each award is a ledger line");
  ok((await call("claimDailyTask", inviter.token, {task: "nope"})).status === 400, "unknown task rejected");

  // A 7-day streak gives a bonus on the next claim.
  const today = new Intl.DateTimeFormat("en-CA", {timeZone: "Europe/Rome"}).format(new Date());
  const y = new Date(`${today}T12:00:00Z`); y.setUTCDate(y.getUTCDate() - 1);
  await db.collection("users").doc(other.uid).update({daily: {day: y.toISOString().slice(0, 10), claimed: ["checkin"], streak: 6, streakDay: y.toISOString().slice(0, 10)}});
  const streak = await call("claimDailyTask", other.token, {task: "checkin"});
  ok(streak.result?.streak === 7 && streak.result?.bonus === 25 && await points(other.uid) === 30, "7th day in a row gives the 25-point streak bonus");

  // Points config from the admin panel.
  await db.collection("config").doc("points").set({dailyActive: 12});
  const cfg = await call("claimDailyTask", other.token, {task: "active"});
  ok(cfg.result?.points === 12, "point values follow config/points");
  await db.collection("config").doc("points").delete();

  // Rules on points
  ok(await restPatch(inviter.token, `users/${inviter.uid}`, {points: value(99999)}, ["points"]) === 403, "users can't set their own points");
  ok(await restPatch(inviter.token, `users/${inviter.uid}`, {referralCount: value(30)}, ["referralCount"]) === 403, "users can't set their own invite count");
  ok(await restPatch(inviter.token, `users/${inviter.uid}`, {name: value("Ivo R.")}, ["name"]) === 200, "users can still edit normal profile fields");
  ok(await restGet(inviter.token, `users/${inviter.uid}/pointsLedger/${ledger.docs[0].id}`) === 200, "users can read their own points history");
  ok(await restGet(other.token, `users/${inviter.uid}/pointsLedger/${ledger.docs[0].id}`) === 403, "others can't read someone's points history");

  // ---------- Referrals ----------
  const code1 = await call("getInviteCode", inviter.token, {});
  const code2 = await call("getInviteCode", inviter.token, {});
  ok(/^[A-HJ-NP-Z2-9]{6}$/.test(code1.result?.code) && code1.result.code === code2.result.code, "each user gets one stable invite code");
  const code = code1.result.code;

  const own = await call("redeemInviteCode", inviter.token, {code});
  ok(own.status === 400 && own.error?.details?.reason === "own_code", "own code can't be used, with its own reason");
  ok((await call("redeemInviteCode", friend.token, {code: "ZZZZZZ"})).status === 404, "unknown code rejected");
  const r1 = await call("redeemInviteCode", friend.token, {code: code.toLowerCase(), installId: "install-friend-00001"});
  ok(r1.status === 200 && r1.result.inviterName === "Ivo", "friend joins with the code (any case)");
  ok((await call("redeemInviteCode", friend.token, {code})).status === 409, "a code can only be used once per person");
  const ref1 = (await db.collection("referrals").doc(friend.uid).get()).data();
  ok(ref1.status === "pending" && ref1.flags.length === 0 && ref1.inviteeName === "Fede", "invite is pending with no flags");
  ok(await restGet(friend.token, `referrals/${friend.uid}`) === 200 && await restGet(inviter.token, `referrals/${friend.uid}`) === 200, "friend and inviter can see the invite");
  ok(await restGet(other.token, `referrals/${friend.uid}`) === 403, "others can't see the invite");

  // Not active enough yet.
  await call("registerVisit", friend.token, {installId: "install-friend-00001"});
  ok((await db.collection("referrals").doc(friend.uid).get()).get("status") === "pending", "one day of use isn't enough");
  const before = await points(inviter.uid);
  await db.collection("users").doc(friend.uid).update({activity: {days: 2, lastDay: "2000-01-01"}, cityKey: "milano-mi-it", city: "Milano"});
  await call("registerVisit", friend.token, {installId: "install-friend-00001"});
  ok((await db.collection("referrals").doc(friend.uid).get()).get("status") === "qualified", "friend qualifies after 3 active days with a city");
  const inv = (await db.collection("users").doc(inviter.uid).get()).data();
  ok(inv.points === before + 50 + 10 && inv.referralCount === 1 && inv.ambassadorLevel === "supporter", "inviter gets 50 points, the Supporter level and its 10-point bonus");
  await call("registerVisit", friend.token, {});
  ok(await points(inviter.uid) === before + 60, "qualifying can't pay twice");

  // Wrong guesses are limited per day.
  const guesser = await signUp("guesser@points.test");
  await db.collection("users").doc(guesser.uid).set({name: "Gino", role: "user"});
  for (let i = 0; i < 10; i++) await call("redeemInviteCode", guesser.token, {code: "ZZZZZ" + "23456789ABCD"[i]});
  ok((await call("redeemInviteCode", guesser.token, {code})).status === 429, "after 10 wrong codes in a day, even a real code waits until tomorrow");
  ok(await restPatch(guesser.token, `users/${guesser.uid}`, {inviteTries: value("reset")}, ["inviteTries"]) === 403, "users can't reset their wrong-code count");
  await db.collection("users").doc(guesser.uid).update({inviteTries: {day: "2000-01-01", count: 10}});
  ok((await call("redeemInviteCode", guesser.token, {code, installId: "install-guesser-001"})).status === 200, "the count starts again the next day");

  // Same phone as the inviter goes to admin review.
  const r2 = await call("redeemInviteCode", friend2.token, {code, installId: "install-inviter-0001"});
  ok(r2.status === 200, "an invite from the inviter's own phone is still accepted");
  ok((await db.collection("referrals").doc(friend2.uid).get()).get("flags").includes("same_device_as_inviter"), "it's flagged as the same device");
  await db.collection("users").doc(friend2.uid).update({activity: {days: 5, lastDay: "2000-01-01"}, cityKey: "milano-mi-it"});
  await call("registerVisit", friend2.token, {});
  ok((await db.collection("referrals").doc(friend2.uid).get()).get("status") === "review", "flagged invite waits for an admin instead of paying");
  const mid = await points(inviter.uid);
  ok((await call("adminReviewReferral", support.token, {inviteeId: friend2.uid, approve: true})).status === 403, "support staff can't review invites");
  const approved = await call("adminReviewReferral", admin.token, {inviteeId: friend2.uid, approve: true});
  ok(approved.status === 200 && (await db.collection("referrals").doc(friend2.uid).get()).get("status") === "qualified", "admin approves the invite");
  ok(await points(inviter.uid) === mid + 50, "approved invite pays the inviter");

  // Manual adjustment
  ok((await call("adminAdjustPoints", support.token, {uid: friend.uid, amount: 5, reason: "x"})).status === 403, "only admins adjust points");
  const adj = await call("adminAdjustPoints", admin.token, {uid: friend.uid, amount: 7, reason: "Event prize"});
  ok(adj.status === 200 && await points(friend.uid) === 7, "admin adds points with a reason");

  // ---------- Emergencies ----------
  ok((await call("seedTestContacts", support.token, {})).status === 403, "only admins add test contacts");
  const seeded = await call("seedTestContacts", admin.token, {});
  ok(seeded.result?.added === 6, "6 test contacts added");
  ok((await call("seedTestContacts", admin.token, {})).result?.added === 0, "test contacts aren't added twice");
  const contacts = await db.collection("emergencyContacts").get();
  ok(contacts.docs.every((d) => d.get("isTest") === true && d.get("verified") === false && d.get("name").startsWith("TEST")), "test contacts are clearly marked and not verified");
  const someContact = contacts.docs[0].id;
  ok(await restGet(friend.token, `emergencyContacts/${someContact}`) === 200, "users can read active contacts");
  ok(await restPatch(friend.token, `emergencyContacts/${someContact}`, {verified: value(true)}, ["verified"]) === 403, "users can't change contacts");

  // Nearby users: helper near Milan, far user in Rome, one with alerts off.
  const helper = await signUp("helper@points.test");
  const rome = await signUp("rome@points.test");
  const quiet = await signUp("quiet@points.test");
  await db.collection("users").doc(helper.uid).set({name: "Helper", role: "user", homeLat: 45.48, homeLng: 9.2});
  await db.collection("users").doc(rome.uid).set({name: "Rome", role: "user", homeLat: 41.9, homeLng: 12.5});
  await db.collection("users").doc(quiet.uid).set({name: "Quiet", role: "user", homeLat: 45.47, homeLng: 9.18, notificationPrefs: {emergency: {enabled: false}}});
  ok(await waitFor(async () => (await db.collection("users").doc(helper.uid).get()).get("homeGeohash")), "home geohash is added from the city position");
  await waitFor(async () => (await db.collection("users").doc(quiet.uid).get()).get("homeGeohash") && (await db.collection("users").doc(inviter.uid).get()).get("homeGeohash"));

  const base = {ownerId: friend.uid, ownerName: "Fede", type: "injured", species: "dog", description: "Dog hit by a car", photoUrls: [], lat: 45.465, lng: 9.19, placeLabel: "Via Roma, Milano", city: "Milano", status: "open"};
  ok(await restCreateEmergency(friend.token, "e-bad", {...base, status: "resolved"}) === 403, "an emergency must start open");
  ok(await restCreateEmergency(friend.token, "e-other", {...base, ownerId: other.uid}) === 403, "nobody can report in someone else's name");
  ok(await restCreateEmergency(friend.token, "e1", base) === 200, "user reports an emergency");

  const e1 = await waitFor(async () => {
    const d = (await db.collection("emergencies").doc("e1").get()).data();
    return d?.suggestedContacts ? d : null;
  });
  ok(e1 && e1.suggestedContacts.length > 0 && e1.suggestedContacts[0].name.includes("Milano"), "nearest contacts (Milan) are suggested first");
  ok(e1 && e1.suggestedContacts.every((c) => c.distanceKm < 30), "contacts far away (Rome, Naples) are left out");
  const notified = async (uid) => !(await db.collection("users").doc(uid).collection("notifications").where("emergencyId", "==", "e1").get()).empty;
  await sleep(1500);
  ok(await notified(helper.uid) && await notified(inviter.uid) && await notified(other.uid), "nearby users get an emergency alert");
  ok(!(await notified(rome.uid)), "users far away aren't alerted");
  ok(!(await notified(quiet.uid)), "users who turned emergency alerts off aren't alerted");
  ok(!(await notified(friend.uid)), "the reporter isn't alerted about their own emergency");
  ok(e1 && e1.alertRadiusKm === 25 && e1.alertedUsers === 3, "few users nearby, so the largest circle (25 km) is used");

  ok(await restPatch(friend.token, "emergencies/e1", {status: value("resolved")}, ["status"]) === 403, "status can't be changed directly");
  ok((await call("updateEmergency", helper.token, {emergencyId: "e1", action: "resolved"})).status === 400, "someone else can't resolve it");
  const help = await call("updateEmergency", helper.token, {emergencyId: "e1", action: "helping"});
  ok(help.result?.status === "helping", "a nearby user says they're going to help");
  const fr1 = await call("updateEmergency", rome.token, {emergencyId: "e1", action: "report_false"});
  const fr2 = await call("updateEmergency", rome.token, {emergencyId: "e1", action: "report_false"});
  ok(fr1.status === 200 && fr2.status === 409, "a user can report a false emergency once");
  ok((await call("updateEmergency", friend.token, {emergencyId: "e1", action: "false_alarm"})).status === 400, "only staff can mark a false alarm");
  const resolved = await call("updateEmergency", friend.token, {emergencyId: "e1", action: "resolved"});
  ok(resolved.result?.status === "resolved", "the reporter marks it resolved");
  const e1b = (await db.collection("emergencies").doc("e1").get()).data();
  ok(e1b.helpers.includes(helper.uid) && e1b.falseReports === 1 && e1b.resolvedAt, "helpers, false reports and resolve time are saved");
  const events = await db.collection("emergencies").doc("e1").collection("events").get();
  ok(events.size === 2, "every status change is in the timeline");
  ok(await restGet(friend.token, `emergencies/e1/events/${events.docs[0].id}`) === 403 && await restGet(support.token, `emergencies/e1/events/${events.docs[0].id}`) === 200, "only staff see the timeline");
  ok((await call("updateEmergency", support.token, {emergencyId: "e1", action: "false_alarm"})).result?.status === "false_alarm", "staff mark a false alarm");

  console.log(failures === 0 ? "\nALL PASSED" : `\n${failures} FAILED`);
  process.exit(failures === 0 ? 0 : 1);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
