# CodaMi: Phase 3 Requests

New feature requests from the client (received Wed 21 Oct 2026), what already exists, and the proposed approach. Scope is still to be agreed with the client before work starts. Open questions are in `WAITING_FOR_CLIENT.md`.

_Last updated: Thu 22 Oct 2026 (points, referrals and emergencies built)_

| # | Request | Status | Size |
|---|---|---|---|
| 1 | AI-powered image moderation | Built (Wed 21 Oct), to deploy and test with real photos | Medium |
| 2 | Points, daily rewards and referrals | Built (Thu 22 Oct), to deploy and test on phones | Medium–Large |
| 3 | Emergency management | Built (Thu 22 Oct), to deploy and test on phones | Large |

---

## 1. AI-powered automated moderation

**Request:** AI checks images for prohibited content (nudity, sexually explicit material) as a first filter. Unclear cases must be reviewed by a human moderator.

**Already there**
- Users upload photos to `pets/{uid}/` and `reports/{uid}/` in Storage (images only, under 5 MB). Admins upload videos and covers to `videos/`.
- **Reported** tab on the admin side (staff): reports grouped per listing, with dismiss, hide and delete. Listings already have a `hidden` status.

**Decisions (Wed 21 Oct, made by us)**
- **Checked:** every photo users upload (pet photos and listing photos, and support chat photos if they are added). Admin videos and covers are not checked.
- **Not checked for now:** text (descriptions, chat). User reports cover it.
- **Nudity and sexual content (adult, racy):** "very likely" adult is removed straight away; "possible" or "likely" adult, or "likely" and above racy, goes to a moderator.
- **Violence:** never removed by the AI, because photos of injured animals are legitimate. "Very likely" violence goes to a moderator.
- **Medical and spoof:** ignored.
- **While waiting for a moderator:** the listing stays visible, so a lost pet is never delayed; only the flagged photo is hidden and replaced with "Photo under review".
- **Reviewers:** all staff (admins and support), in a new **AI review** section of the Reported tab. Online staff get a push when a photo needs review.
- **Cost:** accepted. The budget alert in Google Cloud covers surprises.

**How it works**
- A Storage trigger (`onPhotoUploaded`) runs on every new image in `pets/` and `reports/` and sends it to **Google Cloud Vision SafeSearch**. It returns adult, racy, violence, medical and spoof scores, from "very unlikely" to "very likely".
- Three outcomes:
  - **Clear:** nothing happens
  - **Review:** the photo is held and goes to the **AI review** queue, where a moderator approves or removes it
  - **Blocked:** the photo is held and the owner is told straight away. It still waits in the queue for a moderator to confirm, so a person always makes the final call
- A held photo is **moved** to `quarantine/`, so its link stops working everywhere at once, including lost listings that reuse a pet's photo. Approving moves it back and the old link works again (the download token is kept).
- **Remove** takes the photo out of the owner's pets and listings, tells the owner, and keeps the file in quarantine for 7 days before it is deleted (changed from 30 on Wed 21 Oct).
- If Vision fails, the photo stays visible and is retried every 30 minutes (up to 5 times), so a Google outage never blocks a lost-pet listing.
- Pushes about a new listing only include its photo once the photo has passed the check (waits up to 15 s for the result).
- Every decision is saved in `photoChecks/{id}` (AI scores, reason, who reviewed, when).
- Limits are kept in `config/moderation` (`blockAdult`, `reviewAdult`, `reviewRacy`, `reviewViolence`, as Vision likelihood names), so they can be tuned without a new build. Defaults are used when missing.

