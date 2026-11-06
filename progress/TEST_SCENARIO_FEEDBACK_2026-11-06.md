# CodaMi: Test Scenario, Feedback (request 7)

Phone test for the Google Play rating and the new internal feedback. Built Fri 6 Nov 2026.

## Before you start

1. Put the server code online: `firebase deploy --only functions,firestore:rules,storage` (new `updateFeedback`, changed `submitFeedback`, rules for `config/feedbackAsks`, the user's `feedbackAsk`, and the screenshot folder).
2. Install the new build (the phone model is read by new native code).
3. An **admin** account and a **normal user** account. For part 3 the user account must be at least 3 days old.

## 1. Rating CodaMi on Google Play (part A)

- [ ] Profile → **Rate CodaMi** (now above Send feedback) → the CodaMi page opens in Google Play, where the user can rate and write a review. On iPhone it shows only once the App Store ID is set.
- [ ] The automatic rating window still comes by itself: from a Play Store install, after 10 days and 5 active days (Admin → More → Points and rewards). Google decides whether it really shows; that's normal.
- [ ] It never comes within 14 days of one of our own feedback questions.
- Google rule check: no points for a store review, no "Do you like CodaMi?" before it, and nothing that suggests a number of stars.

## 2. Sending feedback yourself

- [ ] Profile → **Send feedback** (subtitle "Suggestions, bugs and ideas for the team") → the form opens, with an X at the top to close it.
- [ ] The 4 types: Suggestion, Bug, Problem, Improvement. Tapping one highlights it and changes the hint in the text box (Bug: "What happened, and what did you expect?").
- [ ] "Which part of the app?" lists the whole app, Lost and found, Map, Walks, Pet sitting, Schedule, Heat calendar, Breed scanner, Shop and Sharing.
- [ ] Stars are optional; tap the same star again to clear it.
- [ ] Send is grey until there are stars or a few words ("Add stars or a few words to send").
- [ ] **Add a screenshot** → pick one from the gallery → a thumbnail with an X to remove it.
- [ ] Send → "Thanks for your feedback!" (+20 points the first time, after 5 days from sign-up).
- [ ] Send 5 in one day → the 6th says "Thanks, that's a lot of feedback for today!".

## 3. Being asked by the app

Waiting for 10 to 20 real uses takes a while. To test quickly: Admin → Feedback → ⚙ (top right) → set "Uses before asking" **from 2 to 2** → Save.

- [ ] As the user, open the **map** (full screen) twice and go back to the main screen → after a few seconds: **"Quick question 🐾"** with "Map" on top, the same form without "Which part of the app?", plus **Don't ask me again**.
- [ ] Close it. Open the map twice more → no new question: each part is asked about only once, and the 14-day pause has started.
- [ ] In Firestore → `users/<user>` → `feedbackAsk`: `count` 1, `asked` ["map"], `lastAt` now.
- [ ] Shortcut for the pause: delete `feedbackAsk.lastAt` in Firestore, then open **walks** (Places to walk) twice → the question comes for Walks.
- [ ] Tap **Don't ask me again** → "OK, we won't ask again…" → `feedbackAsk.optOut` is true and no more questions come (delete `lastAt` again and open another part twice to check).
- [ ] The question never pops up while a screen, sheet or the keyboard is open; it waits until you are back on the main tabs.
- [ ] A new account (under 3 days old) is never asked. Admin accounts are never asked.
- [ ] Put the numbers back to **10 to 20** when done.

What counts as one use: opening a report, the full map, Places to walk, Pet sitting, My schedule, the heat calendar, the breed scanner, a shop product, or a share (Share CodaMi or a report's share options).

The general question ("How do you like CodaMi?") comes on about 1 in 4 app starts for users with 10 active days, once, with the same pause.

## 4. Admin → More → Feedback

- [ ] **Last 30 days:** counts of suggestions, bugs, problems and improvements, and average stars for each part of the app (lowest first, orange below 3).
- [ ] Tabs **New / In progress / Done** with counts. Older feedback shows under New as "General".
- [ ] Filters: type, part of the app, stars ("No stars" too).
- [ ] Each card: type and part, time, stars, text, **screenshot** (tap for full screen, pinch to zoom), name and email, "Asked in the app" or "Sent from Profile", app version, phone model (for example "samsung SM-S911B · Android 14") and language.
- [ ] Status → **In progress** → the card moves to that tab.
- [ ] ✎ → write a **private note** → shows on the card (users never see it).
- [ ] 👤 → opens the user's admin page (admins only).
- [ ] Status → **Done** → "Mark as done?" with **Thank the user** on → Confirm → the user's phone gets "Thanks, we fixed it! 🛠️" for a bug or problem, or "Your idea is in CodaMi! 💡" otherwise, in their language. The card shows "Thanked". Moving it back and to Done again doesn't send a second thanks.
- [ ] Support staff can open Feedback and change status and notes; the ⚙ settings and 👤 are for admins only.

## 5. Settings (Admin → Feedback → ⚙)

- [ ] On/off saves straight away. Off: nobody is asked, and Profile → Send feedback still works.
- [ ] "from" 15 and "to" 12 → error; pause 1 → error; questions 50 → error.

## 6. Languages

- [ ] Italian, German and Arabic: the form, the question, the admin inbox and the thank-you push read well; Arabic right to left (the X moves to the left).

## If something goes wrong

- No question: check `feedbackAsk` on the user (pause, `optOut`, `count` 4 or more), that the account is 3 days old and that the questions are on.
- No thank-you push: `firebase functions:log --only updateFeedback` (the user needs notifications allowed).
- Automated checks: `flutter test test/feedback_rules_test.dart`, `cd functions && npm test`, and `emulator_tests/feedback_asks.cjs`.
