# CODAMI — MVP DEVELOPMENT SPECIFICATION

**Version:** 1.0 (Trial)  
**Product name (provisional):** CodaMi  
**Trial duration:** 7 days  
**Repository:** Client-owned GitHub (private)  
**Audience:** Developer (Noman) + Product owner

> Scope for this trial is **only** what is listed here.  
> Do **not** implement future expansions unless explicitly approved in writing.

---

## 1. Project overview

CodaMi is a mobile app (iOS + Android) that helps people **find lost pets** and **report found pets**.

Users can:

- create an account
- register their pets (profiles)
- publish a **lost** or **found** report with photo + location
- see reports on a **map** and in lists
- get notified about relevant nearby activity
- contact the person who published a report

**Goal of the 7-day trial:** deliver a working MVP foundation that can be installed on Android (and preferably iOS simulator / TestFlight later), with clear code structure, Firebase backend, and the core lost/found flows.

---

## 2. MVP objectives

### Must have (trial)

1. Email authentication (sign up / login / password reset)
2. User profile (basic data)
3. Pet profiles (create / list / edit own pets)
4. Lost / Found reports (create + list + detail)
5. Map with report pins
6. Nearby awareness (city/radius filter + basic notifications)
7. Contact owner (phone / WhatsApp / email)
8. “My reports” + “My pets”
9. Clean GitHub repo, environments, README for run/build

### Out of scope (trial)

- Apple Sign-In (unless required for iOS store submission later)
- Admin web panel (beyond minimal Firebase console usage)
- Chat/messaging inside the app
- Payments / subscriptions
- AI image recognition
- Multi-language full i18n system (Italian UI is enough)
- Complex moderation tools

---

## 3. Technology

**Decision for trial: React Native + Expo**

| Area | Choice |
|------|--------|
| App | React Native + Expo (SDK 54+), TypeScript, Expo Router |
| Auth | Firebase Authentication (Email/Password) |
| Database | Cloud Firestore |
| Photo storage | Firebase Storage |
| Maps | `react-native-maps` + Expo Location |
| Push notifications | Expo Notifications + FCM (EAS build) |
| Builds | EAS Build (Android development + preview APK) |
| Repo | Private GitHub under **client account** |
| Environments | `development` / `production` via Expo env |

Rationale and alternatives: see `docs/05_TECH_STACK.md`.

---

## 4. User roles

| Role | Capabilities |
|------|----------------|
| **Guest** | Can open app → redirected to Login |
| **User (authenticated)** | Full MVP: pets, reports, map, profile, notifications |
| **Admin** | Not in-app for trial. Use Firebase Console. |

No separate shelter/NGO role in the trial.

---

## 5. App navigation

```
(auth)
  ├── Login
  ├── Register
  └── Forgot password

(tabs) — after login
  ├── Home
  │     ├── Map
  │     ├── Lost list
  │     ├── Found list
  │     └── FAB / button → Create report
  ├── Pets
  │     ├── My pets list
  │     └── Create / edit pet
  └── Profile
        ├── User data
        ├── My reports
        └── Logout

(stack screens)
  ├── Report detail
  ├── Create report
  ├── Pet detail / form
  └── Notifications (bell)
```

---

## 6. Screens

### 6.1 Authentication

| Screen | Purpose | Main UI |
|--------|---------|---------|
| Login | Email + password | Brand, form, link to Register / Forgot |
| Register | Create account | Name, email, password, confirm |
| Forgot password | Reset via email | Email field + Firebase reset |

### 6.2 Home

| Area | Purpose |
|------|---------|
| Map | Pins for open lost/found reports |
| Lost list | Filter `type = lost`, status open |
| Found list | Filter `type = found`, status open |
| Filters | City / radius / all |
| Create button | Opens Create Report |
| Bell | In-app activity notifications |

### 6.3 Profile

| Screen | Purpose |
|--------|---------|
| Profile | Display name, email, preferred city, notify radius |
| My pets | Shortcut / same as Pets tab |
| My reports | User’s own lost/found posts |
| Settings toggles | Notify by city / by radius |

### 6.4 Pet

| Field | Required |
|-------|----------|
| Photo | Yes (at least 1) |
| Name | Yes |
| Species | Yes (dog / cat / other) |
| Breed | Optional |
| Color | Optional |
| Sex | Optional (M / F / unknown) |
| Age | Optional (text or years) |
| Distinctive features | Optional (text) |

### 6.5 Report

| Field | Required |
|-------|----------|
| Type | Yes — **Lost** or **Found** |
| Linked pet | Optional if Found (unknown pet); required if Lost and user has pets |
| Photo | Yes |
| Position | Yes — city autocomplete + lat/lng stored |
| Date/time | Yes |
| Description | Yes |
| Contacts | Yes (phone and/or email) |

Status values: `open` | `resolved` | `closed`

---

## 7. User flows

### Flow A — Register & setup

1. Open app → Login  
2. Tap Register → enter name, email, password  
3. Account created in Firebase Auth + `users/{uid}` document  
4. Ask preferred **city** (autocomplete) → save `cityKey`, `homeLat`, `homeLng`  
5. Land on Home

### Flow B — Create pet profile

1. Pets tab → Create pet  
2. Add photo, name, species, optional details  
3. Save → Firestore `pets/{id}` + Storage upload  
4. Pet appears in “My pets”

### Flow C — Report lost pet (critical)

