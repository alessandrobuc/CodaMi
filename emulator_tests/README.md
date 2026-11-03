# Emulator tests

End-to-end checks of the Cloud Functions and the Firestore and Storage rules, run against the Firebase emulators with a demo project (no real data or services are touched). Vision is replaced by a fake result stored on each test photo.

```sh
(cd functions && npm run build)
firebase emulators:exec --only auth,functions,firestore,storage --project demo-codami \
  "node emulator_tests/moderation.cjs && node emulator_tests/points_emergency.cjs && node emulator_tests/feedback_notes.cjs && node emulator_tests/petitions.cjs && node emulator_tests/app_version.cjs && node emulator_tests/shop.cjs && node emulator_tests/phase4.cjs && node emulator_tests/invites.cjs"
```

Each script prints one PASS or FAIL line per check and exits with an error if anything fails.

- `moderation.cjs`: AI photo moderation (clear, review, blocked, injured animals, quarantine, approve, remove, rules)
- `points_emergency.cjs`: daily rewards, streaks, invite codes, referral checks and admin review, emergencies, nearby alerts, contacts and their rules
- `feedback_notes.cjs`: feedback points (once per account, one feedback a day), who can read feedback, the feedback and review settings, "What's new" notes and their rules, feedback removed with the account
- `petitions.cjs`: petitions: only admins write, users see only published ones, link and field checks, verification checks needed to approve or publish, image upload rules
- `app_version.cjs`: app update settings: readable before sign-in, only admins write, version and App Store ID checks, unknown fields refused
- `shop.cjs`: shop: users only read the catalogue while the shop is on, hidden items stay hidden, suppliers are admin only, only admins write, product, category, brand and supplier field checks, photo and logo upload rules
- `phase4.cjs`: places to walk and donation settings (only admins write, field checks, payments can't be marked ready from the app), the walk search functions (off for users, input checks, sign-in, daily limit before Google is called)
- `invites.cjs`: invite tracking: QR scans and link opens from the invite page (once a day per visitor, unknown codes ignored, no IP kept, counters hidden from users), the admin counts per user (active, inactive, waiting, still using, friends list), the ranking with periods and sorting, and open counts removed with the account
