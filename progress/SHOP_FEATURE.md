# CodaMi: Shop (request 18)

Request from the client (Thu 29 Oct 2026): a pet products shop inside the app, with brand partnerships, dropshipping, affiliate links, commissions and sponsored products, all managed from the admin panel. Modular, no dependence on one provider, start simple and grow into a multi-brand marketplace without a redesign.

_Last updated: Fri 30 Oct 2026 (Phase 1 day 2 built; rules to deploy)_

**Go-ahead (Thu 29 Oct):** start with Phase 1. Added by us: a **Shop on/off switch** in the admin panel (`config/shop.enabled`). Off: users don't see the Shop tab; admins can still prepare the catalogue. On: the shop shows for everyone at once, no new build. Starts off.

---

## Plan sent to the client

**In short**
We build the shop ourselves, inside CodaMi, connected to the existing admin panel. The catalogue, customers, orders, prices and business rules live in CodaMi's own database. Outside services (payments, suppliers, affiliate networks, couriers) plug in as separate connectors that can be added, turned off or replaced without touching the rest of the shop. We start with a simple shop and grow it in three phases on the same foundation.

**Architecture (the technical requirement)**
- **Our core:** products, categories, brands, suppliers, carts, orders, customers, prices, margins, commissions, campaigns and reports. All in our database, exportable at any time.
- **Replaceable connectors:** every outside service talks to the core in the same standard way. A new supplier, payment provider or affiliate network means adding one connector and switching it on in the admin panel. Changing provider means a new connector; the data stays.
- **A sales model on every product:** own stock, brand partner, dropshipping or affiliate link. Users see one shop; only what happens after "Buy" changes. "Sponsored" can be added on top of any product.
- **One payment, several suppliers:** a cart with products from two suppliers is paid once, then split into one shipment per supplier, each with its own status and tracking. This is what lets the shop become a multi-brand marketplace later.
- **Commission saved on every order line:** reports stay correct even after margins or commissions change.
- **Prices and payments checked on the server:** a modified app can't change a price or mark an order as paid.
- Built like the petitions: the app reaches the shop through one interface, so even the database can be moved later.

**Connected to the existing app**
- Same CodaMi account, no new sign-up.
- Products for the user's own pets shown first (the app already knows if they have a dog, a cat…).
- Order updates through the existing notifications, in the user's language. Order emails use the same email service still open for emergency alerts.
- "Help with this order" opens a support request with the order attached.
- Shop screens in all 10 languages.

**Product categories**
- The eight listed categories as the starting list, with sub-categories (for example Food → Dry, Wet, Treats) and a filter by animal.
- Managed in the admin panel, not fixed in the app.

**Sales models**
1. **Brand partnerships:** each brand gets its own page and products. Per brand we set whether CodaMi buys and resells (our margin) or the brand ships and pays us a commission.
2. **Dropshipping:** the supplier's products are in our catalogue with their cost price; we set the selling price or margin. A paid order goes to the supplier by automatic email at first, then through the supplier's API or product files where they offer them. The supplier ships directly; the tracking number is added to the order.
3. **Affiliate marketing:** the product shows a "Buy on [partner]" button that opens the partner's site through our affiliate link. Clicks are counted in the admin panel. The sale happens on the partner's site, so commissions come from the affiliate network's report (imported from a file at first, automatically where the network allows). Examples: Amazon, Awin.
4. **Commission-based sales:** commission rules per brand, supplier, category or single product, as a percentage or a fixed amount. The most specific rule wins.
5. **Sponsored products:** sponsored places (top of the shop, top of a category, in search results) with start and end dates, always with a "Sponsored" label (required by law). Views, clicks and sales counted per campaign, to report to the partner.

**Payments**
- Physical products are paid through a payment provider, not Apple or Google in-app payments. Both stores require this for physical goods, and there is no 15–30% store fee.
- Start with **Stripe**: cards, Apple Pay, Google Pay, and methods like PayPal or Klarna turned on from the Stripe dashboard. Card details never reach our servers.
- The Stripe account is in CodaMi's name, so the money and payment data belong to CodaMi. Other providers (PayPal direct, Nexi…) can be added later as connectors.
- Full and partial refunds from the admin panel.

**Shipping**
- Set in the admin panel: standard or express, price by zone (for example Italy, islands, EU), free above an amount, rules per supplier, delivery time shown to the user.
- Each shipment has a courier and tracking number; the user gets a tracking link and a notification at each step.

