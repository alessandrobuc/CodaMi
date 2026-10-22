# CodaMi: Launch Checklist

Everything to do before publishing on Google Play and the App Store. Tick items off as they are done.

_Last updated: Wed 21 Oct 2026 (deployed)_

---

## 1. API keys and secrets

- [ ] **Move the Places key to Secret Manager**
  1. `firebase functions:secrets:set PLACES_API_KEY` (paste the key)
  2. Remove `PLACES_API_KEY` from `functions/.env`
  3. Change `defineString("PLACES_API_KEY")` to `defineSecret("PLACES_API_KEY")` in `functions/src/index.ts` and add `secrets: [placesApiKey]` to the functions that use it
  4. `firebase deploy --only functions`
- [ ] **Places (server) key:** API restrictions = Places API (New) + Geocoding API only
- [ ] **Geocoding API** enabled in Google Cloud (needed for auto street names on the pin)
- [ ] **Maps Android key:** Android apps restriction + Maps SDK for Android only
- [ ] **Maps iOS key:** iOS apps restriction (`com.codami.app`) + Maps SDK for iOS only
- [ ] Do **not** edit the "auto created by Firebase" keys
- [ ] Confirm no keys in git: `git log --all -p | grep AIza` should only show Firebase config files

## 2. Android signing and SHA-1

Add SHA-1s to the existing key. Never replace them.

- [x] Create an **upload keystore**: `android/app/upload-keystore.jks`, alias `upload` (git-ignored)
  - [ ] Back up the keystore and passwords outside the project (password manager). If they are lost, you cannot update the app.
- [x] `signingConfigs.release` in `android/app/build.gradle.kts` reading from git-ignored `android/key.properties`. Release builds are now signed with the upload key.
- [x] Upload key fingerprints:
  - SHA-1 `8D:FD:90:7A:2D:D1:3B:EB:3C:F5:44:1F:C2:89:9B:FD:54:A0:8B:8B`
  - SHA-256 `1D:89:60:DD:C5:1E:A3:3F:10:AB:08:69:82:CE:3D:0C:9A:92:B3:75:1A:C7:6B:FE:DB:91:F8:DB:59:B7:1B:02`
- [x] First build uploaded to Play Console. **Play App Signing** fingerprints (Test and release → App integrity):
  - SHA-1 `C2:3A:86:A2:7E:1B:44:2E:FE:C7:4A:2F:78:DA:7F:82:58:B5:28:98`
  - SHA-256 `D3:F6:E8:47:A9:6F:DF:94:9F:23:11:57:03:5E:3B:28:57:83:44:D8:C0:06:9B:A4:BD:80:61:65:E4:EB:83:6E`
- [x] Firebase console → Android app: debug and Play App Signing SHA-1 added (Google Sign-In works for Play installs)
  - [ ] Add the Play App Signing **SHA-256** (needed later for App Check)
  - [ ] Optional: add the upload key SHA-1 and SHA-256 (only for release builds installed outside Play)
- [x] Updated `google-services.json` downloaded (includes the Play App Signing OAuth client)
- [ ] Add the Play App Signing and upload SHA-1s to Google Cloud → Credentials → **CodaMi Maps Android** key
- [ ] Test the map and Google Sign-In on a build **installed from Play** (closed testing track)

## 3. iOS

- [ ] Apple Developer account (client owned)
- [ ] Upload an **APNs key** in Firebase console → Cloud Messaging (push does not work on iPhone without it)
- [x] Xcode: enable Push Notifications + Background Modes (Remote notifications) capabilities
- [ ] Full iOS build and test on a real iPhone (map, location permission, push, sign-in)
- [x] Check `Info.plist` permission texts (location, camera, photos) are clear and translated (all 10 languages in `InfoPlist.strings`)
- [x] Sign in with Apple, if Google sign-in is offered on iOS (App Store rule). Built; still to test on a real iPhone

## 4. Firebase

- [x] Deploy everything: `firebase deploy --only firestore:rules,firestore:indexes,storage,functions` (Wed 21 Oct)
- [x] **Deploy the new Firestore and Storage rules, indexes and functions before releasing the next build** (reward field, roles, report / block, admin panel). Old rules reject reports with a reward and reports of listings. New functions: `adminSetUserDisabled`, `adminDeleteUser`.
- [x] **Also in that deploy (Mon 19 Oct, storage rules changed again for cover image names):** `videos` rules (Firestore and Storage, admin-only uploads) and the `notificationPrefs` rule; the updated `onReportCreated` / `onReportResolved` send each user's chosen sound and skip turned-off alert types. The first Storage deploy may ask to let Storage rules read Firestore: answer yes.
- [x] **Support (Tue 20 Oct), same deploy:** new rules (`supportCases`, `staffPresence`, `staffStats`, `config/support`, the `support` notification type), 6 new indexes and the functions `supportAvailability`, `supportCreateCase`, `supportTakeCase`, `supportReassignCase`, `supportSetStatus`, `onSupportMessageCreated` the scheduled `supportSweep` (every 10 minutes) and `onUserWritten` (search fields for the users list, frees the cases of removed staff). The first deploy of a scheduled function may ask to enable Cloud Scheduler: answer yes.
- [x] **AI photo moderation (Wed 21 Oct), same deploy:** the trigger runs in the bucket's region, `us-east1` (confirmed). Cloud Vision API is already enabled. New rules (`photoChecks`, `config/moderation`, `quarantine/` in Storage), 1 new index, and the functions `onPhotoUploaded`, `moderatePhoto`, `moderationSweep`. The first Storage trigger deploy may ask to grant permissions (Eventarc / Pub/Sub): answer yes.
- [ ] **Points, invites and emergencies (Thu 22 Oct):** deploy rules, indexes (7 new) and functions: `registerVisit`, `claimDailyTask`, `getInviteCode`, `redeemInviteCode`, `adminReviewReferral`, `adminAdjustPoints`, `pointsSweep`, `onEmergencyCreated`, `updateEmergency`, `emergencySweep`, `seedTestContacts`, plus the updated `onUserWritten`, `onPhotoUploaded` and `deleteAccount`. Then add the test contacts from Admin → More → Emergency contacts
- [ ] Create the first admin in the console: `users/{your user ID}` → field `role` = `admin`
- [ ] Wait for composite indexes to finish building (Firestore → Indexes)
- [ ] Review `firestore.rules` and `storage.rules` one final time
- [ ] Turn on **App Check** (Play Integrity / App Attest) for Firestore, Storage and Functions, so only the real app can call them
- [ ] Set a **budget alert** in Google Cloud Billing (e.g. €20 / €50 / €100). Even more important now: every video view is Storage download traffic
- [ ] Set **quotas** on Places and Geocoding APIs (per day) to cap surprise costs
- [ ] Add **Crashlytics** for crash reports
- [ ] Consider a separate `codami-dev` project for testing, so test data never mixes with real users

