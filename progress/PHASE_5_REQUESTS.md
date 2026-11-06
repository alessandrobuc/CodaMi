# CodaMi: Phase 5 Requests

New features from the client (received Tue 3 Nov 2026). The plan was sent the same day. Go-ahead given Wed 4 Nov (no fixed order). Built: the AI breed scanner (§6), the heat calendar (§5) and pet sitting (§8). Everything else below is still to do.

_Last updated: Fri 6 Nov 2026 (feedback and titles built, to deploy and test) (Wed 4 Nov: go-ahead given; AI breed scanner online, heat calendar and pet sitting built and to deploy; feedback, sharing, share reminders, schedule and titles not started)_

| Order | # | Request | Already in the app | Status | Size |
|---|---|---|---|---|---|
| 1 | 7 | Feedback: store reviews + internal feedback | Mostly | **Built Fri 6 Nov**, to deploy and test | Small (about 1 day) |
| 2 | 5 | Social sharing of reports | Partly (text share) | **Built Thu 5 Nov**, to deploy and test | Medium (about 2 days) |
| 3 | 6 | Recurring share reminders | No | **Built Thu 5 Nov**, to deploy and test | Small (about half a day) |
| 4 | 4 | Personal schedule, notes and reminders | No | **Built Thu 5 Nov**, to deploy and test | Medium (2 to 3 days) |
| 5 | 2 | Heat cycle calendar | No | **Built Wed 4 Nov**, to deploy and test | Medium (about 2 days) |
| 6 | 1 | AI breed scanner | No (only photo moderation) | **Built Wed 4 Nov**, to deploy and test | Medium (2 to 3 days) |
| 7 | 8 | Profile tags, titles and achievements | Partly (invite levels) | **Built Fri 6 Nov**, to deploy and test | Medium (about 3 days) |
| 8 | 3 | Pet sitting marketplace | No | **Built Wed 4 Nov** (all 3 parts), to deploy and test | Large (6 to 8 days) |
| - | 9 | General principles | Followed already | - | - |

Total: about 19 to 22 working days, one feature at a time, each tested and sent to the client when done.

---

## 1. Feedback (request 7): built Fri 6 Nov

**Already there**
- In-app Google Play review window (`in_app_review`), asked after `reviewAfterDays` and `reviewMinActiveDays`, then every `reviewEveryDays` (Admin → Points and rewards); never right after our own question (`startup_prompts.dart`, `feedback_rules.dart`).
- "Rate CodaMi" in Profile opens the store page (iPhone once the App Store ID is set).
- Feedback card: stars + comment, sent with `submitFeedback`, points for sending it, shown at most 3 times, every 30 days, after `feedbackAfterDays`.
- Profile → Send feedback.
- Admin → Feedback list (`admin_feedback_screen.dart`).

**To build**
- 7A: the current feedback entry becomes **Rate CodaMi on Google Play**: the official in-app review window, or the Play Store review page from Profile. No own rating screen in front of it, no points for store reviews (Google rule). Check wording and timing.
- 7B is a separate entry and card: **Send feedback** (internal), so the two are never mixed.
- 7B: feedback type: suggestion, bug, problem, idea; optional stars; text.
- Usage counters per feature (reports, map, walks, shop, scanner…) on the phone; ask after 10 to 20 uses of a feature, random inside that range.
- Cooldown about 14 days after any ask; never the same question twice in a row; stop after a set number of asks.
- Feedback saves the feature it came from and the app version.
- Admin → Feedback: filters by type and feature, mark as read / done.
- Admin settings: uses needed, cooldown days, max asks, on/off.

**Built (Fri 6 Nov)**
- 7A: Profile → **Rate CodaMi** now comes first and opens the Play Store page (Google asks that a button opens the store page; its in-app window is kept for the automatic moment). The automatic window now waits the feedback pause (14 days) after our own question instead of 1 day.
- 7B: new form (`feedback_sheet.dart`): Suggestion / Bug / Problem / Improvement, part of the app, optional stars, text with a hint per type, optional screenshot (`feedback/<uid>/`, staff only), app version, phone model (`codami/device` channel) and language added automatically. Up to 5 a day; first one still +20 points.
- Asks: each screen counts a use (`FeedbackTracker.used`); after a fixed random 10 to 20 uses per user and part (`usesNeeded`), the question waits until the user is back on the main tabs (`askFeedbackWhenIdle`). Pause 14 days (also after sending, and after the store window), each part once, 4 at most, none in the first 3 days, "Don't ask me again". General question on 1 in 4 starts after 10 active days, once. State on the account (`users.feedbackAsk`), counters on the phone.
- Admin → Feedback: last 30 days by type and average stars per part, New / In progress / Done tabs, filters (type, part, stars), screenshot viewer, private note, open user, Done with an optional thank-you push in the user's language (once). ⚙ settings: on/off, uses from–to, pause, max (`config/feedbackAsks`).
- Tests: `test/feedback_rules_test.dart`, `functions/src/feedback.test.ts`, `emulator_tests/feedback_asks.cjs`; phone test `TEST_SCENARIO_FEEDBACK_2026-11-06.md`.

