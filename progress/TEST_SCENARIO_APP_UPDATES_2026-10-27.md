# CodaMi: App Updates Test Scenario, Tue 27 Oct Build

Step-by-step test of the update check, update message, "Update now" button and required updates on a real Android phone. Each step says what you should see. Tick the box when it works; write what happened when it doesn't.

**You need:**
- An **admin** account (admin@codami.com)
- A **normal user** account (Ammar)
- The Oppo with the Tue 27 Oct build installed (version **1.0.0**)
- The Firebase console open on the computer (only for step 6.6)

**Before you start:**
1. Rules are deployed: `firebase deploy --only firestore:rules` (done Tue 27 Oct).
2. Clear the earlier test: Admin → More → **App updates**, empty Android "Latest version" and "Minimum version", **Save**. Admin → More → **What's new**, delete **Version 1.1.0** (test notes).
3. This test uses version **1.2.0**. The update message shows once per version, and 1.1.0 was already shown on this phone during development.

**For the video:** record steps 4 and 6. They show what users see. Steps 2 and 3 show how the team manages it.

---

## 1. No update

- [ ] **1.1** User: open the app.
  - Expected: Home as usual. No update message, no update banner.
- [ ] **1.2** User: Profile.
  - Expected: no "Update available" row.

## 2. Admin screen and its checks

- [ ] **2.1** Admin: More → **App updates**.
  - Expected: green header "Versions in the stores", "This phone has version 1.0.0", an Android section (Latest version, Minimum version) and an iPhone section (Latest version, Minimum version, App Store ID).
- [ ] **2.2** Android latest: type `1`, **Save**.
  - Expected: "Fill in the fields marked in red." Under the field: "Use a version like 1.2.0".
- [ ] **2.3** Start typing in the field.
  - Expected: the red message disappears.
- [ ] **2.4** Android latest `1.2.0`, minimum `1.3.0`, **Save**.
  - Expected: refused, under the minimum: "The minimum can't be higher than the latest version".
- [ ] **2.5** Empty the minimum. App Store ID: type `12ab`, **Save**.
  - Expected: refused, "The App Store ID has only digits". Empty the App Store ID afterwards.

## 3. Connection to What's new

- [ ] **3.1** Android latest `1.2.0` (don't save yet).
  - Expected: under it, "No What's new notes for 1.2.0 yet" and a **What's new** button.
- [ ] **3.2** Tap **What's new** → **Add version**: version `1.2.0`, **Published** off, under New write `Update messages inside the app`, under Fixed write `Small fixes`. **Save**, then go back.
  - Expected: App updates now says "The notes for 1.2.0 are saved but not published".
- [ ] **3.3** What's new → open 1.2.0 → turn **Published** on → **Save** → back.
  - Expected: "The notes for 1.2.0 are published and shown with the update" with a green tick.
- [ ] **3.4** **Save** App updates.
  - Expected: "Saved". Android latest is 1.2.0 and the minimum is empty.

## 4. Update available (user)

- [ ] **4.1** Sign out, sign in as the user, close the app fully and open it again.
  - Expected: Home, then an **Update available** sheet: "Version 1.2.0 of CodaMi is ready. You have 1.0.0.", the 1.2.0 notes (New, Fixed), **Update now** and **Later**.
  - Note: if the sheet already showed after signing in, that counts too: it shows once per version.
- [ ] **4.2** Tap **Later**.
  - Expected: the sheet closes. A green banner on Home: "Version 1.2.0 is available" with **Update now** and an X.
- [ ] **4.3** Tap the banner (not the button).
  - Expected: the sheet opens again with the notes.
- [ ] **4.4** Tap **Update now**.
  - Expected: Google Play opens on the CodaMi page. It shows "Open" instead of "Update" because 1.2.0 isn't really in the store; that's expected in this test.
- [ ] **4.5** Go back to CodaMi. Profile.
  - Expected: an **Update available** row: "Version 1.2.0 is available". Tapping it opens the sheet.
- [ ] **4.6** Close the app fully and open it again.
  - Expected: no sheet this time (once per version), the Home banner is still there.
- [ ] **4.7** Tap the X on the banner. Close and reopen the app.
  - Expected: the banner is gone (hidden for 3 days). The Profile row is still there.
- [ ] **4.8** Change the phone language to Italian (Profile → Language) and open the Profile row.
  - Expected: the sheet is in Italian ("Aggiornamento disponibile", "Aggiorna ora"). The notes show in English because only English was written. Switch back to English.

## 5. Changes arrive without restarting (two phones only)

Skip with one phone.

- [ ] **5.1** User phone: stay on Home. Admin phone: App updates → Android latest `1.2.1` → Save.
  - Expected: within a few seconds, the user's banner changes to "Version 1.2.1 is available", without closing the app. Set it back to `1.2.0`.

## 6. Required update

- [ ] **6.1** Sign out, sign in as the admin. More → App updates → Android minimum `1.2.0` → **Save**.
  - Expected: a dialog: "Require the update? Everyone below version 1.2.0 will have to update before they can use the app." with Cancel and Require.
- [ ] **6.2** Tap **Cancel**.
  - Expected: nothing saved, the app works normally.
- [ ] **6.3** **Save** again → **Require**.
  - Expected: straight away, the whole app is covered by **Update required**: "This version of CodaMi is no longer supported. Update to version 1.2.0 to keep using the app.", the 1.2.0 notes, **Update now** and, because this is an admin, **Continue as admin**. No keyboard on screen.
- [ ] **6.4** Tap **Continue as admin**.
  - Expected: back in the admin panel (only until the app is closed). Sign out, sign in as the user.
- [ ] **6.5** Close the app fully and open it again.
  - Expected: **Update required** right away, with only **Update now** (no admin button). The phone's back button doesn't get past it. **Update now** opens Google Play.
- [ ] **6.6** On the computer: Firebase console → Firestore → `config` → `appVersion` → set `androidMinimum` to empty (`""`). Keep the app open on the phone.
  - Expected: within a few seconds the block disappears by itself and the user is back on Home. This shows it's all controlled remotely.

## 7. Clean up

- [ ] **7.1** Admin: More → App updates: empty Android latest and minimum → **Save**.
- [ ] **7.2** Admin: More → What's new: delete **Version 1.2.0** (test notes).
- [ ] **7.3** User: close and reopen the app.
  - Expected: no update message, no banner, no Profile row.

## Not testable yet

- **iPhone:** "Update now" needs the App Store ID, which exists once CodaMi is on the App Store. Without it, the button shows "Couldn't open the store".
- **A real store update:** after the next release is live in Google Play, setting its version as latest will show "Update" in Google Play instead of "Open".
