# CodaMi: Share reminders test (Thu 5 Nov)

Phase 5, request 6 (`PHASE_5_REQUESTS.md` §3).

**Before testing**
1. Deploy: `firebase deploy --only functions,firestore:rules` (new `shareReminderSweep` every day at 18:00 Italian time, `shareReminderEvent`, `testShareReminder`, changed `registerVisit` and `logReportShare`; rules for `config/shareReminders`, `shareReminders`, `shareReminderStats` and the new `share` notification switch).
2. Install the new build, with notifications allowed.
3. Accounts: **admin** and a **user** (ideally a new one).

Note anything wrong in `PENDING_TASKS.md` under "Fixes found while testing".

---

## 1. Admin settings
1. Admin → More → **Share reminders** (after Social sharing): off; 3 / 7 / 8.
2. Type 1 in "Days between reminders" → Save → error (3 to 60). Put back 7 → "Saved".
3. Switch it **on** → "Saved" straight away.

## 2. Try it straight away
4. **Preview the screen users see** → the "Share CodaMi" screen (nothing is counted).
5. **Send me a test reminder** → "Test reminder sent…", the push arrives on the admin phone; tap it → the Share CodaMi screen.

## 3. The Share CodaMi screen
6. Green card "Help CodaMi make a difference!" with the client's text.
7. "Join CodaMi" image: logo, 3 reasons, **your invite code** and a QR code (scan it → the invite page).
8. WhatsApp → image + text + invite link. Facebook / Instagram / TikTok → image, caption copied to paste. More, Save image, Copy link.
9. "No friends joined yet" / "N friends joined…" → opens Invite friends (levels and rewards).
10. Invite friends → the share icon at the top opens the same screen.

## 4. The real schedule (needs a few days, or a shortcut)
11. A user opens the app → the first reminder is planned 3 days after their sign-up (Firestore `shareReminders/{uid}.next`).
12. Shortcut: in Firestore set that user's `next` to today and wait for 18:00 Italian time (or set `next` to today before 18:00). The push arrives once; `count` goes to 1 and `next` a week later.
13. The texts rotate: the client's text first, then three short versions.

## 5. Not intrusive
14. Share anything (a report or CodaMi) → `lastSharedDay` = today → the next reminder in the coming 2 weeks is skipped.
15. A user who hasn't opened the app for 60 days is skipped.
16. After 8 reminders they stop (`next` = 9999-12-31).
17. On a day a reminder was opened, the feedback card or rating window doesn't show.

## 6. Turning them off
18. Profile → Notifications → **Share reminders** switch off → no more reminders.
19. Or on the Share CodaMi screen (opened from a reminder) → **Don't remind me again** → message, and the switch is off in Notifications.

## 7. Numbers
20. Admin → Share reminders → Last 30 days: Sent, Opened (with %), Shares.

## 8. Languages
21. Italian, German, Arabic: the push, the screen and the image fit and read well.
