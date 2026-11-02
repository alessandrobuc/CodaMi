# CodaMi: Phase 4 Requests

New requests from the client (received Mon 2 Nov 2026): QR invitations, voluntary donations, places to walk with pets. The plan was sent the same day; the developer said go for the QR codes and places to walk, and the donation screens (switched off) until the store payment setup is done.

_Last updated: Mon 2 Nov 2026 (built; hosting, functions and rules to deploy)_

| # | Request | Status | Size |
|---|---|---|---|
| 1 | Unique invitations with QR codes | Built (Mon 2 Nov), to deploy and test | Small |
| 2 | Voluntary donations | Screens built (Mon 2 Nov), switched off; payments later (store setup by the client) | Small (screens) + Medium (payments) |
| 3 | Places to walk with pets (Google Maps) | Built (Mon 2 Nov), to deploy and test with the real Google key | Medium |

---

## 1. Invitations with QR codes

**Already there:** unique 6-character invite code per user, Invite friends screen with share, Play Store link with the code (`referrer`) that fills the code in on Android.

**Plan**
- Personal QR code on the Invite friends screen.
- The QR opens a small CodaMi invite page on Firebase Hosting (`https://codami-cd91e.web.app/i/<CODE>`): Android goes to Google Play with the code, iPhone to the App Store (once the App Store ID exists); the page also shows the code in large letters.
- Save or share the QR alone and a ready flyer image (logo, short text, QR, code).
- Same referral rules, points and anti-fraud checks as now.

## 2. Voluntary donations

**Store rules:** CodaMi is not a registered charity, so in-app donations must use Google Play Billing and Apple In-App Purchase (fixed amounts, about 15% store fee, wording "Support CodaMi"). Stripe and PayPal are only for the shop.

**Plan**
- Places: Profile row, a "Support CodaMi" page (what the money is used for), a card after a report is published (never before), a thank-you sheet when a pet is marked found / resolved.
- Always optional, "Not now" always visible, at most once every N days.
- No points or advantages for donating; optional "Supporter" badge if the client wants it.
- Admin: on/off, each place on/off, how often, preview; totals once payments exist.
- Built switched off; payments connected after the client's store setup.

## 3. Places to walk with pets

**Plan**
- Google Places finds dog parks, parks, green areas and gardens, trails and nature parks around the user's location (or their city), within 1 / 3 / 5 / 10 / 25 km.
- Map and list, filter by type; each place: name, address, distance; on tap, rating, opening hours, open now, "dogs allowed" when Google has it, phone, website, Directions.
- Searches go through our server (the Google key never reaches the app), with a daily limit per user. Results are kept only for a short time, as Google's terms allow.
- Admin: on/off, default distance, place types, hide a place, daily limit.

## What was built (Mon 2 Nov)

**1. QR invites**
- Invite friends: the QR next to the code, opening **QR code and flyer**: the QR alone (white card with the code) or an A-size flyer (logo, title, short text, QR, invite code, "Free app"), each saved to the phone's photos (`gal`) or shared as an image with the invite text.
- The QR and the share text now use `https://codami-cd91e.web.app/i/<CODE>` (`hosting/invite.html`, Firebase Hosting, rewrite `/i/**`). The page reads the code from the link, shows it in large letters in the visitor's language (10 languages), opens Google Play with `referrer=<CODE>` on Android after a moment, shows the App Store button once `config/appVersion.appStoreId` is set, and both buttons on a computer. `hosting/index.html` is a simple home page.
- The code box also understands the new link. iPhone: "Save to photos" permission text added in 10 languages; Android 9 and older: storage permission up to API 28.
- Same referral rules and points as before; nothing changed on the server.

**2. Donations (switched off)**
- `config/donations`: on/off, Profile row, after a report, after a found pet, days between messages (30), amounts in cents (€1, 3, 5, 10, 25), `paymentsReady` (only settable from the console; false until store products exist).
- **Support CodaMi** page: header, the seven uses, amount chips, "Support with €5" (shows "payments coming soon" until `paymentsReady`), fine print (store payment, not a charity, no advantages).
- Prompt sheet after a report is published (after the publish, never before) and after a pet is marked found / resolved; "Not now", at most once every N days per phone.
- Admin → More → **Support CodaMi**: switches, days, amounts, preview, and a note that store payments aren't connected.
- No points or badge for donating.

**3. Places to walk**
- Server (`functions/src/walks.ts`, `walksFunctions.ts`): `findWalkPlaces` (Places API (New) Nearby Search: one search for dog parks and one for parks, nature parks, gardens and trails, 20 results each, ranked by distance, only id / name / address / location / types) and `walkPlaceDetails` (Place Details with rating, opening hours, open now, phone, website, "allows dogs", one photo through the photo media endpoint). Uses the existing `PLACES_API_KEY`.
- Costs: about 2 Nearby Search requests per search and 2 requests (details + photo) per opened place. Results are kept in the server's memory for 30 minutes (searches from points about 1 km apart share them); nothing from Google is stored in the database. Daily limits per user (40 searches, 60 details) counted in `walkUsage/{uid}` before Google is called.
- `config/walks`: on/off (off by default), default distance, place types, hidden places (with names), daily limits. Admins can use the section while it's off.
- App: **Places to walk** (Profile row and a park button on the Home map, both only when on): type chips, distance chips (1 / 3 / 5 / 10 / 25 km), map with coloured pins and the radius circle or a list, "Search this area" after moving the map, near you or near your city (when location is refused); place sheet with photo and author, rating, open now, dogs allowed, opening hours, Directions on foot, Call, Website, "Places data from Google", and **Hide this place** for admins.
- Admin → More → **Places to walk**: on/off, distance, types, limits, hidden places with "Show again", and a button to open the section.

**Tests:** 7 new app tests (115 in total), 7 new server tests (75 in total), 23 new emulator checks (`emulator_tests/phase4.cjs`); the earlier shop, petition, app version and feedback checks still pass.

## Questions sent to the client (Mon 2 Nov)

- [ ] QR: invite page on the Firebase address OK for now? Fixed flyer text, which language? "Scan QR" button in the app?
- [ ] Donations: store payment (about 15% fee) OK? Amounts? Payments profile in Play Console (client); Apple Developer account for iPhone; "Supporter" badge? Accountant check (CodaMi is not a nonprofit)
- [ ] Places to walk: where in the app? Default distance (5 km suggested)? Google cost OK with a budget alert?
