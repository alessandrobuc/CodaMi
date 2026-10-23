# Emulator tests

End-to-end checks of the Cloud Functions and the Firestore and Storage rules, run against the Firebase emulators with a demo project (no real data or services are touched). Vision is replaced by a fake result stored on each test photo.

```sh
(cd functions && npm run build)
firebase emulators:exec --only auth,functions,firestore,storage --project demo-codami \
  "node emulator_tests/moderation.cjs && node emulator_tests/points_emergency.cjs && node emulator_tests/feedback_notes.cjs"
```

Each script prints one PASS or FAIL line per check and exits with an error if anything fails.

- `moderation.cjs`: AI photo moderation (clear, review, blocked, injured animals, quarantine, approve, remove, rules)
- `points_emergency.cjs`: daily rewards, streaks, invite codes, referral checks and admin review, emergencies, nearby alerts, contacts and their rules
- `feedback_notes.cjs`: feedback points (once per account, one feedback a day), who can read feedback, the feedback and review settings, "What's new" notes and their rules, feedback removed with the account