**Built (Wed 21 Oct)**
- [x] Server logic in `functions/src/moderation.ts` (unit tested), functions in `functions/src/moderationFunctions.ts`: `onPhotoUploaded`, `moderatePhoto` (staff: approve / remove), `moderationSweep` (every 30 min: retries, deletes removed photos after 7 days, checks photos uploaded before moderation, 100 per run)
- [x] Push texts in all 10 languages: staff ("Photos to review", opens the Reported tab), owner ("Your photo is being checked", "Photo removed", "Your photo is back")
- [x] Rules: `photoChecks` readable by staff and by the photo's owner, written only by functions; `quarantine/` readable by staff only; new index for the review queue
- [x] Admin app: **AI photos** in the Reported tab, each photo blurred until tapped, reason and likelihood, "Hidden by AI" for blocked ones, pet or listing photo, uploader, time, and Approve / Remove (with confirmation)
- [x] User app: owners see "A photo is being checked by our team" on their own pet or listing
- [x] Account deletion also deletes the user's held photos and checks
- [x] All new app text in the 10 languages
- [x] Tests: 12 new server tests (45 in total pass), 2 new app tests (57 in total pass), and a full emulator test with fake AI results (28 checks pass): clear, review, blocked, injured-animal photos, admin videos skipped, the rules, approve (photo and old link come back), remove (photo taken out of the listing), no double review
- [x] Storage bucket location confirmed: `us-east1` (Wed 21 Oct). The trigger runs there (`STORAGE_REGION` in `moderationFunctions.ts`)
- [x] Fixed after the first real test (Wed 21 Oct): the app stores photos as `pets/{uid}/{petId}/{file}`, one folder deeper than the check expected, so every photo was skipped. The check now accepts both, the emulator test uses the real paths, each check logs its scores ("Photo checked"), and the check of old photos starts again from the beginning
- [x] Fixed after the second real test (Wed 21 Oct): a flagged photo was moved before the app had asked for its link, so saving the pet failed. The server now saves the photo's original link in its check before moving it, and the app reads it from there when the photo is already gone (needs the new app build). Emulator test: 30 checks pass
- [x] Reported tab split into two tabs (Wed 21 Oct): **AI photos** and **User reports**, each with its count and its own empty message. It opens on the tab with something waiting, and the "Photos to review" push opens AI photos
- [ ] Deploy and test with real photos on a phone (normal pet photo, swimwear stock photo, injured-animal photo)
- [ ] Not tested in the emulator (no Pub/Sub emulator): the 30-minute sweep and the check of old photos

