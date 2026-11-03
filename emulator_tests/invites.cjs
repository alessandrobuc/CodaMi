// Invite tracking: QR and link opens from the invite page, admin counts and ranking. Run with emulator_tests/README.md.
const path = require("path");
const req = require("module").createRequire(path.join(__dirname, "../functions/package.json"));
const {initializeApp} = req("firebase-admin/app");
const {getFirestore, Timestamp} = req("firebase-admin/firestore");

const PROJECT = "demo-codami";
const FN = `http://127.0.0.1:5001/${PROJECT}/europe-west1`;
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
  const r = await fetch(`${FN}/${name}`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({data}),
  });
  const body = await r.json();
  return {status: r.status, result: body.result, error: body.error};
}

async function open(code, source, visitor, method = "POST") {
  const r = await fetch(`${FN}/trackInviteOpen`, {
    method,
    headers: {"Content-Type": "application/json", "X-Forwarded-For": visitor, "User-Agent": `test-${visitor}`},
    body: method === "POST" ? JSON.stringify({code, source}) : undefined,
  });
  return r.status;
}

const FS = `http://127.0.0.1:8080/v1/projects/${PROJECT}/databases/(default)/documents`;
async function get(token, p) {
  return (await fetch(`${FS}/${p}`, {headers: {Authorization: `Bearer ${token}`}})).status;
}

const today = new Intl.DateTimeFormat("en-CA", {timeZone: "Europe/Rome"}).format(new Date());
const daysAgo = (n) => new Intl.DateTimeFormat("en-CA", {timeZone: "Europe/Rome"}).format(new Date(Date.now() - n * 86_400_000));
const opensOf = async (code) => (await db.collection("inviteOpens").doc(`${code}_${today}`).get()).data() ?? {};

