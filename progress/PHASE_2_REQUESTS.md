# CodaMi: Phase 2 Requests

The client's new feature requests (received Thu 15 Oct 2026), what already exists, and the proposed approach. Scope is still to be agreed with the client before work starts.

## Decisions (Thu 15 Oct)
- **Admin side inside the same app, fully separate from the user side.** After login, `AuthWrapper` reads the role: admins and support staff go to the **admin side** with its own navigation bar and screens; everyone else goes to the normal app.
- **Roles:** a `role` field on each user's profile (`users/{userId}`): `user` (default when missing), `support` or `admin`. The first admin is set once by hand in the Firebase console. Admins then add or remove support staff from inside the app.
- **Reward:** a private arrangement between users. CodaMi does not guarantee or process the payment.
- **Donations:** the interface is built first; the payment integration is decided by the client after reviewing the options below. CodaMi is not a registered nonprofit, so in-app payments must use Google Play Billing and Apple In-App Purchase.
- **Videos are uploaded and managed by admins** from the admin section of the app.

_Last updated: Mon 19 Oct 2026 (client clarified 3, 5 and 7; work started on 3 and 5)_

| # | Request | Status | Size |
|---|---|---|---|
| 1 | Language selection on first launch | Done (Thu 15 Oct) | Small |
| 2 | Administrative dashboard | Mostly done (roles, dashboard, support staff, reported content, listings, users, videos). Tickets left | Large |
| 3 | Customizable notifications (per-type sounds, phone sounds) | Built (Mon 19 Oct), to test on real phones. iPhone custom files left | Medium |
| 4 | Optional cash reward on lost listings | Done (Thu 15 Oct) | Small |
| 5 | Random videos based on the user's pets | Built (Mon 19 Oct), to test with real videos. YouTube links left | Medium |
| 6 | Optional donations | Not started | Small (interface) + Medium (payments) |
| 7 | Live chat, tickets and operator monitoring | Not started | Large |

---

## 1. Language selection on first launch

**Already done**
- [x] All 10 languages, each shown in its own name with a flag
- [x] Choice saved on the phone and on the user's profile, kept between launches
- [x] Change it later in Profile → Language
- [x] Every screen, button, error message, phone notification, share text and legal page translated; notifications sent in each user's language

- [x] Full-screen language picker with a **Continue** button, shown once on first launch before onboarding. Tapping a language previews it straight away. Existing users who already chose a language do not see it again.

## 2. Administrative dashboard

**Done (Thu 15 Oct)**
- [x] `role` on `users/{userId}`; missing means `user`. New accounts are saved with `role: user`.
- [x] Firestore rules: nobody can change their own role; admins can only switch other users between `user` and `support` and cannot touch any other field; admins can never be created or removed from the app; only admins can read other users' profiles (31 rule checks pass in the emulator)
- [x] `AuthWrapper` sends staff to the **admin side** (`AdminShell`) and everyone else to the user app. A role change takes effect live.
- [x] Admin side navigation: **Dashboard**, **Listings** (admin only), **Reported**, **Tickets**, **More**
- [x] Dashboard: registered users (admin only), open lost reports, open found reports, pets back home
- [x] More: **Support staff** (admin only: add by email, list, remove), Users and Videos (soon), language, sign out
**Done (Fri 16 Oct)**
- [x] In-app **report a listing** (reason + optional note, once per user) and **block a user** (listings and alerts hidden, Profile → Blocked users)
- [x] **Reported** tab (staff): reports grouped per listing; dismiss, hide or (admin) delete
- [x] **Listings** tab (admin): Open / Resolved / Hidden filters; hide, restore, delete
- [x] **Users** (admin): list, search by email, details, disable / enable (server function, also hides and restores their open listings), delete (server function)
- [x] Rules: `flags` collection, staff hide/restore, admin delete, protected `disabled` field (32 rule checks pass in the emulator)
- [x] Videos screen (Mon 19 Oct, see 5)
- [ ] Tickets screen (marked "Soon", see 7)

**First admin:** Firebase console → Firestore → `users` → your user document → add field `role` (string) = `admin`.

