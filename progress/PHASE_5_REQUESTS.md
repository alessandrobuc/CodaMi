# CodaMi: Phase 5 Requests

New features from the client (received Tue 3 Nov 2026). The plan was sent the same day. Go-ahead given Wed 4 Nov (no fixed order). Built: the AI breed scanner (§6). Everything else below is still to do.

_Last updated: Wed 4 Nov 2026 (go-ahead given; AI breed scanner built Wed 4 Nov, to deploy and test; the rest not started)_

| Order | # | Request | Already in the app | Status | Size |
|---|---|---|---|---|---|
| 1 | 7 | Feedback: store reviews + internal feedback | Mostly | Not started | Small (about 1 day) |
| 2 | 5 | Social sharing of reports | Partly (text share) | Not started | Medium (about 2 days) |
| 3 | 6 | Recurring share reminders | No | Not started | Small (about half a day) |
| 4 | 4 | Personal schedule, notes and reminders | No | Not started | Medium (2 to 3 days) |
| 5 | 2 | Heat cycle calendar | No | Not started | Medium (about 2 days) |
| 6 | 1 | AI breed scanner | No (only photo moderation) | **Built Wed 4 Nov**, to deploy and test | Medium (2 to 3 days) |
| 7 | 8 | Profile tags, titles and achievements | Partly (invite levels) | Not started | Medium (about 3 days) |
| 8 | 3 | Pet sitting marketplace | No | Not started | Large (6 to 8 days) |
| - | 9 | General principles | Followed already | - | - |

Total: about 19 to 22 working days, one feature at a time, each tested and sent to the client when done.

---

## 1. Feedback (request 7)

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

## 2. Social sharing (request 5)

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

## 3. Share reminders (request 6)

**Already there**
- Push notifications (`firebase_messaging`, `push_service.dart`), Profile → Notifications switches, daily server sweep.

**To build**
- Notification with the client's text, opens the share sheet for the app (invite link with the user's code).
- First after X days from sign-up, then about every 7 days (Admin settings), stop after a set number.
- Never on the same day as other promo prompts; skipped for users who shared recently.
- Switch in Profile → Notifications; on/off in Admin.
- Text in 10 languages.

## 4. Personal schedule, notes and reminders (request 4)

**Already there**
- Pets with species, breed, sex, age (`pets_entity.dart`); push notifications.

**To build**
- Schedule screen: month / list view, filter by pet.
- Event types: note, appointment, vet, vaccine, medicine, grooming, feeding, other.
- Date, time, pet, notes, repeat (daily, weekly, monthly, yearly, custom), reminder time before.
- Edit, mark done, skip one, delete one or the series; history.
- Reminders arrive like push notifications, also with the app closed (scheduled on the phone so they work offline, kept in sync with Firestore; set again on a new phone after sign-in).
- Private: only the owner can read (rules); deleted with the account.

## 5. Heat calendar (request 2)

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

## 7. Titles and achievements (request 8)

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

## 8. Pet sitting (request 3)

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
