# CodaMi: Pending Tasks

One list of everything still open, so work can pick up from here. Tick items off and move them to **Done recently** when finished. Details live in the linked files.

_Last updated: Thu 29 Oct 2026 (shop day 1)_

---

## 1. Testing now

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
- [ ] Automatic invite code (Fri 23 Oct, needs the Play Store build): on phone B, uninstall CodaMi, open phone A's invite link (Profile → Invite friends → Share), install from the Play Store (closed testing), sign up and choose the city; the "Did a friend invite you?" screen should already show A's code with a note, then tap Use. Installing from a cable or APK can't test this

- [x] **Deploy (app updates, Tue 27 Oct):** rules are live (`config/appVersion`)
- [x] **App updates, admin side on the Oppo (Tue 27 Oct):** form checks, notes status (missing / draft / published), update sheet once per version with the notes, "Update now" opens Google Play, confirm dialog, "Update required" covers the app straight away
- [ ] **App updates:** full phone test and client video with `TEST_SCENARIO_APP_UPDATES_2026-10-27.md` (user side: banner, Profile row, required update as a user, undo from the Firebase console)

Fixes found while testing go here:

- Tue 27 Oct, app updates on the Oppo: admins were locked out by "Update required" (could only be undone in the Firebase console), now a "Continue as admin" button for admins only, until the app is closed; the keyboard stayed open over the "Update required" screen, now closed; red errors in App updates now clear while typing

- Thu 22 Oct, emulator test as a support account: dashboard card, Reported tabs (AI photos / User reports) and Emergencies list work with no errors in the log. Fixed: emergency filter chips were square, now rounded like the other tabs
- Thu 22 Oct, emulator test continued (support account): Tickets, request Chat / Details / Timeline and More work with no errors. Fixed: a large empty gap under the time cards in a request's Details (same fix on the new emergency, new report and video form screens), and a two-line user name and email in Details were misaligned. Also fixed: signing out of the admin side caused an error and might not set the operator offline (now set offline before signing out); support staff saw another operator's chat messages labelled "Admin" (now "Support team", only admins see names). Redesigned Admin → Emergency settings and Points and rewards (header, section cards, one row per setting, extra space at the end); emergency settings now show the defaults if they can't be loaded

## 2. Development left (ours)

- [ ] **Shop Phase 1** (started Thu 29 Oct): day 1 built (on/off switch, sales model switches, categories, brands, suppliers, products, Shop tab, preview, rules); next: affiliate click counting, cost and margin, cart, shipping, Stripe checkout, orders, refunds, sponsored, reports (`SHOP_FEATURE.md`)
- [ ] Turn on email alerts to organizations once the client sets up the email service (install the Firebase "Trigger Email" extension, then Admin → Emergency settings → Email alerts)
- [ ] Move the Places key to Secret Manager and restrict the Google Cloud keys (see `LAUNCH_CHECKLIST.md` §1)
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
- [ ] **Shop (request 18):** Phase 1 approved Thu 29 Oct; still need countries, company / VAT, Stripe account, first partners, product text languages, bottom-bar tab, computer admin, terms of sale (`SHOP_FEATURE.md`)

## 4. Later (after launch)

- [ ] Partner organization accounts that receive and answer emergencies in the app
- [ ] Points connected to the client's next features (new actions plug into `config/points`)
- [ ] Geohash queries for the report radius, alerts by distance for lost and found, auto-close old reports, smaller photos on upload (`LAUNCH_CHECKLIST.md` §7)

---

## Where things are

- `LAUNCH_CHECKLIST.md`: everything needed before publishing
- `WAITING_FOR_CLIENT.md`: questions sent to the client and their answers
- `PHASE_2_REQUESTS.md` / `PHASE_3_REQUESTS.md`: feature requests, decisions and what was built
- `WEEK_N_*.md`: weekly progress for the client
- `emulator_tests/README.md`: how to run the end-to-end emulator tests

## Done recently

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
