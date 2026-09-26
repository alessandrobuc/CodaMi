# 05 — Tech stack (decided for the trial)

## Decision

| Topic | Trial choice |
|---------|----------------|
| Framework | **React Native + Expo (SDK 54+)** |
| Language | TypeScript |
| Navigation | Expo Router |
| Backend | **Firebase** |
| Auth | Firebase Auth Email/Password |
| Database | Cloud Firestore |
| Photo storage | Firebase Storage |
| Maps | `react-native-maps` + Expo Location + city geocoding (Nominatim or Google Places) |
| Notifications | Expo Notifications + FCM (requires EAS build, not Expo Go) |
| Builds | EAS Build |
| Repo | Private GitHub (client account) |
| Environments | `development` / `production` |

## Why not Flutter for this trial

- Expo is faster for an MVP with auth, cloud Android builds, and a lean workflow.
- One language (TypeScript) for app + tooling docs.
- Flutter remains a valid post-trial option if a rewrite is wanted: the functional spec does not change.

If the developer prefers Flutter, they **must request written approval** before day 1, because it changes the delivery plan.

## Environments

| Env | Use |
|-----|-----|
| `development` | Firebase project `codami-dev`, debug, development-client APK |
| `production` | Firebase project `codami-prod` (or one project with prefixes — prefer **two projects**) |

Example variables (never commit secrets):

```
EXPO_PUBLIC_FIREBASE_API_KEY=
EXPO_PUBLIC_FIREBASE_AUTH_DOMAIN=
EXPO_PUBLIC_FIREBASE_PROJECT_ID=
EXPO_PUBLIC_FIREBASE_STORAGE_BUCKET=
EXPO_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=
EXPO_PUBLIC_FIREBASE_APP_ID=
EXPO_PUBLIC_GOOGLE_MAPS_API_KEY=   # if used
```

## Android / iOS package

- Android: `com.codami.app`
- iOS: `com.codami.app`

## Trial build targets

1. `eas build -p android --profile development` (dev client)
2. `eas build -p android --profile preview` (demo APK)

iOS store / Apple Sign-In: after the trial.
