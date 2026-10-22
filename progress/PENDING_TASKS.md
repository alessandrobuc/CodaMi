# CodaMi: Pending Tasks

One list of everything still open, so work can pick up from here. Tick items off and move them to **Done recently** when finished. Details live in the linked files.

_Last updated: Thu 22 Oct 2026_

---

## 1. Testing now (Thu 22 Oct build)

- [ ] **Deploy:** `firebase deploy --only firestore:rules,firestore:indexes,storage,functions`, then wait for the 7 new indexes (Firestore → Indexes)
- [ ] Build and install the new app on two phones
- [ ] Admin → More → Emergency contacts → **Add test contacts**
- [ ] **Daily rewards:** claim check-in, wait 3 minutes and claim "Active today", check the points chip, My points and the history
- [ ] **Invites:** phone A shares its code, phone B (new account) enters it on the new "Did a friend invite you?" screen right after choosing the city (or later in Invite friends, within 7 days); check the invite shows as "Joined, not active yet" on phone A
- [ ] **Emergency:** phone B reports one near phone A's city (with and without a photo); phone A gets the alert, opens it, taps "I'm going to help"; phone B gets "Someone is going to help" and marks it resolved
- [ ] Check the suggested contacts (TEST labels, Call / Email / Directions) and the Emergencies list and banner on Home
- [ ] Admin: Emergencies list, false alarm, contact add / edit / verify / hide, Emergency settings and Points settings save, Adjust points on a user's page
- [ ] Turn emergency alerts off in Profile → Notifications and confirm no alert arrives
- [ ] **AI moderation** with real photos: normal pet photo, swimwear stock photo, injured-animal photo; approve and remove from Reported → AI photos (needs the build with the photo-save fix)
- [ ] **Support** on two phones (chat, requests, take / reply / resolve / reopen, reassign, notifications) and the Operators screen
- [ ] Videos tab with no pets, a dog and a cat

Fixes found while testing go here:

- Thu 22 Oct, emulator test as a support account: dashboard card, Reported tabs (AI photos / User reports) and Emergencies list work with no errors in the log. Fixed: emergency filter chips were square, now rounded like the other tabs
- Thu 22 Oct, emulator test continued (support account): Tickets, request Chat / Details / Timeline and More work with no errors. Fixed: a large empty gap under the time cards in a request's Details (same fix on the new emergency, new report and video form screens), and a two-line user name and email in Details were misaligned. Also fixed: signing out of the admin side caused an error and might not set the operator offline (now set offline before signing out); support staff saw another operator's chat messages labelled "Admin" (now "Support team", only admins see names). Redesigned Admin → Emergency settings and Points and rewards (header, section cards, one row per setting, extra space at the end); emergency settings now show the defaults if they can't be loaded

## 2. Development left (ours)

- [ ] Red emergency pins on the map
- [ ] Android: fill in the invite code automatically from the Play Store install (Play Install Referrer); the share link already carries `referrer=CODE`
- [ ] Turn on email alerts to organizations once the client sets up the email service (install the Firebase "Trigger Email" extension, then Admin → Emergency settings → Email alerts)
- [ ] Move the Places key to Secret Manager and restrict the Google Cloud keys (see `LAUNCH_CHECKLIST.md` §1)
- [ ] App Check, budget alert, API quotas, Crashlytics (`LAUNCH_CHECKLIST.md` §4)
- [ ] Privacy policy and Data safety: install ID, exact emergency location shown to signed-in users, city position used for nearby alerts, support email (`LAUNCH_CHECKLIST.md` §6)
- [ ] Remove test data (reports, users including invite.test.cm1@codami.test, pets, test contacts) and retake store screenshots before release
- [ ] Raise the build number in `pubspec.yaml` and upload to Play closed testing
- [ ] Donations, if the client says yes (RevenueCat, store products)

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
- [ ] Native-speaker translation review (Italian first)
- [ ] Confirm the Android signing key backup

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

- Thu 22 Oct: invite code screen after sign-up (once, skippable), smarter code box (pasted message or link works, clear error for each case), limit of 10 wrong codes a day (server, needs the deploy)

- Disclaimer wording approved by the client; already in the app in all 10 languages

- Thu 22 Oct: points, daily rewards, invites, emergency management (built, not yet deployed)
- Wed 21 Oct: AI photo moderation (deployed; the photo-save fix and 7-day removal go out with the full deploy above)