## 2. Social sharing (request 5): built Thu 5 Nov

**Built** (choices agreed: Firebase address for now, area and reward on the page, a "back home" share)
- Share sheet (`lib/features/sharing/`): opens by itself after publishing a lost or found report and after marking a pet found (admin switch `config/sharing.popup`, admins always), and from Share on any report. Preview of the image, WhatsApp, Facebook, Instagram, TikTok, More, Save image, Copy link, "Not now"; the owner sees "Shared N times · M page visits".
- Share image (1080×1080, made on the phone in the app's colours): photo, LOST / FOUND / BACK HOME / REUNITED label, CodaMi logo, name, species and area, date, reward, a QR code to the page and the green CodaMi bar. Never a phone, email or exact address.
- Each platform (fixed Thu 5 Nov after the first test: the image now always goes): on Android each button opens its app directly with the image (`codami/share` channel in `MainActivity.kt`, FileProvider `share_paths.xml`); WhatsApp gets the text + link as the image caption; Facebook, Instagram and TikTok drop text from other apps, so the caption with the link (and hashtags for Instagram/TikTok) is copied to paste. iPhone, or an app not installed: the share menu with the image and text. More = image + text + link.
- Public page `/r/<id>` (`reportPage`, hosting rewrite): built by the server with link-preview tags (title, text, photo) in the sharer's language (`?l=`) or the visitor's; photo, label, chips, description, "Seen …? Open CodaMi", Open in CodaMi (Android intent `codami://report/<id>`, Google Play if not installed; iPhone tries the app then the App Store), store buttons, Share this page. Only photos that passed moderation; resolved = "back home" card; hidden or deleted = "no longer available".
- "Open in CodaMi": the app opens the report (`app_links`, `codami://report/<id>`, Android intent filter and iOS URL type; after sign-in if needed).
- Numbers: `logReportShare` counts shares per report and app; the page counts visits by source (WhatsApp, QR, direct…), not link previews. `reportShares/{id}` (owner and admins read), `shareStats/{day}` (admins). Admin → More → Social sharing: pop-up on/off, last 30 days shares and visits, by app and by source.
- Removed with the account. 52 app texts and the page in 10 languages; 7 app tests, 5 server tests, 28 emulator checks; test plan `TEST_SCENARIO_SHARING_2026-11-05.md`.

**Left**
- Deploy functions, rules and hosting; phone test; switch the pop-up on. Later: own domain for shorter links; Android App Links (https opens the app directly) once the Play signing fingerprint is known.

**Planned (kept for reference)**

**Already there**
- Share button on a report (`report_detail_screen.dart`): text with title, species, place, time, reward, description and footer, through the phone's share menu (`share_plus`).

**To build**
- Optional pop-up right after publishing a lost or found report (and when a pet is marked found), "Not now" always visible.
- Share image made on the phone: pet photo, Lost / Found label, name, species, area, date, CodaMi logo and name.
- Public report page on Firebase Hosting (`/r/<id>`) with photo and details, no phone, email or exact address; "Open in CodaMi" / store buttons; link preview (title, photo) for WhatsApp and Facebook.
- WhatsApp, Facebook, others: image + text + link through the share menu.
- Instagram and TikTok: image only (links in posts aren't clickable there); the text tells people to search CodaMi.
- Hide the page when the report is deleted or resolved.
- Admin: pop-up on/off.

## 3. Share reminders (request 6): built Thu 5 Nov

**Built** (defaults agreed: first after 3 days, every 7 days, stop after 8, around 18:00 Italian time)
- Plan per user in `shareReminders/{uid}` (server only): `registerVisit` plans the first one `firstDays` after sign-up (from the sign-in record), never in the past; later visits keep it.
- `shareReminderSweep` every day at 18:00 Europe/Rome: sends one reminder to each due user through the new `share` notification type (own switch and sound), rotating 4 texts in 10 languages with the client's text first; then plans the next one `everyDays` later. Skipped (planned a week later): switch off, shared CodaMi or a report in the last 14 days (`lastSharedDay`, set by `logReportShare` and `shareReminderEvent`), not active for 60 days. Stops after `maxCount`. Deleted or disabled accounts are removed.
- Tapping it opens **Share CodaMi**: the client's text, a "Join CodaMi" image with the invite code and a QR to the invite page, WhatsApp / Facebook / Instagram / TikTok / More / Save / Copy link (image straight into the app on Android), the friends who joined and a link to invite rewards, "Don't remind me again" (turns the switch off). Also from Invite friends (share icon).
- No feedback card or rating window on a day a reminder was opened.
- Admin → More → Share reminders: on/off, first / between / total, last 30 days sent, opened (%), shares; preview of the screen; "Send me a test reminder".
- Settings rules: every 3 to 60 days, first after 1 to 60, total 1 to 52. Removed with the account. 36 app texts + 40 push texts in 10 languages; 6 app tests, 6 server tests, 26 emulator checks; test plan `TEST_SCENARIO_SHARE_REMINDERS_2026-11-05.md`.

**Left**
- Deploy functions and rules, test on the phone, switch on.

**Planned (kept for reference)**

**Already there**
- Push notifications (`firebase_messaging`, `push_service.dart`), Profile → Notifications switches, daily server sweep.

**To build**
- Notification with the client's text, opens the share sheet for the app (invite link with the user's code).
- First after X days from sign-up, then about every 7 days (Admin settings), stop after a set number.
- Never on the same day as other promo prompts; skipped for users who shared recently.
- Switch in Profile → Notifications; on/off in Admin.
- Text in 10 languages.

## 4. Personal schedule, notes and reminders (request 4): built Thu 5 Nov

**Built**
- Firestore `scheduleEvents/{id}` (app in `lib/features/schedule/`): type (vet, vaccine, medicine, grooming, feeding, walk, note, other), title (empty = type name), pets (none = general), date, time or all day, place, vaccine / medicine name and dose, notes, repeat (daily, weekly on chosen days, monthly with the last day for short months, yearly; every N; ends never, on a date or after N times), up to 2 reminders (at the time / 15 min / 1 hour / 1 day / 1 week before; all-day events at 9:00), done and skipped days.
- Defaults agreed with the client: vet, vaccine, grooming 1 day + 1 hour before; medicine and feeding at the time; walk 15 min before; note all day without reminder.
- Screens: **My schedule** card at the top of the Pets tab (next event), a card on each pet's page (next 3, See all, New event), a Profile row. Calendar (month, dots per type, tap a day), Upcoming (Not done yet for the last 7 days, then by day), Done; filter by pet and type; heat estimates from the heat calendar shown as "heat expected · estimate".
- Details sheet: mark done / not done, skip this time, edit or delete "only this time" or "all times" (only this time = the day becomes its own event and the series skips it).
- Reminders: the phone plans the next ones (up to 60, within 180 days) with the texts in the user's language and stores them on the event; `scheduleReminderSweep` (every 5 minutes) sends the due one and keeps the rest; more than 30 minutes late is dropped, never sent late; done days don't remind. The app tops them up and rewrites them in the current language each time it starts. Tapping the notification opens the event.
- Deleting a pet with events asks to delete them (shared events just lose the pet) or keep them.
- Admin → More → My schedule: show to users (admins see it while off).
- Private: only the owner reads or writes (not even admins); removed with the account (`deleteScheduleData`).
- 104 texts in 10 languages; 17 app tests, 4 server tests, 33 emulator checks; test plan `TEST_SCENARIO_SCHEDULE_2026-11-05.md`.

**Left**
- Deploy functions and rules, phone test, then switch on for users.

**Planned (kept for reference)**

**Already there**
- Pets with species, breed, sex, age (`pets_entity.dart`); push notifications.

**To build**
- Schedule screen: month / list view, filter by pet.
- Event types: note, appointment, vet, vaccine, medicine, grooming, feeding, other.
- Date, time, pet, notes, repeat (daily, weekly, monthly, yearly, custom), reminder time before.
- Edit, mark done, skip one, delete one or the series; history.
- Reminders arrive like push notifications, also with the app closed (scheduled on the phone so they work offline, kept in sync with Firestore; set again on a new phone after sign-in).
- Private: only the owner can read (rules); deleted with the account.

## 5. Heat calendar (request 2): built Wed 4 Nov

**Built**
- Per pet (all pets except males), from a **Heat calendar** card on the pet's page: status (in heat now · day N, or next heat expected around a date and in how many days, or "record the first heat"), cycle and heat length with what they're based on, month calendar (recorded days in full colour, expected ones lighter, today circled), the next 3 expected heats, reminders, history (tap to edit or delete), a vet / estimate note.
- Record or edit a heat: start, end or "still in heat", notes (500). "Heat ended today" for an ongoing heat.
- Estimate: average of the pet's last 4 cycles; entries within a week of another are treated as duplicates; until there are 2 records, the typical cycle for the species (admin setting); heat length from the pet's records or typical. Past estimates without a record are skipped to the next one.
- Reminders: on/off and 1 / 3 / 7 / 14 days before; the app stores the next expected start in `heatReminders/{petId}` (kept in step when records change); the daily `heatReminderSweep` (09:00 Rome) sends the push in the owner's language and plans the next cycle; missed days are skipped, never sent late. Reminders keep coming without opening the app.
- Admin → More → Heat calendar: show to users (saves straight away; admins see it while off), typical cycle and heat length for dogs (180 / 18), cats (21 / 7), other animals (0 = no estimate until 2 records / 7).
- Private: only the owner reads or writes their pets' heats and reminders (not even admins); removed when the pet or the account is deleted.
- 48 texts in 10 languages (calore, Läufigkeit, chaleurs, celo, cio, течка…) + server push texts in 10 languages; 11 app tests, 4 server tests, 32 emulator checks; test plan `TEST_SCENARIO_HEAT_2026-11-04.md`.

**Left**
- Deploy functions and rules, phone test, client answer on which other animals (the "other" typical cycle can be set in Admin meanwhile).

**Planned (kept for reference)**

**Already there**
- Nothing for cycles. Uses the schedule and reminders of request 4.

**To build**
- Per pet (female only): add start and end of each cycle, notes; history list.
- Estimate of next cycles from the average of past cycles; species default when there are fewer than 2 records (dog about 6 months, cat a few weeks in season; other species from the client's list).
- Estimated periods shown on the calendar in a different colour; "estimate" note.
- Reminders X days before (customizable).
- Private, deleted with the account.

## 6. AI breed scanner (request 1): built Wed 4 Nov

**Built**
- Server: `scanBreed` (`functions/src/scannerFunctions.ts`, logic in `scanner.ts`): checks sign-in, the off switch (admins can try it while off), the photo (real JPEG / PNG / WebP / HEIC, up to 4 MB, type read from the file), the daily limit (`scanUsage/{uid}`, failed scans don't count), then asks Gemini on Vertex AI (global endpoint, the project's own service account, no API key) for species, up to 4 breeds with %, mixed, photo quality, facts and a note in the user's language, with a fixed JSON schema. The answer is cleaned (breeds sorted, % capped to 100 in total, text lengths limited) before it reaches the app. The photo isn't stored anywhere; only the day and the count are kept.
- Settings `config/scanner` (Admin → More → Breed scanner): show to users, scans per user per day (1-100, default 10), AI model picked from a list (`scannerModels`, admins only: Google's live list of Gemini models, keeping only released models that can read a photo, newest first, each marked cheapest / fast and accurate / most accurate; the usual models if Google's list can't be read; a warning if the chosen model is no longer listed). Default `gemini-3.8-flash`, Google's current model supported until at least Sep 2027. "Try the scanner". Rules: admins only, Gemini model names only.
- App: a "Which breed is it?" card at the top of the Pets tab and Profile → Breed scanner (both only when on); intro with 3 photo tips, camera or gallery (photo made smaller on the phone first), result with species chip, mixed-breed chip, most likely breed with % and bar, "Very likely / Likely / Not sure", other breeds, unclear-photo warning, AI note, facts (size, weight, life span, temperament, characteristics, care), AI estimate note; "No animal found"; "Try another photo"; "Save breed to my pet" (pet chooser, same species first; mixes saved as "A × B"); in the pet form "Find the breed with AI" → "Use this breed".
- 52 texts in 10 languages; 7 app tests, 7 server tests, 26 emulator checks; test plan `TEST_SCENARIO_SCANNER_2026-11-04.md`.

**Left**
- Enable the Vertex AI API, deploy functions and rules, phone test with real photos (accuracy check per species), then switch it on for users.

**Planned (kept for reference)**

**Already there**
- Photo upload and Cloud Vision photo moderation (`moderation.ts`); no breed AI.

**To build**
- Take a photo or pick from the gallery.
- Server function sends the photo to an AI vision model (Google Gemini on the same Firebase project), asks for species, top breed, alternatives with confidence %, mixed / crossbreed.
- Accuracy: the best available vision model, checked on a set of sample photos per species (pure breeds, mixes, cats, other animals) before release; photo tips (whole animal, good light, one animal) and "Try another photo" to compare.
- Result screen: main breed, other possible breeds with %, mixed breed note, breed info (size, weight, temperament, care, life span) in the user's language.
- "This is an AI estimate, not a guarantee" always shown; low confidence shown clearly; no animal found → message.
- Daily scans per user and on/off in Admin; photos not kept after the scan.
- "Save breed to my pet" button.

## 7. Titles and achievements (request 8): built Fri 6 Nov

**Already there**
- Points and levels for invites: Supporter (1 friend), Ambassador (5), Super Ambassador (15), Champion (30), with bonus points (`config/points`).
- Donation screens (switched off), no payments yet.

**To build**
- Tags and titles with levels: Community Contributor, Animal Rescuer, Active Volunteer, Animal Advocate, Community Helper, Trusted Member, Verified Pet Sitter (after request 3).
- Several levels per title (for example Animal Rescuer I, II, III), each with its own milestone.
- Rules from real actions counted by the server (reports, pets found, sightings, invites, petitions, active days, completed pet sittings).
- Achievements page: all titles, locked ones, requirements and progress bar to the next.
- Main title shown on the profile and next to the name; the user picks which one.
- Donor titles (Supporter, Bronze, Silver, Gold, Platinum, Lifetime) from the total donated, automatic, once donation payments exist.
- Admin: thresholds and on/off per title.
- Notification when a title is unlocked.

**Client answers (Fri 6 Nov):** numbers as suggested; donor totals €10 / €25 / €50 / €100 / €250 (any donation = Supporter, counted on what the user paid, kept unless a donation is deleted); first invite level renamed "Friend of CodaMi"; bonus points 10 / 25 / 50 per level, none for donor or invite titles.

**Built (Fri 6 Nov)**
- Server (`titles.ts`, `titlesFunctions.ts`): `refreshTitles(uid)` counts from the real records (reports minus hidden, found reports home + resolved emergencies owned or helped, "I'm helping", shares max 3 a day, feedback marked done, active days, pet sittings with 4★ average, invites, donations total) and is called on visits, reports created/resolved, emergency help/resolve, shares, feedback done, sitting confirmed/reviewed, admin changes. Activity levels are kept; Trusted Member (nothing removed in 90 days), Verified Pet Sitter and donor follow the current record. Bonus points once per level (`paid`), push for new titles (account notice), public `publicProfiles/{uid}` with the main title and 3 tags. Callables: `refreshMyTitles` (30 s wait), `setTitlePrefs` (main title, hide donor), `adminSetTitle` (give / take away / allow again; Team and Partner Shelter given by hand only), `adminRecordDonation`, `adminDeleteDonation`. Off by default (`config/titles`); while off it counts but gives no points or pushes.
- App (`lib/features/titles/`): My achievements (main title card, next goal, all titles with stars, progress and how to unlock, levels sheet, choose main title, donor tiers with private total and show/hide), celebration window once per new title, push opens the page, title chips on Profile, reports, sitter profiles, offers and requests. Admin → More → Titles and achievements (on/off, numbers per level, per-title switch with holders count, bonus points, donor totals); Titles box on the admin user page (give / take away, record and delete donations).
- 86 texts in 10 languages + server names and push texts in 10 languages; tests: `test/titles_test.dart`, `functions/src/titles.test.ts`, `emulator_tests/titles.cjs`; phone test `TEST_SCENARIO_TITLES_2026-11-06.md`.
- In-app donations: once store payments exist, the payment check writes to `donations` (source `play` / `apple`) and calls `refreshTitles`.

## 8. Pet sitting (request 3): built Wed 4 Nov

**Built**
- Part 1, requests and profiles: Pet sitting section (Pets tab card, Profile row; on/off in Admin, admins see it while off) with tabs Requests / Sitters / Mine and distance (5-50 km) and species filters. Requests: pets, service (home visits, overnight at home, walks, daycare, stay at the sitter's), dates, details, optional budget; only the city is stored and shown (rounded position, never an address). Sitter profiles: about, experience, animals, services, availability, distance, show / pause. Offers with message and optional price; the owner accepts one (server books it and declines the others) or declines; the sitter can withdraw; the owner can close or cancel.
- Part 2, chat: private chat between two users from an offer, a request or a profile; unread count on the chat icon and the Pets card; push for each message, new offer, accepted offer and confirmation (owner's language); report and block in the chat; a blocked user can't message, offer or be seen. Messages are paged: live only the newest 20, older pages of 20 read once when scrolling up (`chatPageSize` in `sitting_repository.dart`).
- Fixes after the first phone test (Wed 4 Nov): spinners on Accept, Decline, Close / Cancel, Withdraw and "Yes, it was done", and on Send in the offer and review forms (errors shown inside the form); faster booking (other offers declined in the same transaction; "accepted" and "please confirm" pushes sent by the background trigger `onSittingRequestUpdated`); the avatar letter in chat was invisible on the green ring and now has a solid background; pet sitting uses only the app theme colours, the light top bar and the standard tabs.
- Part 3, verified reviews and moderation: after the start date both sides confirm the service; only then the owner can leave one review (1-5 stars + text), written by the server only; new accounts wait N days (Admin, default 3); rating and completed count kept by the server; "Verified service" label. Report requests, profiles, reviews and chats; Admin → More → Pet sitting: Settings, Reported (hide / dismiss), Requests, Sitters, Reviews (hide / show; hiding a review updates the rating).
- Safety note on the section, the forms and in every chat ("CodaMi connects people…, agree on payment directly, never pay in advance"). Payment between users outside the app.
- Private and clean: chats readable only by the two members (not even admins); everything removed with the account.
- 138 texts in 10 languages + server push texts in 10 languages; 7 app tests, 7 server tests, 74 emulator checks; test plan `TEST_SCENARIO_SITTING_2026-11-04.md`.

**Not in this version (ask the client)**
- Payment through the app; photos in chat; a separate switch for chat notifications (for now: block, or the phone's settings); owners reviewed by sitters (now only sitters are reviewed); tapping a notification opens the app, not the chat.
- Terms for pet sitting: a short text for the client to check (the in-app safety note is there).

**Left**
- Deploy functions, rules and indexes, two-phone test, then switch on for users.

**Planned (kept for reference)**

**Already there**
- Accounts, city, pets, report contact (phone, WhatsApp, email), support chat between user and operator (not between users), report and block parts of moderation.

**To build**
- Pet sitting section: requests (dates, place, animals, notes) and sitter profiles (experience, availability, area, animals, photo, about).
- Browse and filter by area, dates and species; offer on a request.
- Chat between users in the app, with report and block.
- Both sides confirm the service is done; only then each can leave one verified review (stars + text).
- Reviews: report button, admin hide / remove, limits against fake reviews.
- Admin: requests, profiles, reports, reviews, on/off.
- Notifications: new offer, message, confirmation, review.
- Payment between users outside the app (first version), terms and safety notes.

## 9. General principles (request 9)

Followed already: speed, no breaking changes (tests on every build), same design, 10 languages, privacy, settings in the admin panel, ready to grow.

For every feature above, still to do as part of it:
- Texts in the 10 languages (right-to-left for Arabic).
- On/off and settings in the admin panel.
- Firestore rules: users only see their own private data (schedule, cycles, scans); deleted with the account.
- App tests, server tests, emulator checks and a phone test scenario.
- Privacy policy and Data safety updated (`LAUNCH_CHECKLIST.md` §6).
- Server queries with limits and paging, so it stays fast as users grow.

---

## Questions for the client (sent Tue 3 Nov)

- Pet sitting: payment between users outside the app (recommended for now), or through the app?
- AI scanner: OK with a small cost per scan (less than 1 cent) and a daily limit?
- Heat calendar: which animals besides dogs and cats?
- Donor titles: amounts for Bronze, Silver, Gold, Platinum, Lifetime?
- Is the suggested order OK?
