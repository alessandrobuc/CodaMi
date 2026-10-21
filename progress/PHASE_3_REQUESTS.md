# CodaMi: Phase 3 Requests

New feature requests from the client (received Wed 21 Oct 2026), what already exists, and the proposed approach. Scope is still to be agreed with the client before work starts. Open questions are in `WAITING_FOR_CLIENT.md`.

_Last updated: Wed 21 Oct 2026 (moderation built)_

| # | Request | Status | Size |
|---|---|---|---|
| 1 | AI-powered image moderation | Built (Wed 21 Oct), to deploy and test with real photos | Medium |
| 2 | Referral system with points | Waiting for answers | Medium |
| 3 | Emergency management | Waiting for answers ("in the future") | Large |

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

## 2. Referral system

**Request:** users invite friends and earn points when the invited person registers, completes their account, and actively uses the app.

**Already there:** nothing. Accounts are created with Google, Apple or email.

**Proposed approach**
- Each user gets a personal **invite code** and a share button (link plus code), shown in the profile.
- The invited person enters the code during sign-up. On Android, the code can also be read automatically from the Play Store install (Play Install Referrer), so they don't need to type it. Firebase Dynamic Links no longer exist (shut down in August 2025), so links need another approach or a paid service (for example Branch).
- Points are given by Cloud Functions only (never by the app), at each step: registers, completes the account, actively uses the app. Each step is counted once per invited person.
- `referrals/{id}` records who invited whom and which steps are done; points are kept on the user's profile.
- Basic protection against fake accounts: a limit on points per day, no points for invites from the same device, and points for "active use" only after a few days.
- A **My invites** screen: code, share button, invited friends and their progress, and points.

**Notes**
- If points can be swapped for prizes, money or discounts, Italian prize promotion rules (DPR 430/2001) and taxes may apply. Badges and rankings only avoid this.
- The store privacy forms may need updating.

## 3. Emergency management

**Request (future):** features for animal emergencies (injured, in danger, abandoned, found in urgent situations, requests for intervention), with quick contact with services and animal welfare organizations. The app must clearly separate an **Emergency** (immediate need) from a **Regular report** (not urgent).

**Already there**
- Lost and found reports with photo, location (blurred within 100 m), map pins and city alerts.
- Push notifications with per-type sounds and on/off switches.

**Proposed approach**
- A new **Emergency** report type, started from a clear red button, with a short form: type of emergency, photo, exact location (not blurred, since helpers need to find the animal) and a note.
- Emergencies stand out everywhere: red pins on the map, at the top of the lists, and their own notification type with a distinct sound.
- An **Emergency contacts** screen: services and organizations near the user's city, with call and directions buttons. Contacts are managed by admins in the admin side.
- The case shows its progress: reported, someone is on the way, handled.
- A clear notice before sending: "If the animal is in immediate danger, call 112 or a vet first."
- Staff can see and close emergencies, and act on fake ones.

**Notes**
- The list of services and organizations is the hardest part: the client needs to provide and update it.
- Partner organization accounts (receiving cases directly) would be a large extra feature.
