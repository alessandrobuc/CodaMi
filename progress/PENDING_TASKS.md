# CodaMi: Pending Tasks

One list of everything still open, so work can pick up from here. Tick items off and move them to **Done recently** when finished. Details live in the linked files.

_Last updated: Wed 4 Nov 2026 (phase 5: AI breed scanner online; heat calendar and pet sitting built, to deploy and test)_

---

## 1. Testing now

- [ ] **Pet sitting (Wed 4 Nov):** `firebase deploy --only functions,firestore:rules,firestore:indexes` (6 new functions, rules, 1 new index: wait until it's "Enabled"); new build on two phones; test with `TEST_SCENARIO_SITTING_2026-11-04.md`; then Admin → More → Pet sitting → Show to users

- [ ] **Heat calendar (Wed 4 Nov):** `firebase deploy --only functions,firestore:rules` (new `heatReminderSweep`, rules for `heatCycles`, `heatReminders`, `config/heat`); new build; phone test with `TEST_SCENARIO_HEAT_2026-11-04.md`; then Admin → More → Heat calendar → Show to users

- [ ] **Scanner model list (Wed 4 Nov):** the first deploy of `scannerModels` left out the public invoker, so the app got "Something went wrong" (log: "The request was not authorized to invoke this service"). Fixed in the code (`invoker: "public"`); run `firebase deploy --only functions:scannerModels`, then Admin → Breed scanner → AI model should show the list. If not: Cloud Run → scannermodels → Security → Allow public access (the function still checks for an admin)
- [ ] **AI breed scanner (Wed 4 Nov):** ~~enable Vertex AI API~~ done; ~~deploy functions and rules~~ done; first scan tested and working; phone test with `TEST_SCENARIO_SCANNER_2026-11-04.md` (dog, cat, mix, other animal, blurry, no animal; Italian and Arabic); then Admin → More → Breed scanner → Show to users. If scans fail with a permission error, give the functions' service account the "Vertex AI User" role

- [x] **Deploy (phase 4 Mon 2 Nov + invite tracking Tue 3 Nov):** `firebase deploy --only functions,hosting,firestore:rules` (functions first: the invite page's `/api/invite-open` rewrite needs `trackInviteOpen`; also `adminInviteStats`, `adminInviteRanking`, `findWalkPlaces`, `walkPlaceDetails`; rules for `config/walks`, `config/donations` and the new `stillUsingDays`)
- [ ] **Google Cloud:** check that Places API (New) is enabled for the `PLACES_API_KEY` project (it already is for city search) and set a budget alert
- [x] **Phase 4 on the phone (tested Tue 3 Nov):** follow `TEST_SCENARIO_PHASE4_2026-11-02.md` (QR and flyer, invite page on Android and a computer, Places to walk, donation screens, and part 10: invite tracking)
- [ ] **Deploy (shop day 2, Fri 30 Oct):** `firebase deploy --only firestore:rules` (shipping settings, cost prices, affiliate clicks, sponsored fields; without it these can't be saved)
- [ ] **Shop day 2 on the phone:** follow part 11 of `TEST_SCENARIO_SHOP_2026-10-29.md` (shipping setup, cart, totals, cost and margin, affiliate clicks, sponsored)
- [x] **Deploy (shop, Thu 29 Oct):** rules and storage are live
- [ ] **Shop on the phone:** follow `TEST_SCENARIO_SHOP_2026-10-29.md`. Admin → More → Shop: add the starting categories, a brand with a logo, a supplier, a few products with photos (one affiliate, one with a discount); Preview the shop; open the shop and check the Shop tab as a user (search, animal filter, categories, product page, "Buy on…" opens the link); hide a brand and a supplier and check their products disappear; close the shop and check the tab disappears

- [ ] Emergency pins on the map (Fri 23 Oct): a red pin for each active emergency, tap it to see the card, tap the card to open the emergency; the pin disappears once it is resolved
- [x] **Deploy (petitions, Mon 26 Oct):** rules and index are live (the app reads and writes petitions on the real project). Check in Firestore → Indexes that the What's new index (published + code) is also there
- [x] **Petitions on the Oppo (Mon 26 Oct):** empty save refused, bad link refused, publishing without the four checks refused, saved and published on the live project; user: Home banner, Profile → Petitions, card, detail page, "View petition" opens the browser; "No longer available" hides the banner, shows a red badge and turns the button off; deleted. Fixed: red marks now clear while typing, long error text wraps
- [ ] Petitions: full phone test with `TEST_SCENARIO_PETITIONS_2026-10-26.md` (images and several petitions not tested yet)
- [ ] Reset the store rating test: it popped up on the Oppo, so the review days are probably still 0 (Admin → More → Points and rewards)
- [ ] **Deploy again (What's new paging):** `firebase deploy --only firestore:rules,firestore:indexes` (new `code` field and index for release notes); delete and re-add the 1.1.0 test notes (saved before `code` existed)
- [x] **Deploy (Fri 23 Oct build):** `firebase deploy --only firestore:rules,functions` (new `submitFeedback`, feedback and release notes rules, new points settings)
- [x] Admin side tested on the phone: add version, wrong / duplicate version refused, English required, publish, Feedback and reviews settings save, Feedback screen empty state
- [ ] Full real-phone test: follow `TEST_SCENARIO_2026-10-23.md`
- [ ] **What's new:** raise the version name in `pubspec.yaml` (for example `1.1.0+11`), write and publish the notes for 1.1.0 in Admin → More → What's new, install the update over the old app: the notes show once; Profile → What's new shows them again; a fresh install shows nothing
- [ ] **Feedback:** Profile → Send feedback, pick stars and send; the points show only after 5 days since sign-up (set "Days after sign-up before asking for feedback" to 0 to test), a second send the same day is refused; read it in Admin → More → Feedback
- [ ] **Review window:** only from a Play Store install; set the review days to 0 in Points and rewards to see it 25 seconds after opening the app on Home (Google may not show it every time; that's normal)
- [ ] Automatic invite code (Fri 23 Oct, needs the Play Store build): on phone B, uninstall CodaMi, open phone A's invite link (Profile → Invite friends → Share) or scan A's QR, install from the Play Store (closed testing), sign up and choose the city; the "Did a friend invite you?" screen should already show A's code with a note, then tap Use. Installing from a cable or APK can't test this (internal testing works too; uninstall the debug build first)

- [x] **Deploy (app updates, Tue 27 Oct):** rules are live (`config/appVersion`)
- [x] **App updates, admin side on the Oppo (Tue 27 Oct):** form checks, notes status (missing / draft / published), update sheet once per version with the notes, "Update now" opens Google Play, confirm dialog, "Update required" covers the app straight away
- [ ] **App updates:** full phone test and client video with `TEST_SCENARIO_APP_UPDATES_2026-10-27.md` (user side: banner, Profile row, required update as a user, undo from the Firebase console)

Fixes found while testing go here:

- Thu 29 Oct, new Shop look: check the Shop tab and product page on a small and a large phone (category cards, rows scroll sideways, thumbnails switch the photo, preview back button)
- Thu 29 Oct, form design: check the new text fields in Admin → Petitions and every Shop form (label above, no gap in the border, red errors)

- Tue 27 Oct, app updates on the Oppo: admins were locked out by "Update required" (could only be undone in the Firebase console), now a "Continue as admin" button for admins only, until the app is closed; the keyboard stayed open over the "Update required" screen, now closed; red errors in App updates now clear while typing

- Thu 22 Oct, emulator test as a support account: dashboard card, Reported tabs (AI photos / User reports) and Emergencies list work with no errors in the log. Fixed: emergency filter chips were square, now rounded like the other tabs
- Thu 22 Oct, emulator test continued (support account): Tickets, request Chat / Details / Timeline and More work with no errors. Fixed: a large empty gap under the time cards in a request's Details (same fix on the new emergency, new report and video form screens), and a two-line user name and email in Details were misaligned. Also fixed: signing out of the admin side caused an error and might not set the operator offline (now set offline before signing out); support staff saw another operator's chat messages labelled "Admin" (now "Support team", only admins see names). Redesigned Admin → Emergency settings and Points and rewards (header, section cards, one row per setting, extra space at the end); emergency settings now show the defaults if they can't be loaded

## 2. Development left (ours)

- [ ] **Phase 5 (client request Tue 3 Nov, `PHASE_5_REQUESTS.md`):** go-ahead given Wed 4 Nov, no fixed order. Built so far: the AI breed scanner, the heat calendar, pet sitting.
  - [ ] 1. Feedback (request 7, about 1 day): current feedback entry → Google Play review; separate internal feedback (type, optional stars, text), asked after 10-20 uses of a feature, 2-week cooldown, admin list with filters and settings
  - [ ] 2. Social sharing (request 5, about 2 days): pop-up after a lost or found report, share image (photo, status, details, logo), public report page with link, WhatsApp / Facebook with link, Instagram / TikTok image only
  - [ ] 3. Share reminders (request 6, about half a day): first after X days, then weekly, off switch for users and admin, client's text in 10 languages
  - [ ] 4. Schedule and reminders (request 4, 2-3 days): notes, appointments, vet, vaccines, medicine, grooming, feeding; repeat, done, edit, delete; reminders with the app closed; private
  - [x] 5. Heat calendar (request 2): **built Wed 4 Nov** (pet page card, calendar, estimates, history, reminders by the daily sweep, admin settings). Left: deploy, phone test (`TEST_SCENARIO_HEAT_2026-11-04.md`), switch on for users
  - [x] 6. AI breed scanner (request 1): **built Wed 4 Nov** (Gemini on Vertex AI, admin settings, Profile and pet form, save breed to a pet). Left: enable Vertex AI API, deploy, phone test (`TEST_SCENARIO_SCANNER_2026-11-04.md`), switch on for users
  - [ ] 7. Titles and achievements (request 8, about 3 days): tags and titles with levels, page with locked titles, requirements and progress, title on the profile, donor titles by total donated (after donation payments)
  - [x] 8. Pet sitting (request 3): **built Wed 4 Nov**, all 3 parts (requests and sitter profiles, offers and booking, chat, both-sides confirmation, verified reviews, reports, blocking, admin moderation). Left: deploy, two-phone test (`TEST_SCENARIO_SITTING_2026-11-04.md`), switch on for users, terms text for the client
  - Already in the app: store review window and "Rate CodaMi", feedback card and admin list, text sharing of reports, push notifications, invite levels, donation screens (off)

- [ ] **Phase 4 (client request Mon 2 Nov, `PHASE_4_REQUESTS.md`):** built Mon 2 Nov (QR invites and flyer, Places to walk, donation screens switched off); left: store payments for donations once the client sets up the stores, "Scan QR" in the app if the client wants it
- [ ] **Shop Phase 1** (started Thu 29 Oct): day 1 and 2 built and committed (switch, catalogue, Shop tab, cart, shipping settings, cost and margin, affiliate clicks, sponsored); then Stripe payment, refunds, reports, shop manager role, computer admin (`SHOP_FEATURE.md`)
- [ ] **Next: shop day 3, the order system together with Stripe payment.** On hold until the client sends the Stripe keys and the other details (asked Mon 2 Nov); aimed for Tue 3 Nov:
  - [ ] Checkout screen: delivery details (name, address, postcode, city, province, phone, notes) saved for next time, order review
  - [ ] Orders created on the server: prices, availability and shipping checked again; each line keeps price, cost, margin and commission; split into one shipment per supplier; starts as "awaiting payment"
  - [ ] My orders for users: list, details, status timeline, tracking link, notification at each step
  - [ ] Admin → Shop → Orders: filters by status, details and address, status changes, courier and tracking per shipment, internal notes
  - [ ] Supplier order email for dropshipping (prepared in the `mail` collection, sent once the email service exists)
  - [ ] Rules, labels in 10 languages, tests, test scenario
- [ ] Turn on email alerts to organizations once the client sets up the email service (install the Firebase "Trigger Email" extension, then Admin → Emergency settings → Email alerts)
- [ ] Places key in Secret Manager: code done and secret set Tue 3 Nov, removed from `functions/.env`; left: `firebase deploy --only functions`, then check city / street / pin street name / walks (`LAUNCH_CHECKLIST.md` §1)
- [ ] Restrict the Places (server) key to Places API (New) + Geocoding API; the Maps Android and iOS keys are already restricted (`LAUNCH_CHECKLIST.md` §1)
- [ ] App Check, budget alert, API quotas, Crashlytics (`LAUNCH_CHECKLIST.md` §4)
- [ ] Privacy policy and Data safety: feedback (stars, comment, name, email, app version) readable by the team, install ID, exact emergency location shown to signed-in users, city position used for nearby alerts, support email (`LAUNCH_CHECKLIST.md` §6)
- [ ] Remove test data (reports, users including invite.test.cm1@codami.test, pets, test contacts) and retake store screenshots before release
- [ ] Raise the build number in `pubspec.yaml` and upload to Play closed testing
- [ ] Donations, if the client says yes (RevenueCat, store products)

- [ ] Petitions extras, only if the client asks: daily check of broken petition links, summaries in several languages, notification for new petitions, second-admin approval (`PETITIONS_FEATURE.md`)

## 3. Waiting for the client

Full list with context in `WAITING_FOR_CLIENT.md`.

- [ ] Support email address
- [ ] Apple Developer account access (APNs key, iPhone testing, Sign in with Apple, App Store)
- [ ] Donations: yes or no, amounts, store payment profiles, RevenueCat account
- [ ] Email service for emergency alerts to organizations (you are asking them)
- [ ] Real emergency contacts (name, type, phones, email, address, area, emergencies handled, hours, agreement to be listed)
- [ ] Support team, hours, languages and time limits; photos in support chat
- [ ] Videos with the rights to use them; YouTube links or not
- [ ] iPhone sound limits OK
- [ ] Review popup: client being told it's built without points for store reviews (points for in-app feedback instead)
- [ ] App Store ID once the app is on the App Store: goes in Admin → More → App updates (no new build); turns on the iPhone Update button and "Rate CodaMi"
- [ ] Native-speaker translation review (Italian first)
- [ ] Confirm the Android signing key backup
- [ ] Petitions: where in the app (Home banner + Profile for now), one or several languages for summaries, second-admin approval, notifications
- [ ] **Phase 5 (Tue 3 Nov):** go-ahead and order, pet sitting payments, AI scanner cost and limit, heat calendar animals, donor title amounts
- [ ] **Shop (request 18):** Phase 1 approved Thu 29 Oct; still need countries, company / VAT, Stripe account (or OK to use test keys), email service for order and supplier emails, first partners, product text languages, bottom-bar tab, computer admin, terms of sale (`SHOP_FEATURE.md`). Asked again Mon 2 Nov: Stripe, email service, countries, company / VAT

## 4. Later (after launch)

- [ ] Partner organization accounts that receive and answer emergencies in the app
- [ ] Points connected to the client's next features (new actions plug into `config/points`)
- [ ] Geohash queries for the report radius, alerts by distance for lost and found, auto-close old reports, smaller photos on upload (`LAUNCH_CHECKLIST.md` §7)

---

## Where things are

- `LAUNCH_CHECKLIST.md`: everything needed before publishing
- `WAITING_FOR_CLIENT.md`: questions sent to the client and their answers
- `PHASE_2_REQUESTS.md` to `PHASE_5_REQUESTS.md`: feature requests, decisions and what was built
- `WEEK_N_*.md`: weekly progress for the client
- `emulator_tests/README.md`: how to run the end-to-end emulator tests

## Done recently

- Wed 4 Nov: pet sitting look refreshed: gradient header with quick buttons and pill tabs, request cards with a calendar date badge and info pills, sitter cards with a rating badge and service icons, request form in 4 numbered step cards (pet tiles, service tiles, dates with the number of days) and more space under Publish, request page with a gradient header and a Published → Booked → Confirmed → Reviewed timeline, sitter profile with a banner, big avatar and stat tiles, chat with shaped bubbles and day labels, Mine overview tiles, admin overview tiles, reports coloured by type, and pill-style tabs with icons on the admin side too. 8 new texts in 10 languages. Needs a new build

- Wed 4 Nov: pet sitting (phase 5, request 3), all 3 parts: requests (city only), sitter profiles, offers, booking by the server, private chats with push and unread count, both-sides confirmation, verified reviews written by the server (new accounts wait, rating kept by the server), reports and blocks (the general report sheet and block dialog are now shared), Admin → More → Pet sitting (settings, reported, requests, sitters, reviews). 138 texts in 10 languages, 7 new app tests (151), 7 new server tests (100), 74 new emulator checks (458). The rules use `data['service']` because `service` is a reserved word. Not deployed yet

- Wed 4 Nov: heat calendar (phase 5, request 2): card on female pets' pages, calendar with recorded and expected heats, estimate from the pet's own cycles (typical per species until 2 records, duplicates ignored), history with edit / delete, "heat ended today", reminders 1/3/7/14 days before sent by the new daily `heatReminderSweep` in the owner's language, Admin → More → Heat calendar (instant switch, typical values), private rules, removed with the pet or the account. 48 texts in 10 languages, 11 new app tests (144), 4 new server tests (93), 32 new emulator checks (384). Not deployed yet

- Wed 4 Nov: scanner card at the top of the Pets tab ("Which breed is it?", only while the scanner is on), besides Profile and the pet form. Needs a new build
- Wed 4 Nov: Admin → Breed scanner: the "Show to users" switch now saves straight away (only the switch; the scans-per-day number and the model still use Save). Needs a new build
- Wed 4 Nov: scanner tested on the phone (works). Admin AI model is now picked from Google's live list of Gemini models (`scannerModels`, admins only; usual models if the list can't be read; warning if the chosen model disappears). 10 texts in 10 languages; 133 app tests, 89 server tests, 352 emulator checks. Needs `firebase deploy --only functions` and a new build
- Wed 4 Nov: AI breed scanner (phase 5, request 1): `scanBreed` function with Gemini on Vertex AI (photo checked and never stored, daily limit, answer cleaned), Admin → More → Breed scanner (on/off, scans per day, model), Profile → Breed scanner, result with breeds and %, mix, facts and AI note, save breed to a pet, "Find the breed with AI" in the pet form. 52 texts in 10 languages, 7 new app tests (132), 7 new server tests (87), 26 new emulator checks (349). Not deployed yet

- Tue 3 Nov: phase 4 and invite tracking deployed and tested on the phone. Places key moved to Secret Manager (code changed, secret set, removed from `functions/.env`; functions deploy left). Maps Android and iOS keys confirmed restricted; `invites.cjs` now clears earlier invites so all 8 emulator scripts pass in one run (323)
- Tue 3 Nov: phase 5 requests received (AI breed scanner, heat calendar, pet sitting, schedule, social sharing, share reminders, feedback, titles); plan with what's already in the app and what to build in `PHASE_5_REQUESTS.md`, sent to the client

- Tue 3 Nov: invite tracking (client follow-up of the same day): QR scans and link opens counted by the invite page (QR link marked `?s=qr`, once a day per visitor, no IP kept), invite statuses Active / Inactive / Waiting plus "still using the app" (new setting, 30 days), Admin → user's Invites box and invited friends list, Admin → More → Invites (totals, ranking, periods), the user's own counts on Invite friends. 10 languages, 10 new app tests (125), 5 new server tests (80), 29 new emulator checks. Count boxes in a row made the same height (Active / Inactive / Waiting in one row). Not deployed yet

- Mon 2 Nov: phase 4 (client request of the same day): QR invites with a printable flyer and an invite page for Android and iPhone; Places to walk with Google Places (map and list, types, distance, details, directions, admin settings and hidden places, daily limits); voluntary donation screens (Support CodaMi page, prompts after a report and a found pet, admin settings), switched off until store payments. 10 languages, 7 new app tests (115), 7 new server tests (75), 23 new emulator checks. Not deployed yet

- Fri 30 Oct: shop day 2: cart (saved per account, cart icon with count), shipping settings in Admin → Shop → Shipping (zones, methods, price per zone, free above), totals with VAT included and the free-shipping hint, cost price and margin (admin only), affiliate click counting, sponsored products with dates. 52 labels in 10 languages, 4 new app tests (108), 21 new emulator checks. Rules not deployed yet

- Thu 29 Oct: new Shop look for users (header kept the same as the other tabs): category pills (icon and name, "All" first), "For your pets" and "On sale" rows, smaller product cards (still 2 per row) with shadow, sale and partner tags, product page with a large photo, thumbnails, "You save", availability dot and description card. 6 new labels in 10 languages
- Thu 29 Oct: new text field design in the petition and shop forms: the label sits above the box (it no longer jumps into the border and cuts the top line when tapped), rounded filled boxes, coloured border while typing, red border and label on errors; dropdowns match. Shared in `lib/core/widgets/form_fields.dart`, so other forms can use it
- Thu 29 Oct: shop Phase 1, day 1 (client request 18): on/off switch (starts off), switches per sales model, categories, brands, suppliers and products in Admin → More → Shop, Shop tab for users only while it's on, admin preview, affiliate "Buy on…" button. Server rules: users read the catalogue only while the shop is on, suppliers admin only. 10 languages, 8 new app tests (104 in total), 76 new emulator checks. Rules deployed Thu 29 Oct

- Tue 27 Oct: app updates (client request of the same day): the app checks the store version on every start and keeps listening, shows an update sheet with that version's What's new notes (once per version), a Home banner and a Profile row, "Update now" opens Google Play or the App Store, and a blocking "Update required" screen below the minimum version. Versions, minimums and App Store ID are set in Admin → More → App updates, no new build needed. 10 languages, 6 new app tests, 15 new emulator checks. Rules deployed, admin side tested on the Oppo

- Mon 26 Oct: animal welfare petitions (client request of the same day): Admin → More → Petitions (add, edit, verify, approve / reject, publish, status, delete), Home banner and Profile → Petitions for users, detail page, "View petition" opens the original site. Server rules: admins only, published-only for users, checks required to approve. 10 languages, 7 new app tests, 37 new emulator checks. Not deployed yet

- Fri 23 Oct: "What's new" after updates (admin-written notes in 10 languages) and the feedback card with points, plus the store rating window without points. 15 new server and app tests, 25 emulator checks
- Fri 23 Oct (evening): What's new uses expandable cards and loads 10 versions per page; the app checks for notes only once after each update (fewer Firestore reads). Admin side tested on the phone
- Fri 23 Oct: `TEST_SCENARIO_2026-10-23.md`, step-by-step test on real phones
- Fri 23 Oct: fixed Google sign-in on Play Store builds (the release build removed the Google client ID; now kept in `android/app/src/main/res/raw/keep.xml`). Goes out with build 11
- Fri 23 Oct: Android fills in the invite code from the Play Store install (needs a Play Store test)
- Fri 23 Oct: red emergency pins on the map (needs a phone check)
- Fri 23 Oct: deployed the Thu 22 Oct build and tested on two phones: daily rewards, invites, emergencies, admin screens, alerts off, AI moderation with real photos, support on two phones, Videos tab
- Fri 23 Oct: `NEEDED_FROM_CLIENT.md`, a list ready to send to the client
- Thu 22 Oct: invite code screen after sign-up (once, skippable), smarter code box (pasted message or link works, clear error for each case), limit of 10 wrong codes a day (server, needs the deploy)

- Disclaimer wording approved by the client; already in the app in all 10 languages

- Thu 22 Oct: points, daily rewards, invites, emergency management (built, not yet deployed)
- Wed 21 Oct: AI photo moderation (deployed; the photo-save fix and 7-day removal go out with the full deploy above)