## 5. App content and polish

- [ ] **Translation review** by native speakers (Italian first). All 10 languages are translated in the app.
- [ ] App name, icon and splash final check
- [ ] Remove any test reports, test users and test pets from Firestore
- [ ] Empty states, error messages and loading states reviewed on a slow connection
- [ ] Test on a small phone and a large phone (layout never breaks)
- [x] Notification sounds on a real Android phone (Mon 19 Oct)
- [ ] Notification sounds on a real iPhone (CodaMi sounds; app open, in background and closed). Needs the client's Apple account
- [ ] Support on two real phones: user chat and request, operator take / reply / resolve, admin reassign, Operators screen
- [ ] Support notifications on a real Android phone, with the app open (in-app banner), in the background and closed: new request, new message, reply, taken, assigned, resolved / closed, solved by the user, late reply, cases back in the queue. Check the Support replies switch and sound in Profile → Notifications
- [ ] Videos: upload a few test videos (admin), check Videos for you with no pets, a dog, and a cat, on Wi-Fi and mobile data
- [x] Version set in `pubspec.yaml` (now `1.0.0+8`). Raise the number after `+` for every upload to Play.

## 6. Legal and store listing

- [ ] **Privacy policy** and **Terms of use**: written and shown in the app (Profile). Still to do: add the support email (`legalEmail` in `lib/features/legal/legal_content.dart`) and have them reviewed
- [x] Public Privacy Policy page with account deletion steps: `docs/index.html` (for GitHub Pages)
  - [ ] Replace the `support@email.com` placeholder, publish it and paste the URL in Play Console
  - [ ] Play may require a way to **request** deletion without the app (for example by email) on this page
- [x] **Report / block users** in the app (Apple guideline 1.2, Google Play UGC policy)
  - [ ] Update the content rating answers to "Yes"
- [ ] Privacy policy and Data safety: mention the random install ID (stored hashed, only to stop invite abuse, fits "Device or other IDs"), that the exact place of an emergency is shown to signed-in users, and that the home city position is used for nearby emergency alerts
- [ ] Google Play **Data safety** form: answers prepared (precise location, name, email, user IDs, phone, photos, user content, device IDs; nothing shared; encrypted in transit; deletion available)
- [ ] App Store **privacy labels**
- [x] Feature graphic and Play icon: `assets/graphics/`
- [x] Framed store screenshots: `assets/graphics/screenshots/`
  - [ ] Retake with clean demo data (Italian city and names, no test text) and regenerate
- [x] Short and full description in English and Italian
- [x] Content rating questionnaire
- [x] Target audience: 18 and over
- [ ] Support email

Phase 2 features requested by the client (admin panel, rewards, donations, support, videos, sounds) are tracked in `PHASE_2_REQUESTS.md`. New requests (AI moderation, referrals, emergencies) are in `PHASE_3_REQUESTS.md`, and open questions for the client in `WAITING_FOR_CLIENT.md`. Donations and videos will change the Data safety form, privacy labels and possibly the content rating.

## 7. Scale (when users grow)

- [ ] **Geohash queries** for the radius filter, so the server returns only nearby reports instead of filtering on the phone
- [ ] Notifications by **distance**, not only by city
- [ ] Auto-close old reports (e.g. after 60 days) with a reminder to the owner
- [ ] Image resizing on upload (smaller photos load faster and cost less)

---

## Already done

- [x] Places key used only on the server, never inside the app
- [x] Maps keys read from git-ignored `.env`, restricted by app and API
- [x] Exact locations blurred within 100 m before saving; house numbers removed
- [x] Firestore and Storage rules: only signed-in users read reports, only owners edit
- [x] iOS uses Swift Package Manager only (no CocoaPods), minimum iOS 16
- [x] Push notifications on Android with the CodaMi notification icon and channel
- [x] Lists paginated (20 per page); map capped at 300 newest pins with clustering
- [x] **My reports** screen in the profile (mark as found, delete)
- [x] **Account deletion** inside the app (deletes profile, pets, reports, photos and login)
- [x] Release Android theme uses Material Components (light only)
- [x] Unused `geolocator` foreground location service and permission removed (Play no longer asks for a foreground service declaration)
- [x] **10 languages** (EN, IT, ES, FR, DE, PT, RU, AR, ZH, HI), language picker on onboarding, login and profile; notifications in each user's language
