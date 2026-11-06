# CodaMi: Test Scenario, Titles and Achievements (request 8)

Phone test for profile titles, levels, the achievements page and donor titles. Built Fri 6 Nov 2026.

## Before you start

1. Put the server code online: `firebase deploy --only functions,firestore:rules`. That deploys 5 new functions (`refreshMyTitles`, `setTitlePrefs`, `adminSetTitle`, `adminRecordDonation`, `adminDeleteDonation`) and the counting added to visits, reports, emergencies, shares, feedback and pet sitting. It also adds rules for `config/titles`, `achievements`, `publicProfiles` and `donations`. No new index is needed.
2. Install the new build.
3. You need an **admin** account and two **normal user** accounts (A and B).
4. Titles start **switched off** for users. Admins see everything while they're off.

## 1. Admin settings (Admin → More → Titles and achievements)

- [ ] The switch at the top is **off**. Every title shows its 3 numbers (★ / ★★ / ★★★), its own "Show this title" switch and how many users have it.
- [ ] The defaults:
  - Contributor 1/5/15
  - Rescuer 1/3/10
  - Volunteer 1/5/15
  - Advocate 5/25/100
  - Helper 1/3/10
  - Trusted 30/100/365
  - Sitter 1/5/15
  - Bonus points 10/25/50
  - Donor €10/25/50/100/250
- [ ] Type 5 / 3 / 10 for a title → Save → an error. The same goes for donor amounts that go down.
- [ ] Switch **on** → "Saved" straight away.

## 2. The achievements page (as user A)

- [ ] Profile → **My achievements** (just above Invite friends).
- [ ] The green card shows the main title (or "No title yet" with a short hint), a progress bar and "X of 9 titles unlocked".
- [ ] **Next goal:** the title closest to its next level, with "2 of 5".
- [ ] **All titles:** each card shows its emoji, name, stars, a "How to unlock" text and progress. Locked ones are grey.
- [ ] Tap a card → every level with what's needed, the unlock date, "+25 points" and **Set as main title**.
- [ ] **Supporting CodaMi:** 6 donor tiers (Supporter, Bronze to Lifetime) with their amounts, and the Support CodaMi button (only while donations are switched on).
- [ ] Pull down to refresh.

## 3. Earning titles

Each action below should give the title within a few seconds. Then open My achievements (it counts again when it opens).

- [ ] **Community Contributor ★:** publish a lost or found report.
- [ ] **Animal Rescuer ★:** publish a *found* report, then mark it "back home". Or let B mark an emergency resolved after A tapped "I'm helping".
- [ ] **Active Volunteer ★:** tap "I'm helping" on someone else's emergency.
- [ ] **Animal Advocate ★:** share 5 times (reports or Share CodaMi). At most 3 shares count per day, so this takes 2 days. To test faster, set ★ to 2 in Admin.
- [ ] **Community Helper ★:** send feedback, then as admin mark it **Done** in Admin → Feedback.
- [ ] **Trusted Member ★:** comes after 30 active days. To test, set ★ to 1 in Admin.
- [ ] **Verified Pet Sitter ★:** after a pet sitting confirmed by both sides. It isn't given if the average rating is below 4★.
- [ ] **Ambassador:** the invite levels, with the first level now called **"Friend of CodaMi"**. Also check Profile → Invite friends.
- [ ] For each new title:
  - A push arrives: "🏆 New title: Animal Rescuer ★". Tapping it opens My achievements.
  - Back on the main screens, a **celebration window** appears once.
  - In My points, a "New title +10" line appears.

## 4. Where others see the title (as user B)

- [ ] Open A's report → "Posted by Ana" with A's main title below it.
- [ ] Pet sitting:
  - A's sitter profile shows up to 3 title chips under the name.
  - Offers show the sitter's title.
  - A request shows the owner's title.
- [ ] On their own Profile, A sees the main title on the green card. Tapping it opens My achievements.
- [ ] A: My achievements → **Change** → pick another title or **Automatic** → "Saved". B sees the new one.

## 5. Donor titles

- [ ] Admin → Users → A → **Titles** box → **Record a donation** → €25, note "Bank transfer" → Save. A becomes a **Silver Donor** and gets a push saying "Thank you for supporting CodaMi! 💚".
- [ ] A: My achievements → the Silver tier is highlighted, and A sees "Your total: €25 · Only you see this". No points are given for donor titles.
- [ ] A turns off **Show my donor title to others** → B no longer sees it.
- [ ] Admin deletes the donation → the donor title goes away.

## 6. Admin tools on a user's page

- [ ] **Give a title** → Partner Shelter (or CodaMi Team) → the user sees it first, with "Given by the team" in the box.
- [ ] **Take away** a title → it's gone, and the user's card says "Taken away by the team". **Allow again** brings it back.

## 7. Switched off

- [ ] Admin switches titles **off** → users no longer see My achievements, the chips or celebrations. Activity is still counted, but no points or pushes are given. Admins still see everything.

## 8. Languages

- [ ] Italian, German and Arabic: the page, chips, celebration and push read well. Arabic reads right to left.

## If something goes wrong

- **No title after an action:** open My achievements and pull down to refresh, then check `achievements/<uid>` in Firestore (`counts`, `levels`). Check `firebase functions:log --only refreshMyTitles`.
- **Automated checks:**
  - `flutter test test/titles_test.dart`
  - `cd functions && npm test`
  - `emulator_tests/titles.cjs`
