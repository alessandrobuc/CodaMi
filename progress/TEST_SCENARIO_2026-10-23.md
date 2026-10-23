# CodaMi: Real Phone Test, Fri 23 Oct Build

Test of everything built on Fri 23 Oct. Use the build uploaded to Google Play closed testing: the Google sign-in fix, the automatic invite code and the store rating window only work when the app is installed from the Play Store.

**You need:**
- Phone A: your phone, with an **admin** account
- Phone B: a second phone (or a family member's), with a **new** Google account that has never used CodaMi
- Both phones signed in to the Play Store with tester accounts on the closed testing list

**Before you start:**
1. Deploy is done: rules, functions **and indexes** (`firebase deploy --only firestore:rules,firestore:indexes,functions`). Wait until the `releaseNotes` index shows "Enabled" in Firestore → Indexes.
2. In `pubspec.yaml`, raise the version to `1.1.0+11` (the version name must change, not just the number after `+`).
3. Build the app bundle (`flutter build appbundle`) and upload it to closed testing. Don't update the phones yet.
4. Phone A keeps the **old** version (1.0.0) for now.

---

## 1. Google sign-in (Play Store version)

1. Phone A: with the old Play Store version, sign out and tap **Continue with Google**.
   - Expected: it fails with "something went wrong" (the old bug).
2. Update CodaMi from the Play Store on phone A (version 1.1.0).
3. Tap **Continue with Google** again.
   - Expected: sign-in works.

## 2. What's new

Do steps 1 and 2 **before** updating phone A in test 1, or reinstall 1.0.0 first.

1. Phone A (admin): Admin → More → **What's new** → **Add version**.
2. Check that the version box shows `1.1.0`.
3. English:
   - New: `Emergencies on the map` and `Feedback with points`
   - Fixed: `Google sign-in`
4. Italian: write one line in New. Leave the other languages empty. Turn **Published** on and save.
   - Expected: the list shows "Version 1.1.0", "Published", 🇬🇧 🇮🇹 and today's date.
5. Phone B (normal user, still on 1.0.0): update the app from the Play Store and open it.
   - Expected: a "What's new" page with the notes of 1.1.0 and a **Got it** button.
6. Close the app and open it again.
   - Expected: the page doesn't show again.
7. Profile → **What's new**.
   - Expected: the newest version card is open; older versions are closed cards showing chips like "2 New · 1 Fixed". Tap a closed card: it opens; tap again: it closes.
   - With more than 10 versions, **Load more** appears at the end (same in the admin list).
8. Change the app language to Italian.
   - Expected: the Italian line shows.
9. Change to German.
   - Expected: the English notes show.
10. Admin: open 1.1.0, turn Published off and save. On phone B, Profile → What's new.
    - Expected: empty ("No update notes yet").
11. Turn it back on.
12. Fresh install: uninstall CodaMi on a phone, install 1.1.0 from the Play Store, sign in with a **brand new** account.
    - Expected: no What's new page (only Profile → What's new shows the notes).
13. Admin form checks:
    - Version `abc` gives "Use numbers and dots".
    - Adding `1.1.0` a second time gives "This version already has notes".
    - Saving with empty English shows "Write the English notes first".
    - Delete asks for confirmation.

## 3. Feedback with points

1. Phone B (new account): Profile → **Send feedback**.
   - Expected: the card shows stars, a comment box, **Send feedback** (greyed out until a star is chosen) and **Not now**. On a new account the "+20 points" badge shows, but points are only given after 5 days.
2. Choose 4 stars, write a comment and send.
   - Expected: "Thanks for your feedback!". No points, because the account is less than 5 days old.
3. Send again the same day.
   - Expected: "You already sent feedback today…".
4. Phone A (admin): Admin → More → Points and rewards → **Feedback and reviews**. Set "Days after sign-up before asking for feedback" to `0` and save.
5. Phone A as a **normal user account that never sent feedback** (or a third account): Profile → Send feedback with 5 stars.
   - Expected: "Thanks for your feedback! +20 points". Profile → My points shows +20 and "Feedback sent" in the history.
6. Next day, send feedback again from that account.
   - Expected: thanks, no more points.
7. Admin → More → **Feedback**.
   - Expected: each feedback with its stars, comment, name, email, version, phone type and time. The top shows the average and a bar for each star.
8. Tap a star bar: the list filters. Tap it again: all feedback shows.
9. Support account: More → Feedback.
   - Expected: it can read the feedback but has no **What's new** entry (admins only).

## 4. Feedback card shown automatically

1. Admin: in Feedback and reviews, set:
   - "Days after sign-up before asking for feedback" to `0`
   - "Days of use before asking" to `0`
2. Phone B (account that has **not** sent feedback): close and open the app, stay on **Home** and don't touch anything for 30 seconds.
   - Expected: the feedback card slides up after about 25 seconds.
3. Tap **Not now**, close and open the app.
   - Expected: it doesn't come back (next time is in 30 days, at most 3 times).
4. Open the app and go to another tab or screen within 25 seconds.
   - Expected: no card appears while you are doing something.

## 5. Store rating window (Play Store install only)

1. Admin: set "Days after sign-up before the store rating window" to `0` and "Days of use before asking" to `0`.
2. Use an account that already saw the feedback card **more than a day ago**, or that has sent feedback.
3. Open the app and wait on Home for about 30 seconds.
   - Expected: the Google Play rating window appears (Google's own design, no points).
   - Google decides whether to show it and limits how often. If it doesn't appear, that's normal: try once, don't repeat.
4. Profile → **Rate CodaMi**.
   - Expected: opens CodaMi on the Play Store.
5. Afterwards, set the settings back to the defaults:
   - feedback points `20`
   - feedback after `5` days
   - days of use `5`
   - store window after `10` days
   - every `120` days

## 6. Emergency pins on the map

1. Phone B: report an emergency near phone A's city.
2. Phone A: Home → map.
   - Expected: a red pin with the emergency type icon. It shows under All, Lost and Found.
3. Tap the pin.
   - Expected: a card with the type, place, time and status.
4. Tap the card.
   - Expected: the emergency opens.
5. Phone B: mark the emergency resolved.
   - Expected: the pin disappears from phone A's map.

## 7. Automatic invite code (Play Store install only)

1. Phone A: Profile → Invite friends → **Share** and send the link to phone B.
2. Phone B: uninstall CodaMi, open the link and install from the Play Store.
3. Sign in with a new account and choose the city.
   - Expected: "Did a friend invite you?" already shows phone A's code, with "Filled in from your invite link…".
4. Tap **Use**.
   - Expected: accepted. Phone A: Invite friends shows the friend as "Joined, not active yet".

---

Write problems found under **Fixes found while testing** in `PENDING_TASKS.md`.
