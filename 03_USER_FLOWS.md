# 03 — User flows (required)

These flows are the functional contract for the trial.  
If a flow is incomplete, the milestone is **not** reached.

---

## Flow 1 — Onboarding

```
Open app
  → Login
  → (new user) Email registration
  → Create users/{uid} document
  → "Where are you?" screen (city autocomplete)
  → Save city + lat/lng + cityKey
  → Home
```

---

## Flow 2 — Create pet

```
Pets tab
  → New pet
  → Photo + details
  → Upload to Storage + pets document
  → Back to "My pets" list
```

---

## Flow 3 — Report lost pet (core)

```
Home → New report
  → Type = Lost
  → Select pet from profile (or create it)
  → Enter location (city from suggestions)
  → Add/confirm photo
  → Date/time + description + contacts
  → Publish
  → reports document created (type=lost, status=open)
  → Pin appears on the map
  → Item appears in Lost list
  → Users in matching city/radius get a notification
     (push on EAS build; in-app notification list otherwise)
```

---

## Flow 4 — Report found pet

```
Home → New report
  → Type = Found
  → Photo of the found animal
  → Location + date/time + description + contacts
  → Publish
  → Pin + Found list
  → Notify nearby users
```

---

## Flow 5 — Discover on map

```
Home → Map
  → See open pins
  → Tap pin
  → Report detail
  → Contact (tel / WhatsApp / email)
```

---

## Flow 6 — Manage own reports

```
Profile → My reports
  → Open detail
  → Mark as resolved
  → status=resolved
  → Disappears from open map/lists
```

---

## Flow 7 — Bell notifications

```
Event (new nearby report / activity on my post)
  → Create notifications/{id} for recipients
  → Home bell badge
  → User opens Notifications
  → Tap → opens report
  → Mark as read
```

---

## Acceptance for each flow

- [ ] No crash on the happy path
- [ ] Data persists after app restart
- [ ] Firestore/Storage rules respected
- [ ] UI copy in Italian