**Known limits**
- A new photo is visible for the few seconds the check takes.
- Phones that already showed a photo may keep it in their image cache until it is removed from the listing.
- The Reported tab icon has no count badge (the nav bar doesn't support badges); each tab inside shows its count.

**Not in this version**
- Strikes or automatic bans for repeat uploads (staff can already disable a user from their page).
- Checking text and admin videos.

**Notes**
- Cost: about 1,000 images a month free, then about $1.50 per 1,000 (check current Google Cloud pricing).
- No AI is perfect: some bad photos will pass and some good ones will be flagged, so user reports (already built) stay important.

## 2. Points, daily rewards and referrals

**Client answer (Thu 22 Oct):** a flexible points system that future features plug into; for now referrals, a daily reward for active use and a basic daily activity system. We choose the values; everything adjustable later. No invite limit, privacy-friendly anti-fraud. Invitees don't need points for registering; design an ambassador strategy. Full answer in `WAITING_FOR_CLIENT.md`.

**Already there:** nothing. Accounts are created with Google, Apple or email. The profile rules let users change almost any field on their own profile, so points and referral fields must be protected first.

**Design: one points engine, many sources**
- Points are only ever given by the server, through one function: `awardPoints(uid, action, key)`. Each award is a line in `users/{uid}/pointsLedger/{action_key}`; the line's ID makes every award count **once** (no double points). The total is kept on `users/{uid}.points`.
- **Actions and their values live in `config/points`**, editable from the admin panel. A future feature only needs a new action name and value, no change to the engine. An action set to 0 is off.
- Users can't write `points`, the ledger or any referral field (rules).
- Admins can add or remove points by hand, with a reason (also a ledger line).

**Daily activity (expandable)**
- A **Daily** card on Home with today's tasks, each with points and a Claim button. Tasks are listed in `config/points.dailyTasks`, so new ones are added without a new build (the app shows any task it knows; unknown ones are skipped).
- Starting tasks: **Daily check-in** (open the app, 5 points) and **Active today** (3 minutes of use in the app, 10 points).
- **Streak:** claiming on 7 days in a row gives a 25-point bonus. A day is a calendar day in Italian time.
- The server allows each task once per day and checks the streak; the app measures active time.

**Referrals: ambassador strategy**
- Every user gets a personal **invite code** (6 letters and numbers) and a **Invite friends** screen with a share button. The share text has the code and a store link; on Android the Play Store link carries the code, so it's filled in by itself (Play Install Referrer). Firebase Dynamic Links no longer exist; real web links can come later with a domain.
- The invited person can enter a code during onboarding or within 7 days in Profile.
- The inviter earns points only when the friend becomes a **real, active user**: city set and the app used on **3 different days within 14 days** of signing up (configurable). This is the main protection against fake accounts and gives the friend time to discover the app.
- **Ambassador levels** by number of active friends: Supporter (1), Ambassador (5), Super Ambassador (15), CodaMi Champion (30), each with a bonus and a badge on the profile (values and names in config).
- The invited friend gets nothing for registering (0 in config, can be turned on later).

**Anti-fraud (privacy-friendly)**
- No self-invites; one code per account, set once.
- **Install ID:** the app creates a random ID the first time it runs and keeps it on the phone. No hardware IDs, no advertising ID, no phone number. The server keeps only a scrambled (hashed) version.
- Suspicious cases are **held for admin review, never rejected automatically**: same install ID as the inviter, an install ID already used for another invited account, or more than 10 friends qualifying for one inviter in a day (configurable). So families sharing a phone are never punished automatically.
- Disabled or deleted invited accounts don't count.
- Admin side: **Referrals to review** (approve or reject, with the reasons shown).
- The privacy policy and the Data safety form need a line about the install ID (it fits "Device or other IDs", already declared).

**Screens**
- User: Daily card on Home, **Points** screen (total, history, level), **Invite friends** screen, code entry in onboarding and Profile.
- Admin: **Points settings** (values, daily tasks, streak, qualification rules, levels), **Referrals to review**, points and invites on a user's page with manual adjustment.

**Built (Thu 22 Oct)**
- [x] Server: `functions/src/points.ts` (rules, unit tested) and `functions/src/pointsFunctions.ts`: `registerVisit` (counts active days, keeps install ID hashes), `claimDailyTask`, `getInviteCode`, `redeemInviteCode`, `adminReviewReferral`, `adminAdjustPoints`, daily `pointsSweep` (closes invites that never became active). Every award is a line in `users/{uid}/pointsLedger` with a fixed ID, so nothing pays twice
- [x] Values in `config/points` (defaults: check-in 5, active 10 after 3 minutes, streak bonus 25 every 7 days, 50 per active friend, friend qualifies with a city and 3 active days within 14 days, code entry within 7 days, review after 10 qualified friends a day, levels 1 / 5 / 15 / 30 friends with 10 / 50 / 150 / 300 bonus)
- [x] Rules: users can't write points, daily, activity, install hashes, invite or level fields; ledger readable by the owner and admins; invites readable by the two people involved and admins; `config/points` editable by admins
- [x] App: points chip in the Home header (dot when a reward is waiting) opening the **Daily rewards** sheet; **My points** (total, level, progress, history); **Invite friends** (code, copy, share with the Play Store link, how it works, levels, code entry, list of invites and their status); Profile entries
- [x] Admin: **Points and rewards** settings, **Invites to review** (reasons shown, approve / reject, open inviter or invitee), points, level and invited friends on a user's page with **Adjust points**
- [x] Pushes in 10 languages: friend became active, new level, invites to review (admins)
- [ ] Android: fill in the code automatically from the Play Store install (Play Install Referrer). The share link already carries the code; the app doesn't read it yet

**Notes**
- Points have **no money value** for now, so no prize promotion rules apply. If points later become prizes or discounts, check Italian prize promotion rules (DPR 430/2001) first.
- No public ranking for now (privacy); the level badge is the public part.

## 3. Emergency management

**Client answer (Thu 22 Oct):** build it now. Users report emergencies; the right people are notified; vets, associations and services show phone and email in the app; start with clearly marked test contacts; directory managed from the admin panel; prioritize by distance and relevance; configurable radius and rules; clear "not an emergency service" notice. Full answer in `WAITING_FOR_CLIENT.md`.

**Already there**
- Lost and found reports with photos, location, map pins and city alerts. Push notifications with per-type sounds and on/off switches. Photo moderation.
- Users are stored with their **city only**, not an exact position, so "nearby" alerts need a new opt-in.

**Design**
- A separate `emergencies` collection (not mixed with lost and found), so emergencies have their own rules, statuses, alerts and map pins.
- **Report an emergency:** a red button on Home and the map, then a short form: type (injured, in danger, abandoned, found in an urgent situation, request for intervention, other), animal, photos (checked by AI moderation like other photos), a note, and the **exact place** (where the animal is, not the reporter's home). Before sending, the notice: "CodaMi is not an emergency service. If an animal is in immediate danger, call 112 or a vet first", with a **Call 112** button.
- **Statuses:** open → someone is helping → resolved; also closed and false alarm. The reporter and staff can update it; it closes by itself after 72 hours without updates (configurable).
- **Emergency screen:** details, map, status, and the **suggested contacts** for this emergency, each with Call, Email and Directions buttons.

**Contact directory**
- `emergencyContacts/{id}`: name, type (vet, animal welfare association, municipal or veterinary service, other), phones, email, address and position, area covered (radius in km), emergency types handled, open 24 hours or opening times, **verified**, **recommended**, active, and **test placeholder**.
- Test placeholders show a clear **"TEST – not a real contact"** label and are never emailed. Real contacts can be marked verified only by admins.
- Admin side: **Emergency contacts** list with search, add, edit, verify, deactivate and delete. A few test contacts are added at first.
- Users also get an **Emergency contacts** screen to browse contacts near them without reporting anything.

**Who is notified, in what order**
- **Contacts** are ranked by a score: handles this emergency type, recommended, verified, available now (24 hours or open), and distance within their area. Weights and limits are in `config/emergency`, so recommended organizations can be put ahead of nearer ones. The top contacts are shown to the reporter; **email alerts** to them are sent once an email service is set up (question for the client).
- **Nearby users:** a new opt-in, **"Emergency alerts near me"**, in Profile → Notifications. It saves an approximate position (about 5 km precision) when the app is opened. The server alerts opted-in users in growing circles (for example 5, then 10, then 25 km) until enough people are reached, up to a maximum. All distances and numbers are in config.
- **Staff:** every emergency appears in a new **Emergencies** list on the admin side, with a push.
- Emergency alerts have their own notification type, with its own switch and sound.

**Abuse**
- Users can report a false emergency; staff can mark it as a false alarm. Repeated false alarms are visible on the user's page (staff can disable the account, already built).

**Built (Thu 22 Oct)**
- [x] Server: `functions/src/emergency.ts` (ranking, alert circles, statuses, unit tested) and `functions/src/emergencyFunctions.ts`: `onEmergencyCreated` (ranks contacts, saves them on the emergency, alerts nearby users with an in-app notification and push, alerts staff, prepares emails), `updateEmergency` (help, resolve, close, reopen, false alarm, report as false, with a timeline), hourly `emergencySweep` (auto-close after 72 h, adds the home geohash to older accounts), `seedTestContacts`
- [x] "Nearby" uses the city position each user already chose at sign-up (`homeLat` / `homeLng` → `homeGeohash`), so there is no new location tracking or permission. Users can turn emergency alerts off in Profile → Notifications (new type with its own switch and sound)
- [x] Values in `config/emergency` (defaults: circles 5 / 10 / 25 km, reach 20 people, at most 300, auto-close 72 h, contact area 30 km, 5 suggested contacts, weights recommended 20, verified 10, open 24 h 5, minus 1 per km, emails off)
- [x] Emails to contacts are prepared in the Firebase **Trigger Email** format (`mail` collection) but only sent when `emailEnabled` is on, to verified, non-test contacts. Needs the email service (question for the client)
- [x] Emergency photos are checked by the AI moderation like other photos
- [x] Rules: anyone signed in can read emergencies; only the reporter creates (must start open, exact fields); every change goes through the server; contacts readable when active, editable by admins only; timeline readable by staff
- [x] App: red **SOS** button in the Home header, a red banner when emergencies are active near the user's city, the **Report an emergency** form (notice and Call 112 first, type, animal, description, photos, exact place starting from the phone's location, optional phone), the emergency screen (status, photos, place with directions, call the reporter, "I'm going to help", resolve / close / reopen, report as false, suggested contacts with Call / Email / Directions), **Emergencies** (near you / mine) and **Emergency contacts** (filter by type) from Profile
- [x] Admin: **Emergencies** list (active / all, false reports shown, staff can mark a false alarm), **Emergency contacts** (search, add, edit, verify, recommend, hide, delete, add test contacts), **Emergency settings**, active emergencies on the dashboard, push that opens the emergency
- [x] 6 test placeholder contacts (Milan, Rome, Naples, Turin) named "TEST – …", phone numbers +39 000…, `example.com` emails, never verified
- [ ] Red emergency pins on the map (the Home banner and the Emergencies list show them for now)
- [ ] Real contacts from the client, and the client's approval of the disclaimer wording

**Tests (Thu 22 Oct)**
- 66 server tests (21 new) and 65 app tests (8 new) pass
- Emulator tests are now kept in `emulator_tests/` (see its README) and all 94 checks pass: 31 for photo moderation (now including emergency photos and the 7-day removal) and 63 for points, invites and emergencies (daily claims, streak bonus, config values, rules on points, invite codes, qualifying, levels, same-device review and admin approval, manual points, test contacts, nearby alerts by distance and switch, status changes, false reports, timeline rules)
- Bug found and fixed in the emulator test: emergencies without a photo waited 8 seconds before alerting

**Notes**
- The notice and the 112 button are always visible; the client should confirm the wording.
- Store forms: approximate location for nearby alerts is optional and only used for alerts (update the privacy policy and Data safety form).
- Partner organizations with their own accounts (receiving and answering cases in the app) would be a later expansion; the directory is designed so contacts can later be linked to accounts.

## Suggested order

1. **Emergency management**: the client wants it before launch, and it's the larger piece.
2. **Points engine and daily rewards**.
3. **Referrals and ambassador levels** (builds on the points engine).