**Admin panel** (no code changes for any of this)
- **Products:** add, edit, remove; photos, descriptions, variants (size, flavour, colour), price, discount price, stock or availability, on/off.
- **Categories, brands and suppliers:** add, edit, turn on/off.
- **Supplier settings:** how orders reach them (email, file, API), cost prices, margins, their shipping rules.
- **Margins, commissions and affiliate links.**
- **Shipping:** methods, prices, zones, delivery times.
- **Orders:** search, filters, statuses, tracking, cancellations, refunds, returns.
- **Campaigns:** discount codes, discounts on a category or brand for set dates, sponsored places.
- **On/off switches:** any product, brand, supplier, a whole sales model (for example all affiliate products), or the whole shop.
- **Reports:** sales, revenue, margin, commissions by period, brand, supplier and category; best sellers; affiliate clicks; sponsored results; export to Excel (CSV).
- **Shop manager role:** runs the shop without access to users or emergencies (like the support role).
- **On the computer too (recommended):** the admin panel also opens in a browser, with the same login, because managing hundreds of products and photos from a phone is slow.

**Phase 1: a working shop**
- Shop tab in the app, categories, search, filters, product page, cart, Stripe checkout, My orders with tracking.
- Admin: products, categories, brands, suppliers, prices, discounts, availability, shipping, orders, refunds, on/off switches, basic reports.
- All five sales models in their simple form: own stock and brand products, dropshipping with orders sent by email, affiliate products with click counting, commissions per order line, sponsored places with the label.

**Phase 2: automation**
- Supplier imports: product files or links (CSV/XML) with daily price and stock updates; orders and tracking through supplier APIs where they exist.
- Discount codes and campaigns, full commission reports, import of affiliate commission reports.
- Bulk import and export of products in the computer admin panel.
- A search engine for a large catalogue (open-source option, no lock-in).
- Optional: CodaMi points as a shop discount (Italian prize promotion rules to check first).

**Phase 3: multi-brand marketplace**
- Partner portal: brands and suppliers get their own login to manage their products and see their orders and sales.
- Split payments: the customer pays once, each partner receives their share automatically and CodaMi keeps its commission (for example Stripe Connect, added as a connector).
- Payout reports and invoices per partner, returns per partner, more payment providers and integrations.

Nothing from Phase 1 is rebuilt for Phase 2 or 3: split orders, connectors, sales models and commissions are in the foundation from day one.

**Important before selling** (to confirm with an accountant or lawyer)
- CodaMi becomes a seller: company and VAT number for Stripe and invoices, terms of sale, 14-day right of withdrawal, 2-year legal guarantee, prices with VAT and shipping shown before payment. Privacy policy and store forms updated (addresses, orders, payments).
- Product safety: EU rules (GPSR, since December 2024) require safety information and an EU responsible company for each product sold online. Pet food pages must show the label information (ingredients, analysis). Starting with EU suppliers avoids most of this risk, plus customs and long deliveries.
- Sponsored products and affiliate links clearly labelled; each affiliate programme's own rules checked before adding it.
- Phase 3 (collecting money for other sellers) has extra payment rules; a provider like Stripe Connect covers most of them.

---

## Questions sent to the client

- [x] OK to start with Phase 1 as described? **Yes (Thu 29 Oct)**
- [ ] Countries we sell to at the start (Italy only?)
- [ ] Company name and VAT number for the shop; Stripe account in CodaMi's name
- [ ] First brands, suppliers or affiliate programmes (otherwise sample products for building and testing)
- [ ] Languages for product texts (suggested: Italian and English, the others fall back to English)
- [ ] Shop as a new tab in the bottom bar (Home, Pets, Videos, Shop, Profile)
- [ ] Admin panel on the computer as well
- [ ] Who prepares the terms of sale and the return policy

---

## Phase 1 progress

**Day 1 (Thu 29 Oct): foundation**
- [x] Shop on/off switch in Admin → More → Shop (`config/shop.enabled`, starts off), with a confirmation each way
- [x] Switches for each sales model (turning one off hides its products)
- [x] Admin catalogue: categories (with sub-categories, icon, position, starting set of 8), brands (logo, website), suppliers (contact, how orders reach them, notes, admin only), products (up to 6 photos, description, category, animals, sales model, brand, supplier, affiliate link and partner, price, price before discount, availability, visible switch)
- [x] Hiding a category, brand or supplier hides its products; deleting one still in use is refused
- [x] Shop tab in the bottom bar, only while the shop is on: search, filter by animal, categories and sub-categories, product grid with the user's own pets first, product page with photos, price and discount, availability, description
- [x] Affiliate products: "Buy on {partner}" opens the partner link, with the commission notice; other products show "Add to cart" (turned on with the cart)
- [x] Preview the shop from the admin side while it is off
- [x] Firestore and Storage rules: users read the catalogue only while the shop is on and only active items; suppliers admin only; only admins write; field checks
- [x] Labels in 10 languages; 8 app tests (`test/shop_test.dart`) and 76 emulator checks (`emulator_tests/shop.cjs`)
- [x] Deploy: `firebase deploy --only firestore:rules,storage` (Thu 29 Oct)
- [ ] Phone test with `TEST_SCENARIO_SHOP_2026-10-29.md`: add categories, a brand, a supplier and products with photos; preview; open the shop; check the tab as a user; close it again