**Approach (decided: same app, role-based navigation)**
- **Role** stored on the user profile (`users/{userId}.role`), protected by the rules so users can never change it themselves.
- **Admins add support staff** from the admin side (search a user by email, set or remove the support role). New admins are added only in the console, so an admin account can never be taken over through the app.
- The role is checked in Firestore rules (and later Storage rules and Cloud Functions), so hiding screens is not the only protection.
- `support` role: tickets and live chat. `admin` role: everything, including users, listings and videos.
- Screens: users (view, disable, delete), listings (view status, edit, hide, remove), reported content queue, support tickets and chat (see 7), videos (see 5)
- Store review: Apple and Google reviewers sign in with a normal account, so admin screens are never shown to them. No extra store forms needed.
- Needs **in-app report / block** first (also required by Apple guideline 1.2 and expected by Google Play)

## 3. Customizable notifications

**Client clarification (Mon 19 Oct):** a different sound per notification type, including music, custom tones or other sounds on the phone. Settings must be simple to use.

**Already there:** all notifications use the phone's default sound. Types today: `new_report`, `report_resolved`.

**Done (Mon 19 Oct)**
- [x] Profile → **Notifications**: Lost pets nearby, Found pets nearby, Happy endings. Each has an on/off switch and its own sound, with a preview when tapped
- [x] Sounds: phone default, silent, 4 CodaMi sounds (Chime, Bell, Bright, Soft); on Android also phone ringtones and tones and any music or audio file (Android 10+)
- [x] Android: one channel per type, created in `MainActivity.kt`; a new channel is made when the sound changes and the old one is deleted. Picked audio files are copied to `Notifications/CodaMi` so the system can play them
- [x] iPhone: the 4 CodaMi sounds are copied to `Library/Sounds` at launch (`AppDelegate.swift`) and sent as the alert sound
- [x] Server: skips the phone alert for turned-off types (still listed in the app's notifications) and sends each user's channel and sound. Old app versions keep using `codami_alerts`
- [x] Rules: `notificationPrefs` only accepts `lost`, `found`, `resolved`. Unit tests and function tests pass
- [x] Tested on a real Android phone (Mon 19 Oct): works
- [ ] Test on a real iPhone (CodaMi sounds; app open, in the background and closed) once the client gives access to the Apple account
- [ ] iPhone audio files from Files (convert and trim to 30 s) once the client accepts Apple's limits
- [ ] Support reply notifications get their own type when 7 is built

**Proposed approach**
- Profile → **Notifications** screen: one row per type (new lost/found pet nearby, report resolved, support reply, app news), each with an on/off switch, a sound and a preview button
- Sound choices: **Default**, **Silent**, 4–6 CodaMi sounds bundled in the app, and **Choose from phone**
- Preferences saved on `users/{userId}.notificationPrefs`. Cloud Functions read them and skip disabled types; they send the right Android channel and iOS sound with each push.
- **Android:** the system ringtone/notification picker plus any audio file. One channel per type. A channel's sound cannot change after it is created, so a new sound means deleting the channel and creating a new versioned one (`support_reply_v3`). The current channel id is stored on the profile for the server. Needs `flutter_local_notifications` plus a small native piece for the system sound picker.
- **iOS limits (tell the client):** iOS only plays sounds that are stored inside the app, are 30 seconds or less, and are AIFF/WAV/CAF files. Users can pick an audio file from the Files app; the app converts it, trims it to 30 s and saves it in `Library/Sounds`. Apple does not allow access to system ringtones or Apple Music songs (DRM).

## 4. Optional cash reward on lost listings

**Done (Thu 15 Oct)**
- Optional **amount in euros** (whole euros, up to 99,999) on the "Details" step of a **lost** report; empty means no reward. Checked by the Firestore rules too.
- Shown as a badge on the listing card, a badge and a "Reward" card on the report page, in the review step and in the share text. Formatted for the app language (€1,500 / 1.500 €).
- Clear note: "The reward is a private arrangement between users. CodaMi does not guarantee or process payments."
- Hidden automatically when the report is marked as found
- CodaMi never handles money, so there are no payment or licensing obligations
- Re-check the Play content rating answer about cash rewards before release

## 5. Random videos based on the user's pets

**Client clarification (Mon 19 Oct):** random motivational and educational videos that match the species of the user's registered pets (dog → dog videos, and so on). Users with no pets see general videos about animal welfare and responsible ownership. The content should change over time.

**Already there:** nothing. Pets have `species`: `dog`, `cat` or `other`.

**Done (Mon 19 Oct)**
- [x] Admin side → More → **Videos** (admin only): upload from the gallery (up to 200 MB) with an optional cover image and upload progress, title, type (Motivation / Learn), animals (dog, cat, other, everyone), language (one or all), visible switch. Edit, hide / show, delete (removes the files too), play
- [x] `videos` collection and `videos/{id}/` in Storage; only admins can write, users only see visible videos (25 rule checks pass in the emulator)
- [x] New **Videos** tab in the user app (Home, Pets, Videos, Profile), moved out of the Pets tab on Mon 19 Oct so it is always visible:
  - a large featured video, then "More videos"
  - All / Motivation / Learn filters
  - about 70% about the user's animals and 30% for everyone; with no pets, only "everyone" videos
  - videos in the app language (or all languages) first; recently watched ones (last 30, kept on the phone) go last and show "Watched"
  - new mix every launch, a shuffle button and pull down to shuffle
  - a friendly "Videos are on the way" screen while there are none
- [x] Video player:
  - controls hide after 3 s and come back on tap
  - spinner while loading, buffering or seeking
  - back / forward 10 s
  - seek bar showing the buffered part and the time while dragging
  - full screen in landscape
  - Retry when a video fails
- [x] Admin Videos list and form redesigned:
  - the list has filters (All / Visible / Hidden with counts) and simple cards: cover, type, title, animals and language, a "Hidden" badge, and a play / edit / delete menu. Visibility is changed in the edit screen
  - the form has sections, a preview of the picked video, type cards and animal tiles
  - the cover image of an existing video can be changed or removed when editing (new file name each time, so phones don't keep showing the old one)
- [x] Every new screen in all 10 languages
- [ ] Test with real videos (the client to provide a first set, with the rights to use them)
- [ ] YouTube links as a second source (the `source` field is ready)

**Proposed approach**
- **Admins upload videos from the admin section** (decided). Files go to Firebase Storage. Each video gets a `videos/{id}` entry with title, type (`motivational` / `educational`), `species` tags (`dog`, `cat`, `other`, `general`), languages, thumbnail, duration and an active flag. Content changes never need a new app version.
- Selection runs in the app: read the user's pet species, load active videos tagged with those species or `general`, then do a weighted random pick (about 70% matching species, 30% general). Videos watched recently (kept on the phone) are skipped until the pool runs out. With no pets, only `general` videos are used.
- Option to keep storage costs down: admins can paste a YouTube link instead of uploading a file
- Admins can hide, reorder or delete videos at any time
- A few test videos at first, rotated between sessions
- Shown only in calm places (for example the home list or a "Learn" card), never during report creation or contact flows
- Support prompts shown occasionally (for example at most once a week), always easy to dismiss

**Notes**
- Keep videos short (under 2 minutes) and compressed (720p). Firebase Storage charges for every view, so a budget alert is important.
- The client is responsible for having the rights to every uploaded video.

## 6. Optional donations

**Already there:** nothing.

**Interface (built first)**
- A friendly "Support CodaMi" prompt after publishing a report and after marking a pet as found, with **Not now** always visible. Never blocks the main action.
- Kept behind an on/off switch (Firestore config) and **off in the store build** until payments are connected, so users and store reviewers never see a button that does nothing.

**Payment integration (client to decide)**
- Because CodaMi is not a registered nonprofit, payments made inside the app must use **Google Play Billing** (Android) and **Apple In-App Purchase** (iOS), as one-time "support CodaMi" tips (for example €2 / €5 / €10). Built with the official `in_app_purchase` Flutter package. Stripe or PayPal links inside the app are not allowed for this.
- Store fees: 15% under the small developer programmes (Google: first $1M per year; Apple: Small Business Program, must apply), otherwise 30%.
- Setup: payments profile in Play Console, Paid Apps agreement on App Store Connect, tax and bank details, products created in both stores.
- Wording would have to say "support the app", not "charity" or "donation to animals".
- It would change the Data safety form and App Store privacy labels.

- Amounts must be **set in advance** as store products (users cannot type their own amount). Offer 4–5 choices, for example €1, €3, €5, €10, €25, using Apple's price points (€0.99, €2.99, €4.99, €9.99, €24.99). Products are consumable, so the same user can give again.

**Question for the client:** go ahead with store payments? If yes, which amounts?

## 7. Live chat, tickets and operator monitoring

**Client clarification (Mon 19 Oct):** live chat in the Support section. The admin panel must show the operator assigned to each case, operator activity and performance, timings (opened, taken over, time spent), status (open, in progress, waiting for response, resolved, closed), the full message history, unanswered requests, and each operator's cases and response times.

**Already there:** a **Contact us** button on the legal pages that opens an email. A `support` role and the **Support staff** screen. A **Tickets** tab marked "Soon".

**Data model**
- `supportCases/{id}`
  - Basic fields: `kind` (`chat` / `ticket`), reference number `CM-1042` (counter in a transaction), userId, subject, category, language
  - Status: `open`, `in_progress`, `waiting_user`, `resolved`, `closed`
  - Assignment: `assignedTo`, `assignedAt`
  - Timestamps: `createdAt`, `firstResponseAt`, `lastUserMessageAt`, `lastStaffMessageAt`, `resolvedAt`, `closedAt`
  - `awaitingStaff` flag
- `supportCases/{id}/messages`: sender, role, text, attachments, `createdAt`. Users and staff write messages through the rules, which check the sender.
- `supportCases/{id}/events`: an audit trail that cannot be changed (created, taken, reassigned, status change, who did it and when). Only Cloud Functions write it.
- `staffPresence/{uid}`: online/away/offline and last seen. Live chat is offered only while at least one operator is online; otherwise the app offers a ticket.

**Server (Cloud Functions)**
- Callables for take over, reassign (admin only), change status and close. Each runs in a transaction, so two operators cannot take the same case, and each writes an event.
- Message trigger:
  - User message: set `awaitingStaff`; reopen if the case was resolved
  - First staff reply: set `firstResponseAt`
  - Staff reply: status becomes `waiting_user`
  - Push the other side
- Scheduled check every 10 min:
  - Push admins about unassigned cases and cases with no reply past their time limit
  - Auto-close cases left `resolved` for 7 days
- Times measured: wait to takeover (`assignedAt − createdAt`), first response time, handling time (`resolvedAt − assignedAt`). They come from server timestamps, so operators cannot change them.

**Admin side screens**
- **Tickets** tab:
  - Filters: Unassigned, Mine, Unanswered, All
  - Search by reference number or email
  - Each row shows status, assigned operator and waiting time
- **Case screen:** the chat thread, a timeline of events, and take/reassign/status buttons
- **Operators** screen (admin):
  - Per operator: online status, open cases, cases handled, average first response time, average handling time
  - Opening an operator lists their cases
- **Dashboard:** counts of open, unanswered and unassigned cases

**User side:** Profile → **Help & support**
- Start a live chat or create a ticket
- My requests, each with its status and the full history
- Push notification when support replies

**Questions for the client:**
- Who answers, in which languages, and during which hours?
- Time limits for "unanswered": for example 5 min for chat, 24 h for tickets
- Auto-close after 7 days?
- Admin panel only in the app, or also as a web page for desktop use? The admin side can be built for Flutter web.

---

## Suggested order

1. ~~Language screen on first launch~~ (done)
2. ~~Optional reward~~ (done)
3. ~~Roles and role-based navigation, plus in-app report / block~~ (done)
4. ~~Admin section: listings, reported content, users~~ (done)
5. Videos: admin upload and videos for you (built Mon 19 Oct); YouTube links and support prompts later
6. Notification settings and sounds (built Mon 19 Oct); iPhone audio files after the client replies
7. Support tickets, live chat and operator monitoring
8. Donation interface, then store payments once the client decides and sets up the payment profiles
