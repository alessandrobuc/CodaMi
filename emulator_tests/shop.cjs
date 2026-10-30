// Shop: the on/off switch, who can read and write the catalogue, field checks and image rules. Run with emulator_tests/README.md.
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
const docName = (p) => `projects/${PROJECT}/databases/(default)/documents/${p}`;

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

async function write(token, p, data, {create = false, stamps = ["updatedAt"]} = {}) {
  const r = await fetch(`${FS}:commit`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({writes: [{
      update: {name: docName(p), fields: fields(data)},
      ...(create ? {currentDocument: {exists: false}} : {}),
      updateTransforms: stamps.map((fieldPath) => ({fieldPath, setToServerValue: "REQUEST_TIME"})),
    }]}),
  });
  return r.status;
}
async function get(token, p) {
  return (await fetch(`${FS}/${p}`, {headers: {Authorization: `Bearer ${token}`}})).status;
}
async function remove(token, p) {
  return (await fetch(`${FS}/${p}`, {method: "DELETE", headers: {Authorization: `Bearer ${token}`}})).status;
}
async function listActive(token, collectionId) {
  const r = await fetch(`${FS}:runQuery`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({structuredQuery: {
      from: [{collectionId}],
      where: {fieldFilter: {field: {fieldPath: "active"}, op: "EQUAL", value: {booleanValue: true}}},
    }}),
  });
  const body = await r.json();
  return {status: r.status, count: Array.isArray(body) ? body.filter((x) => x.document).length : 0};
}
async function listAll(token, collectionId) {
  const r = await fetch(`${FS}:runQuery`, {
    method: "POST",
    headers: {"Content-Type": "application/json", "Authorization": `Bearer ${token}`},
    body: JSON.stringify({structuredQuery: {from: [{collectionId}]}}),
  });
  return r.status;
}