**Day 2 (Fri 30 Oct): before payment**
- [x] Cart: add from the product page, quantity stepper, remove, empty; saved on the phone per account; cart icon with a count in the Shop tab and on the product page; products that are gone, hidden, out of stock or affiliate are flagged and left out of the total
- [x] Shipping settings (Admin → Shop → Shipping): zones (starting set Italy, Sicily and Sardinia, EU off), methods (Standard 3–5 days €5.90 / €9.90 / €14.90, free above €49; Express 1–2 days €9.90 / €14.90), price per zone, empty = not offered, free above an amount, on/off; saved in `config/shipping`
- [x] Cart totals: ship-to zone, method with delivery time, subtotal, shipping, total, "VAT included", "Add €x more for free shipping"; the Checkout button is shown but off until Stripe
- [x] Cost price and margin in the product form (admin only, `productCosts/{id}`), margin shown as € and %
- [x] Affiliate clicks: each "Buy on…" tap saved in `affiliateClicks`; count per product in the product form, last 30 days in the Shop admin
- [x] Sponsored products: switch with optional start and end dates; shown first and labelled "Sponsored" on cards and the product page
- [x] 52 labels in 10 languages; 4 new app tests (108 in total), 21 new emulator checks (97 shop checks)
- [ ] Deploy: `firebase deploy --only firestore:rules`
- [ ] Phone test: day 2 part of `TEST_SCENARIO_SHOP_2026-10-29.md`

**Next days**
- [ ] Stripe checkout (needs the Stripe account), orders, My orders, refunds
- [ ] Dropshipping orders by email, commissions per order line
- [ ] Basic reports, shop manager role, admin on the computer

---

## Technical notes (ours)

- Code in `lib/features/shop/`: `domain/shop.dart` (models, checks, filters, no Firebase) and `domain/shop_repository.dart` (interface), `data/firestore_shop_repository.dart` (the only Firebase part). Server code will go in `functions/src/shop/`.
- Built Thu 29 Oct: `config/shop` {enabled, disabledSuppliers, disabledModels, updatedBy, updatedAt}; `shopCategories` {name, parentId, icon, order, active}; `brands` {name, description, website, logoUrl/logoPath, active}; `suppliers` {name, contactName, email, phone, website, orderMethod, notes, active}; `products` {name, description, categoryId, brandId, supplierId, salesModel, animals, priceCents, compareAtCents, availability, affiliateUrl, partnerName, active, images[{url, path}], created/updated by/at}. Prices in cents. Photos `shop/products/{id}/image_<time>.<ext>`, logos `shop/brands/{id}/logo_<time>.<ext>`.
- A supplier's on/off is copied into `config/shop.disabledSuppliers`, because users can't read suppliers. Users' lists are filtered in the app (`visibleToUsers`): the rules only let them read active items while the shop is on.
- Day 2: `config/shipping` {zones[{id, name, active}], methods[{id, name, deliveryTime, prices{zoneId: cents}, freeAboveCents, active}]}; `productCosts/{productId}` {costCents}; `affiliateClicks/{auto}` {productId, partner, uid, at}; products gain `sponsored`, `sponsorStart`, `sponsorEnd` (dates saved at midnight, the campaign runs to the end of the end day). Cart in SharedPreferences `shop_cart_<uid>`. Logic in `domain/checkout.dart`. Variants (size, flavour) are not in the model yet.
- No composite index needed: users query `active == true` (limit 500) and sort in the app; a search engine comes in Phase 2.
- Collections: `shopCategories`, `brands`, `suppliers`, `products/{id}` with variants, `shippingMethods`, `campaigns`, `sponsoredSlots`, `commissionRules`, `orders/{id}` with `shipments/{id}` per supplier, `refunds`, `affiliateClicks`, `config/shop` (switches).
- Each order line keeps a snapshot: price, cost, commission, supplier and sales model at the time of sale.
- Checkout only on the server: a callable re-reads prices, shipping and discounts and creates the Stripe PaymentIntent; a Stripe webhook marks the order paid. Rules stop the app writing prices or payment status.
- Server connector interfaces: `PaymentProvider` (create payment, refund, webhook), `SupplierConnector` (send order, import catalogue, fetch tracking; first one sends email through the Trigger Email `mail` collection), `AffiliateNetwork` (build link, import commissions).
- App: `flutter_stripe` Payment Sheet. Apple Pay needs the Apple Developer account (still waiting).
- Computer admin: Flutter web build on Firebase Hosting, admin only; check that the plugins used by the admin screens work on web.
- Search: Firestore keywords at first; Typesense or Meilisearch later.
- Stripe secret key and webhook secret in Secret Manager.