(async () => {
  // Earlier scripts leave invites behind; the all-time totals below need only these.
  for (const name of ["referrals", "inviteOpens", "inviteOpenSeen"]) await db.recursiveDelete(db.collection(name));
  const admin = await signUp("admin@invites.test");
  const inviter = await signUp("inviter@invites.test");
  const other = await signUp("other@invites.test");
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});
  await db.collection("users").doc(inviter.uid).set({name: "Marta Rossi", role: "user", inviteCode: "QWE789"});
  await db.collection("users").doc(other.uid).set({name: "Luca", role: "user", inviteCode: "ZXC456"});
  await db.collection("inviteCodes").doc("QWE789").set({uid: inviter.uid});
  await db.collection("inviteCodes").doc("ZXC456").set({uid: other.uid});

  // Opens from the invite page
  ok(await open("QWE789", "qr", "10.0.0.1") === 204, "a QR scan is accepted");
  ok((await opensOf("QWE789")).qr === 1 && (await opensOf("QWE789")).uid === inviter.uid, "the QR scan is counted for the code's owner");
  await open("QWE789", "qr", "10.0.0.1");
  ok((await opensOf("QWE789")).qr === 1, "the same visitor counts once a day");
  await open("qwe789", "qr", "10.0.0.2");
  await open("QWE789", "link", "10.0.0.3");
  await open("QWE789", "something", "10.0.0.4");
  const counted = await opensOf("QWE789");
  ok(counted.qr === 2 && counted.link === 2, "other visitors count, and anything but a QR counts as a link");
  ok(await open("ZZZZZZ", "qr", "10.0.0.5") === 204 && !(await db.collection("inviteOpens").doc(`ZZZZZZ_${today}`).get()).exists,
    "unknown codes are not counted");
  ok(await open("bad code!", "qr", "10.0.0.6") === 204, "a broken code is ignored without an error");
  ok(await open("QWE789", "qr", "10.0.0.7", "GET") === 405, "only the invite page's POST is accepted");
  const seen = await db.collection("inviteOpenSeen").limit(1).get();
  ok(!seen.empty && Object.keys(seen.docs[0].data()).join() === "day", "only a daily hash is kept for each visitor, no IP");
  await open("ZXC456", "link", "10.0.0.1");
  ok(await get(inviter.token, `inviteOpens/QWE789_${today}`) === 403, "users can't read open counts");
  ok(await get(inviter.token, `inviteOpenSeen/${seen.docs[0].id}`) === 403, "users can't read visitor hashes");

  // Invites of the inviter: active (one still using), inactive, waiting; one older, for the period checks
  const friends = [
    {id: "fA", status: "qualified", lastDay: today, ago: 1},
    {id: "fB", status: "qualified", lastDay: daysAgo(60), ago: 2},
    {id: "fC", status: "expired", lastDay: daysAgo(40), ago: 3},
    {id: "fD", status: "rejected", lastDay: today, ago: 4},
    {id: "fE", status: "pending", lastDay: today, ago: 0},
    {id: "fF", status: "review", lastDay: today, ago: 400},
  ];
  for (const f of friends) {
    await db.collection("users").doc(f.id).set({name: f.id, role: "user", activity: {lastDay: f.lastDay, days: 3}});
    await db.collection("referrals").doc(f.id).set({
      inviterId: inviter.uid, inviteeId: f.id, inviteeName: f.id, status: f.status, code: "QWE789",
      createdAt: Timestamp.fromMillis(Date.now() - f.ago * 86_400_000),
    });
  }
  await db.collection("users").doc("fG").set({name: "fG", role: "user", activity: {lastDay: today}});
  await db.collection("referrals").doc("fG").set({
    inviterId: other.uid, inviteeId: "fG", inviteeName: "fG", status: "qualified", createdAt: Timestamp.now(),
  });

  // One user's stats
  ok((await call("adminInviteStats", inviter.token, {uid: inviter.uid})).error?.status === "PERMISSION_DENIED",
    "only admins see a user's invite counts");
  const stats = await call("adminInviteStats", admin.token, {uid: inviter.uid});
  const c = stats.result?.counts ?? {};
  ok(stats.status === 200 && stats.result.code === "QWE789", "admin gets the user's invite code");
  ok(c.qrOpens === 2 && c.linkOpens === 2, "QR scans and link opens are counted apart");
  ok(c.joined === 6 && c.active === 2 && c.inactive === 2 && c.waiting === 2, "invites are split into active, inactive and waiting");
  ok(c.stillUsing === 1, "only active friends who opened the app lately count as still using");
  const list = stats.result?.friends ?? [];
  ok(list.length === 6 && list[0].inviteeId === "fE" && list.at(-1).inviteeId === "fF", "invited friends come newest first");
  ok(list.find((f) => f.inviteeId === "fA")?.lastActiveDay === today, "each friend shows the last day in the app");
  ok((await call("adminInviteStats", admin.token, {uid: "../x"})).error?.status === "INVALID_ARGUMENT", "a broken user ID is refused");

  // The still-using window comes from the points settings
  await db.collection("config").doc("points").set({stillUsingDays: 90});
  const wider = await call("adminInviteStats", admin.token, {uid: inviter.uid});
  ok(wider.result?.counts?.stillUsing === 2 && wider.result?.stillUsingDays === 90, "the still-using days setting is used");
  await db.collection("config").doc("points").delete();

  // Ranking
  ok((await call("adminInviteRanking", inviter.token, {})).error?.status === "PERMISSION_DENIED", "only admins see the ranking");
  const all = await call("adminInviteRanking", admin.token, {sort: "active"});
  const t = all.result?.totals ?? {};
  ok(all.status === 200 && all.result.inviters === 2, "all time: both inviters are listed");
  ok(t.joined === 7 && t.active === 3 && t.qrOpens === 2 && t.linkOpens === 3, "totals for the whole app add up");
  ok(all.result.rows[0].uid === inviter.uid && all.result.rows[0].name === "Marta Rossi" && all.result.rows[0].code === "QWE789",
    "the ranking shows name and code, most active first");
  const byTotal = await call("adminInviteRanking", admin.token, {sort: "joined"});
  ok(byTotal.result?.rows?.[0]?.joined === 6, "the ranking can be sorted by total invites");
  const recent = await call("adminInviteRanking", admin.token, {from: daysAgo(30), to: today});
  ok(recent.result?.rows?.find((r) => r.uid === inviter.uid)?.joined === 5, "a period leaves out older invites");
  const past = await call("adminInviteRanking", admin.token, {from: "2020-01-01", to: "2020-01-31"});
  ok(past.status === 200 && past.result.inviters === 0, "a period with nothing in it is empty");
  ok((await call("adminInviteRanking", admin.token, {from: today, to: daysAgo(3)})).error?.status === "INVALID_ARGUMENT",
    "a period that ends before it starts is refused");
  ok((await call("adminInviteRanking", admin.token, {from: "2026-02-30", to: "2026-03-02"})).error?.status === "INVALID_ARGUMENT",
    "an impossible date is refused");

  // Deleting the account removes its open counts
  const del = await call("deleteAccount", other.token, {});
  ok(del.status === 200 && (await db.collection("inviteOpens").where("uid", "==", other.uid).get()).empty,
    "deleting an account deletes its open counts");

  console.log(failures ? `\n${failures} check(s) failed` : "\nAll invite tracking checks passed");
  process.exit(failures ? 1 : 0);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