async function upload(token, p, contentType = "image/jpeg", size = 1000) {
  const boundary = "shoptest";
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

const config = (uid, extra = {}) => ({enabled: false, disabledSuppliers: [], disabledModels: [], updatedBy: uid, ...extra});
const category = (uid, extra = {}) => ({name: "Pet food", parentId: "", icon: "food", order: 10, active: true, updatedBy: uid, ...extra});
const brand = (uid, extra = {}) => ({name: "Acme Pets", description: "", website: "https://acme.example.com", active: true, updatedBy: uid, ...extra});
const supplier = (uid, extra = {}) => ({
  name: "EU Pet Supply", contactName: "Anna", email: "orders@eupets.example.com", phone: "+39 000",
  website: "", orderMethod: "email", notes: "Net 30", active: true, updatedBy: uid, ...extra,
});
const product = (uid, extra = {}) => ({
  name: "Grain-free dry food 2 kg", description: "For adult dogs.", categoryId: "food", brandId: "acme",
  supplierId: "", salesModel: "ownStock", animals: ["dog"], priceCents: 1990, compareAtCents: null,
  availability: "inStock", affiliateUrl: "", partnerName: "", active: true, images: [],
  createdBy: uid, updatedBy: uid, ...extra,
});

(async () => {
  const admin = await signUp("admin@shop.test");
  const support = await signUp("support@shop.test");
  const user = await signUp("user@shop.test");
  await db.collection("users").doc(admin.uid).set({name: "Admin", role: "admin"});
  await db.collection("users").doc(support.uid).set({name: "Support", role: "support"});
  await db.collection("users").doc(user.uid).set({name: "User", role: "user"});
  const create = {create: true, stamps: ["createdAt", "updatedAt"]};

  // Catalogue before the switch exists
  ok(await write(admin.token, "shopCategories/food", category(admin.uid)) === 200, "admin adds a category");
  ok(await write(admin.token, "brands/acme", brand(admin.uid)) === 200, "admin adds a brand");
  ok(await write(admin.token, "products/p1", product(admin.uid), create) === 200, "admin adds a product");
  ok(await get(admin.token, "products/p1") === 200, "admin reads products before the switch exists");
  ok(await get(user.token, "products/p1") === 403, "users can't read products while config/shop doesn't exist");

  // The switch
  ok(await write(user.token, "config/shop", config(user.uid, {enabled: true})) === 403, "users can't open the shop");
  ok(await write(support.token, "config/shop", config(support.uid, {enabled: true})) === 403, "support staff can't open the shop");
  ok(await write(admin.token, "config/shop", config(admin.uid, {extra: 1})) === 403, "unknown config fields refused");
  ok(await write(admin.token, "config/shop", config(admin.uid, {disabledModels: ["crypto"]})) === 403, "unknown sales model refused");
  ok(await write(admin.token, "config/shop", config(user.uid)) === 403, "config must be saved in the admin's own name");
  ok(await write(admin.token, "config/shop", config(admin.uid)) === 200, "admin saves the shop as off");
  ok(await get(user.token, "config/shop") === 200, "users can read the switch");
  ok(await get(user.token, "products/p1") === 403, "users can't read products while the shop is off");
  ok((await listActive(user.token, "products")).status === 403, "users can't list products while the shop is off");
  ok(await get(user.token, "shopCategories/food") === 403, "users can't read categories while the shop is off");
  ok((await listActive(admin.token, "products")).count === 1, "admin previews the shop while it's off");

  ok(await write(admin.token, "config/shop", config(admin.uid, {enabled: true})) === 200, "admin opens the shop");
  ok(await get(user.token, "products/p1") === 200, "users read an active product once the shop is on");
  ok((await listActive(user.token, "products")).count === 1, "users list active products");
  ok((await listActive(user.token, "shopCategories")).count === 1, "users list active categories");
  ok((await listActive(user.token, "brands")).count === 1, "users list active brands");
  ok(await listAll(user.token, "products") === 403, "users can't list hidden products too");

  // Hidden items
  ok(await write(admin.token, "products/p2", product(admin.uid, {active: false}), create) === 200, "admin adds a hidden product");
  ok(await get(user.token, "products/p2") === 403, "users can't read a hidden product");
  ok(await listAll(admin.token, "products") === 200, "admin lists every product");

  // Who can write
  ok(await write(user.token, "products/u1", product(user.uid), create) === 403, "users can't add products");
  ok(await write(support.token, "products/s1", product(support.uid), create) === 403, "support staff can't add products");
  ok(await write(admin.token, "products/p3", product(user.uid), create) === 403, "admin can't add a product in someone else's name");
  ok(await write(user.token, "shopCategories/c2", category(user.uid)) === 403, "users can't add categories");
  ok(await write(user.token, "brands/b2", brand(user.uid)) === 403, "users can't add brands");

  // Product field checks
  const bad = async (extra, msg) => ok(await write(admin.token, `products/bad${Math.random().toString(36).slice(2)}`, product(admin.uid, extra), create) === 403, msg);
  await bad({name: "  "}, "empty name refused");
  await bad({categoryId: ""}, "product without category refused");
  await bad({salesModel: "barter"}, "unknown sales model refused");
  await bad({priceCents: null}, "non-affiliate product without a price refused");
  await bad({priceCents: 0}, "zero price refused");
  await bad({priceCents: 12.5}, "price that isn't whole cents refused");
  await bad({compareAtCents: 1000}, "discount price below the price refused");
  await bad({animals: ["dog", "horse"]}, "unknown animal refused");
  await bad({availability: "lots"}, "unknown availability refused");
  await bad({images: [1, 2, 3, 4, 5, 6, 7]}, "more than 6 images refused");
  await bad({costCents: 900}, "extra fields such as a cost price refused");
  await bad({salesModel: "affiliate", affiliateUrl: "http://amazon.it/x", partnerName: "Amazon"}, "affiliate http link refused");
  await bad({salesModel: "affiliate", affiliateUrl: "https://amazon.it/x", partnerName: ""}, "affiliate without partner refused");
  await bad({salesModel: "affiliate", affiliateUrl: "https://amazon.it/x", partnerName: "Amazon", supplierId: "s1"}, "affiliate with a supplier refused");
  ok(await write(admin.token, "products/aff", product(admin.uid, {
    salesModel: "affiliate", affiliateUrl: "https://www.amazon.it/dp/B000?tag=codami-21", partnerName: "Amazon", priceCents: null,
  }), create) === 200, "affiliate product without a price saved");
  ok(await write(admin.token, "products/sale", product(admin.uid, {compareAtCents: 2490}), create) === 200, "product with a discount saved");
  ok(await write(admin.token, "products/stamp", product(admin.uid), {create: true, stamps: ["createdAt"]}) === 403, "updatedAt must be the server time");
  const p1Created = (await db.collection("products").doc("p1").get()).get("createdAt").toDate();
  ok(await write(admin.token, "products/p1", {...product(admin.uid, {priceCents: 1790}), createdAt: p1Created}) === 200, "admin changes the price");
  ok(await write(admin.token, "products/p1", product(admin.uid), {stamps: ["updatedAt", "createdAt"]}) === 403, "createdAt can't be changed");

  // Categories and brands
  ok(await write(admin.token, "shopCategories/x", category(admin.uid, {icon: "rocket"})) === 403, "unknown category icon refused");
  ok(await write(admin.token, "shopCategories/x", category(admin.uid, {order: -1})) === 403, "negative position refused");
  ok(await write(admin.token, "brands/x", brand(admin.uid, {website: "javascript:alert(1)"})) === 403, "brand script link refused");
  ok(await write(admin.token, "brands/acme", brand(admin.uid, {logoUrl: "https://x/l.png", logoPath: "shop/brands/other/logo_1.png"})) === 403,
    "logo from another brand's folder refused");
  ok(await write(admin.token, "brands/acme", brand(admin.uid, {logoUrl: "https://x/l.png", logoPath: "shop/brands/acme/logo_1.png"})) === 200,
    "brand logo saved");
  ok(await write(admin.token, "brands/off", brand(admin.uid, {active: false})) === 200, "admin adds a hidden brand");
  ok(await get(user.token, "brands/off") === 403, "users can't read a hidden brand");

  // Suppliers: admin only
  ok(await write(admin.token, "suppliers/s1", supplier(admin.uid)) === 200, "admin adds a supplier");
  ok(await get(user.token, "suppliers/s1") === 403, "users can't read suppliers");
  ok(await get(support.token, "suppliers/s1") === 403, "support staff can't read suppliers");
  ok(await listAll(user.token, "suppliers") === 403, "users can't list suppliers");
  ok(await write(admin.token, "suppliers/s2", supplier(admin.uid, {email: "not-an-email"})) === 403, "automatic email without a valid address refused");
  ok(await write(admin.token, "suppliers/s2", supplier(admin.uid, {email: "", orderMethod: "manual"})) === 200, "manual supplier without email saved");
  ok(await write(admin.token, "suppliers/s2", supplier(admin.uid, {orderMethod: "fax"})) === 403, "unknown order method refused");
  ok(await write(admin.token, "config/shop", config(admin.uid, {enabled: true, disabledSuppliers: ["s2"]})) === 200, "supplier switched off in the config");

  // Images
  ok(await upload(admin.token, "shop/products/p1/image_1.jpg") === 200, "admin uploads a product photo");
  ok(await upload(admin.token, "shop/brands/acme/logo_1.png", "image/png") === 200, "admin uploads a brand logo");
  ok(await upload(user.token, "shop/products/p1/image_2.jpg") === 403, "users can't upload product photos");
  ok(await upload(admin.token, "shop/products/p1/logo_3.jpg") === 403, "wrong file name refused");
  ok(await upload(admin.token, "shop/orders/p1/image_4.jpg") === 403, "other shop folders refused");
  ok(await upload(admin.token, "shop/products/p1/image_5.jpg", "text/html") === 403, "non-images refused");
  ok(await upload(admin.token, "shop/products/p1/image_6.jpg", "image/jpeg", 5 * 1024 * 1024 + 1) === 403, "photos over 5 MB refused");

  // Delete
  ok(await remove(user.token, "products/p1") === 403, "users can't delete products");
  ok(await remove(admin.token, "products/p2") === 200, "admin deletes a product");
  ok(await remove(admin.token, "suppliers/s2") === 200, "admin deletes a supplier");

  // Sponsored products
  const day = new Date("2026-11-01T00:00:00Z");
  ok(await write(admin.token, "products/sp", product(admin.uid, {sponsored: true, sponsorStart: day, sponsorEnd: null}), create) === 200,
    "sponsored product with a start date saved");
  await bad({sponsored: "yes"}, "sponsored must be true or false");
  await bad({sponsored: true, sponsorEnd: "tomorrow"}, "sponsor end must be a date");

  // Cost prices
  const cost = (uid, extra = {}) => ({costCents: 990, updatedBy: uid, ...extra});
  ok(await write(admin.token, "productCosts/p1", cost(admin.uid)) === 200, "admin saves a cost price");
  ok(await get(user.token, "productCosts/p1") === 403, "users can't read cost prices");
  ok(await get(support.token, "productCosts/p1") === 403, "support staff can't read cost prices");
  ok(await listAll(user.token, "productCosts") === 403, "users can't list cost prices");
  ok(await write(user.token, "productCosts/p1", cost(user.uid)) === 403, "users can't write cost prices");
  ok(await write(admin.token, "productCosts/p1", cost(admin.uid, {costCents: -5})) === 403, "negative cost refused");
  ok(await write(admin.token, "productCosts/p1", cost(admin.uid, {note: "x"})) === 403, "extra cost fields refused");

  // Shipping settings
  const shipping = (uid, extra = {}) => ({
    zones: [{id: "it", name: "Italy", active: true}],
    methods: [{id: "standard", name: "Standard", deliveryTime: "3-5 days", prices: {it: 590}, freeAboveCents: 4900, active: true}],
    updatedBy: uid, ...extra,
  });
  ok(await write(admin.token, "config/shipping", shipping(admin.uid)) === 200, "admin saves shipping settings");
  ok(await get(user.token, "config/shipping") === 200, "users read shipping settings");
  ok(await write(user.token, "config/shipping", shipping(user.uid)) === 403, "users can't change shipping");
  ok(await write(admin.token, "config/shipping", shipping(admin.uid, {coupon: 1})) === 403, "extra shipping fields refused");

  // Affiliate clicks
  const click = (uid, extra = {}) => ({productId: "aff", partner: "Amazon", uid, ...extra});
  const clickStamp = {stamps: ["at"]};
  ok(await write(user.token, "affiliateClicks/c1", click(user.uid), clickStamp) === 200, "users record a click");
  ok(await write(user.token, "affiliateClicks/c2", click(admin.uid), clickStamp) === 403, "a click can't be saved for someone else");
  ok(await write(user.token, "affiliateClicks/c3", click(user.uid), {stamps: []}) === 403, "a click needs the server time");
  ok(await write(user.token, "affiliateClicks/c4", click(user.uid, {amount: 99}), clickStamp) === 403, "extra click fields refused");
  ok(await get(user.token, "affiliateClicks/c1") === 403, "users can't read clicks");
  ok(await listAll(admin.token, "affiliateClicks") === 200, "admin reads clicks");
  ok(await remove(user.token, "affiliateClicks/c1") === 403, "users can't delete clicks");

  // Switching off again
  ok(await write(admin.token, "config/shop", config(admin.uid, {enabled: false})) === 200, "admin closes the shop");
  ok(await get(user.token, "products/p1") === 403, "users lose access as soon as the shop is closed");

  console.log(failures ? `\n${failures} check(s) failed` : "\nAll shop checks passed");
  process.exit(failures ? 1 : 0);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
