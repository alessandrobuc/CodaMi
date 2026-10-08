# CodaMi

Lost & found pets app for Italy. Flutter (Android + iOS) with Firebase.

## Stack

| Area | Tech |
|---|---|
| App | Flutter, Riverpod 3 |
| Backend | Firebase Auth, Firestore, Storage, Cloud Functions (TypeScript) |
| Maps | Google Maps SDK (Android) / Google Maps SDK 10 via Swift Package Manager (iOS) |
| Places | Google Places API (New) and Geocoding API, called only from Cloud Functions |
| Push | Firebase Cloud Messaging |

Firebase project: `codami-cd91e`. Package / bundle ID: `com.codami.app`.

## Project layout

```
lib/
  core/            constants, theme, navigation, shared utils (geo, dates, numbers)
  features/
    auth/          login, signup, reset password
    onboarding/
    location/      city search (Places)
    pets/          my pets CRUD
    reports/       lost/found reports, create flow, detail, lists
    map/           Google map, pins, clustering, area filter
    notifications/ in-app notifications + push
    profile/
    shell/         bottom navigation
functions/src/     Cloud Functions (Places proxy, reverse geocoding, notifications)
```

Each feature follows `data / domain / presentation`.

## Setup

1. Install Flutter (stable) and Node 22.
2. `flutter pub get`
3. Create `.env` in the project root (copy `.env.example`):
   ```
   MAPS_API_KEY_ANDROID=...
   MAPS_API_KEY_IOS=...
   ```
   Android reads it in `android/app/build.gradle.kts`, iOS through `ios/Flutter/*.xcconfig` into `Info.plist`.
4. Create `functions/.env` (copy `functions/.env.example`):
   ```
   PLACES_API_KEY=...
   ```
5. `cd functions && npm install`

Both `.env` files are git-ignored. Never commit keys.

### iOS

- Minimum iOS 16 (required by Google Maps SDK 10).
- Swift Package Manager only, no CocoaPods. It is enabled for this project in `pubspec.yaml` (`flutter: config: enable-swift-package-manager: true`).
- `packages/google_maps_flutter_ios_stub` replaces the CocoaPods-only `google_maps_flutter_ios` through `dependency_overrides`; the real iOS map comes from `google_maps_flutter_ios_sdk10`.
- Push on iOS needs an APNs key uploaded in Firebase console.

## Google Cloud keys

| Key | Used by | Restrictions |
|---|---|---|
| CodaMi Maps Android | Android app | Android apps: `com.codami.app` + SHA-1s · API: Maps SDK for Android |
| CodaMi Maps iOS | iOS app | iOS apps: `com.codami.app` · API: Maps SDK for iOS |
| Places (server) | Cloud Functions | API: Places API (New), Geocoding API |

Firebase's own keys in `google-services.json`, `GoogleService-Info.plist` and `lib/firebase_options.dart` are public by design; data is protected by `firestore.rules` and `storage.rules`.

Android SHA-1s to keep on the Android key: every developer's debug key, the upload key, and the Play App Signing key (Play Console → App integrity).

## Run and test

```
flutter run
flutter analyze
flutter test
cd functions && npm test
```

## Deploy

```
firebase deploy --only firestore:rules,firestore:indexes,storage,functions
```

- Composite indexes live in `firestore.indexes.json` and take a few minutes to build after deploy.
- Callable functions (`searchCities`, `getCityDetails`, `searchStreets`, `getStreetDetails`, `reverseGeocode`) run in `europe-west1`.
- Firestore triggers (`onReportCreated`, `onReportResolved`) run in `us-central1`, matching the database location (`nam5`).

## Privacy

- Report locations are blurred within 100 m on the device before saving; the exact spot is never stored.
- House numbers are stripped from addresses on the device and on the server.
- Only signed-in users can read reports; only the owner can resolve or delete one.

## Build

```
flutter build apk --release
```

Release builds are currently signed with the debug key. Create an upload keystore before publishing to Google Play.
