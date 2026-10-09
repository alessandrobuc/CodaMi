# CodaMi: Launch Checklist

Everything to do before publishing on Google Play and the App Store. Tick items off as they are done.

_Last updated: Fri 9 Oct 2026_

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

- [ ] Create an **upload keystore**:
  - `keytool -genkey -v -keystore ~/codami-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload`
  - Store the keystore and passwords safely (password manager). If they are lost, you cannot update the app.
- [ ] Add a `signingConfigs.release` in `android/app/build.gradle.kts` reading from a git-ignored `android/key.properties`. Today release builds are signed with the **debug** key.
- [ ] Get the **upload key SHA-1**: `keytool -list -v -keystore ~/codami-upload.jks -alias upload`
- [ ] Upload the first build to Play Console, then copy the **Play App Signing SHA-1** from Setup → App integrity
- [ ] Add **all** SHA-1s (each dev debug, upload, Play App Signing) to:
  - Google Cloud → Credentials → **CodaMi Maps Android** key
  - Firebase console → Project settings → Android app (needed for Google Sign-In)
- [ ] Download the updated `google-services.json` after adding SHA-1s
- [ ] Test the map and Google Sign-In on a build **installed from Play** (internal testing track)

## 3. iOS

- [ ] Apple Developer account (client owned)
- [ ] Upload an **APNs key** in Firebase console → Cloud Messaging (push does not work on iPhone without it)
- [ ] Xcode: enable Push Notifications + Background Modes (Remote notifications) capabilities
- [ ] Full iOS build and test on a real iPhone (map, location permission, push, sign-in)
- [ ] Check `Info.plist` permission texts (location, camera, photos) are clear and translated
- [ ] Sign in with Apple, if Google sign-in is offered on iOS (App Store rule)

## 4. Firebase

- [ ] Deploy everything: `firebase deploy --only firestore:rules,firestore:indexes,storage,functions`
- [ ] Wait for composite indexes to finish building (Firestore → Indexes)
- [ ] Review `firestore.rules` and `storage.rules` one final time
- [ ] Turn on **App Check** (Play Integrity / App Attest) for Firestore, Storage and Functions, so only the real app can call them
- [ ] Set a **budget alert** in Google Cloud Billing (e.g. €20 / €50 / €100)
- [ ] Set **quotas** on Places and Geocoding APIs (per day) to cap surprise costs
- [ ] Add **Crashlytics** for crash reports
- [ ] Consider a separate `codami-dev` project for testing, so test data never mixes with real users

## 5. App content and polish

- [ ] **Italian translation** of all app text (spec requires Italian UI). Setup done and first screens translated on 9 Oct; about 200 texts left. 10 languages set up with a picker in the profile; the 8 others still to translate
- [ ] App name, icon and splash final check
- [ ] Remove any test reports, test users and test pets from Firestore
- [ ] Empty states, error messages and loading states reviewed on a slow connection
- [ ] Test on a small phone and a large phone (layout never breaks)
- [ ] Version name and number set in `pubspec.yaml`

## 6. Legal and store listing

- [ ] **Privacy policy** page (public URL): what data is stored (email, name, phone, photos, approximate location), why, and how to delete it
- [ ] **Terms of use**
- [ ] Google Play **Data safety** form
- [ ] App Store **privacy labels**
- [ ] Store screenshots (phone), feature graphic (Play), short and full description in Italian and English
- [ ] Content rating questionnaire
- [ ] Support email

## 7. Scale (when users grow)

- [ ] **Geohash queries** for the radius filter, so the server returns only nearby reports instead of filtering on the phone
- [ ] Notifications by **distance**, not only by city
- [ ] Auto-close old reports (e.g. after 60 days) with a reminder to the owner
- [ ] Image resizing on upload (smaller photos load faster and cost less)
- [ ] Report / block users (moderation)

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