1. Home → Create report → type **Lost**  
2. Select one of **My pets** (or quick-create pet)  
3. Confirm / adjust last seen city (autocomplete) → store lat/lng  
4. Set date/time, description, contacts  
5. Add / confirm photo  
6. Publish  
7. Report saved in Firestore `reports`  
8. Pin appears on Map + Lost list  
9. Users with matching city / radius receive notification (push if EAS build; in-app fallback)

### Flow D — Report found pet

1. Create report → type **Found**  
2. Photo + description of the animal found  
3. Position + date/time + contacts  
4. Publish → appears on Map + Found list  
5. Nearby users can be notified

### Flow E — Discover on map

1. Open Home Map  
2. See pins (lost / found, different colors if possible)  
3. Tap pin → Report detail  
4. Contact publisher (tel / WhatsApp / email)

### Flow F — Resolve

1. Owner opens My reports / detail  
2. Marks as **resolved**  
3. Report leaves open map/list filters

### Flow G — Comment / sighting (optional if time)

If time allows in trial:

- Users can add a short **sighting/comment** on a report  
- Owner gets in-app notification  

If not enough time: skip and keep Contact only.

---

## 8. Pet profiles

Collection: `pets`

```
pets/{petId}
  ownerId: string
  name: string
  species: 'dog' | 'cat' | 'other'
  breed?: string
  color?: string
  sex?: 'M' | 'F' | 'unknown'
  age?: string
  features?: string
  photoUrls: string[]
  createdAt, updatedAt
```

Rules: owner can CRUD own pets; authenticated users can read pets linked to public reports.

---

## 9. Lost / found reports

Collection: `reports`

```
reports/{reportId}
  ownerId: string
  ownerName: string
  ownerContact: string
  type: 'lost' | 'found'
  petId?: string
  petName: string
  species: string
  description: string
  photoUrls: string[]
  country: string
  city: string
  cityKey: string
  placeDetail?: string
  lat: number
  lng: number
  eventAt: string (ISO datetime)
  status: 'open' | 'resolved' | 'closed'
  createdAt, updatedAt
```

---

## 10. Map & location

- Do **not** force continuous GPS tracking.
- Location for reports = **city/place autocomplete** → store lat/lng from selected place.
- User home city for filters/notifications = same approach.
- Map shows markers for `status == open` reports with valid coordinates.
- Filters: same city / within notify radius km / all.

Privacy: show city/area text in UI; coordinates used for map/radius only.

---

## 11. Notifications

### Trial minimum

1. **In-app** notification list (bell) for:
   - new report in my city / radius (if feasible)
   - activity on my reports (sighting/comment if implemented)

2. **Push** via Expo Notifications on **EAS development/preview build** (not Expo Go).

User settings:

- `notifyByCity: boolean`
- `notifyByRadius: boolean`
- `notifyRadiusKm: number` (e.g. 5 / 10 / 25 / 50)

---

## 12. Communication

MVP contact methods on report detail:

- Phone call (`tel:`)
- WhatsApp deep link
- Email (`mailto:`)

No in-app chat in trial.

---

## 13. Admin

- No custom admin app in trial.
- Product owner uses Firebase Console for users, data, storage rules.
- Optional later: simple admin web.

---

## 14. Database structure (summary)

```
users/{userId}
pets/{petId}
reports/{reportId}
comments/{commentId}          # optional trial
sightings/{sightingId}        # optional trial
notifications/{notificationId}
```

Indexes: prefer client-side filtering for trial to avoid index delays; add composite indexes only if needed.

Full field lists: sections 8–9 + `docs/02_APP_STRUCTURE.md`.

---

## 15. Security & privacy

- Firestore / Storage security rules required before any demo.
- Users can only write their own `users`, `pets`, and owned `reports`.
- Reports readable by authenticated users (or public read if product decides — prefer authenticated read for trial).
- Photos under `pets/{uid}/...` and `reports/{uid}/...`.
- No secrets in Git (`.env` gitignored; use EAS secrets / local env).
- GDPR-minded: store only needed personal data; contacts shown only on report detail.

---

## 16. Trial milestone (definition of done)

By end of day 7, developer delivers:

1. Private GitHub repo with clean structure + README  
2. Firebase project wired (Auth + Firestore + Storage)  
3. Runnable Expo app  
4. Auth flows working  
5. Pet create/list  
6. Lost + Found create/list/detail  
7. Map with pins  
8. My pets / My reports  
9. Android **development or preview APK** via EAS  
10. Short demo video or screenshots of the flows  

Acceptance checklist: `docs/07_TRIAL_MILESTONE.md`.

---

## 17. GitHub / code requirements

- Repo owned by **client**
- Branching: `main` (stable) + `develop` (trial work)
- Conventional commits preferred
- TypeScript strict-ish
- Folder suggestion:

```
app/                 # Expo Router screens
src/
  components/
  services/          # firebase, pets, reports, places, notifications
  types/
  utils/
  constants/         # theme / brand
docs/                # this specification (already present)
assets/
eas.json
app.json
```

- No `node_modules` / `.env` in git
- Document how to run:

```bash
npm install
npx expo start
```

- Document EAS Android build briefly

---

## Related docs in this package

1. `01_BRAND_IDENTITY.md`  
2. `02_APP_STRUCTURE.md`  
3. `03_USER_FLOWS.md`  
4. `04_WIREFRAMES.md`  
5. `05_TECH_STACK.md`  
6. `06_ACCOUNTS_ACCESS.md`  
7. `07_TRIAL_MILESTONE.md`  

---

**End of specification — Trial v1.0**
