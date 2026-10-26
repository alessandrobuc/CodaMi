# CodaMi: Petitions Test Scenario, Mon 26 Oct Build

Step-by-step test of the animal welfare petitions feature on real phones. Each step says what you should see. Tick the box when it works; write what happened when it doesn't.

**You need:**
- An **admin** account (for example admin@codami.com)
- A **normal user** account (for example ammar@gmail.com)
- One phone is enough (sign out and in to switch). With two phones, keep the admin on one and the user on the other: changes show on the user's phone straight away.
- A photo in the phone's gallery (any animal picture)

**Before you start:**
1. Rules and index are deployed: `firebase deploy --only firestore:rules,firestore:indexes,storage`. In Firestore → Indexes, the `petitions` index (review + publishedAt) shows **Enabled**.
2. The latest build is installed on the phone.
3. There are no petitions yet (Admin → More → Petitions shows "No petitions here").

---

## 1. Empty state

- [ ] **1.1** User: Home.
  - Expected: no purple petitions banner.
- [ ] **1.2** User: Profile → **Petitions**.
  - Expected: the "Petitions" page with "No petitions yet. The team will add animal welfare campaigns here."
- [ ] **1.3** Admin: Admin → More → **Petitions**.
  - Expected: filters All (0), To review (0), Approved (0), Rejected (0), Published (0), the empty message and an **Add petition** button.
- [ ] **1.4** Support account (if you have one): Admin → More.
  - Expected: no Petitions entry (admins only).

## 2. Form checks (admin)

- [ ] **2.1** Tap **Add petition**, then **Save** without filling anything.
  - Expected: "Fill in the fields marked in red." Link, Title, Platform, Short summary, The issue, What the petition asks for and Why it matters are red.
- [ ] **2.2** Type a title.
  - Expected: the red "Required" under Title disappears while typing.
- [ ] **2.3** Link: type `change.org/p/test` (without https://) and save.
  - Expected: refused; under the link: "Paste the full link, starting with https://".
- [ ] **2.4** Link: type `http://www.change.org` (http, not https) and save.
  - Expected: refused the same way.
- [ ] **2.5** Fill in everything with a correct link (for example `https://www.change.org/`), choose **Published**, leave the 4 verification boxes empty and save.
  - Expected: "Tick all verification checks before approving or publishing." The Verification icon turns red.
- [ ] **2.6** Choose **Approved** with the boxes still empty and save.
  - Expected: the same message.
- [ ] **2.7** Tick only 3 of the 4 boxes and save as Published.
  - Expected: still refused.
- [ ] **2.8** Tap the **open link** icon next to the link box.
  - Expected: the page opens in the browser, so the admin can check it exists.

## 3. Review steps (admin)

Use this test text:
- Title: `TEST Ban wild animals in circuses`
- Platform: `Change.org`
- Country: `Italy`
- Topic: **Circuses and zoos**
- Summary, issue, action and why: one short sentence each

- [ ] **3.1** Save it as **To review** (no boxes needed).
  - Expected: "Saved". The list shows the petition with "To review" and "Active". The filters show To review (1).
- [ ] **3.2** User: Home and Profile → Petitions.
  - Expected: nothing new. Users don't see petitions under review.
- [ ] **3.3** Admin: open it, choose **Rejected**, type a reason (`Test reject`) and save.
  - Expected: the "Rejected" badge, and the reason is kept when you open it again.
- [ ] **3.4** User: Profile → Petitions.
  - Expected: still empty.
- [ ] **3.5** Admin: open it, choose **Approved**, tick all 4 boxes and save.
  - Expected: the "Approved" badge. The reject reason is gone.
- [ ] **3.6** User: still nothing (approved is not published).
- [ ] **3.7** Admin: open it, choose **Published** and save.
  - Expected: the "Published" badge. At the bottom of the form: "Added … · Published … · Updated …".

## 4. What users see

- [ ] **4.1** User: Home.
  - Expected: the purple banner "1 animal welfare petition to sign" under the emergency banner (if there is one).
- [ ] **4.2** Tap the banner.
  - Expected: the Petitions page. At the top: "The CodaMi team checks every petition before it appears here…". Then the card with the topic icon, "Circuses and zoos · Italy", the title, the summary, "Change.org" and **View petition**.
- [ ] **4.3** Tap **View petition** on the card.
  - Expected: the original page opens in the browser (not inside CodaMi).
- [ ] **4.4** Go back to CodaMi and tap the card.
  - Expected: the detail page with the Active, topic and country badges, title, summary, then The issue, What the petition asks for, Why it matters for animals, and Original petition (platform and website). At the bottom: the disclaimer and a **Read and sign on the original site** button.
- [ ] **4.5** Tap **Read and sign on the original site**.
  - Expected: the browser opens the petition page.
- [ ] **4.6** Profile → **Petitions**.
  - Expected: the same list (second way in).
- [ ] **4.7** Change the app language (Profile → Language → Italiano) and open Petitions again.
  - Expected: all labels in Italian (the admin's own text stays as written). Switch back afterwards.

## 5. Image

- [ ] **5.1** Admin: open the petition → Image → **Add image**, pick a photo, leave the permission box empty and save.
  - Expected: "Confirm you have permission to use the image, or remove it." The permission text is red.
- [ ] **5.2** Tick **We have permission to use this image** and save.
  - Expected: "Saved". The admin list shows the photo as the small picture.
- [ ] **5.3** User: Petitions.
  - Expected: the card and the detail page show the photo.
- [ ] **5.4** Admin: **Change image**, pick another photo, tick the box and save.
  - Expected: the new photo shows for users. The old file is removed from Storage (`petitions/{id}/`).
- [ ] **5.5** Admin: **Remove** and save.
  - Expected: the card shows the topic icon again.
- [ ] **5.6** Pick a photo larger than 5 MB (if you have one).
  - Expected: "The image is too large. Choose one under 5 MB."

## 6. Petition status

- [ ] **6.1** Admin: Petition status → **Completed** and save.
  - User: the Home banner disappears (no active petitions). In Petitions, the card has a blue "Completed" badge and **View petition** still works. The detail page says "This campaign has ended. You can still read the original page."
- [ ] **6.2** Admin: **Closed**.
  - User: grey "Closed" badge, same as above.
- [ ] **6.3** Admin: **No longer available**.
  - User: red "No longer available" badge. **View petition** is greyed out. The detail page says "The original petition is no longer available." and its button is off.
- [ ] **6.4** Admin: back to **Active**.
  - User: the banner comes back.

## 7. Several petitions

- [ ] **7.1** Admin: add 2 more published petitions with different topics (for example **Pets** and **Farm animals**). Mark one of the three as **Closed**.
  - Expected for the user: the banner says "2 animal welfare petitions to sign". In the list, active petitions come first (newest first) and the closed one is last.
- [ ] **7.2** User: the topic filters (All, Pets, Farm animals, Circuses and zoos) appear above the list.
  - Expected: tapping one shows only that topic.
- [ ] **7.3** Admin: tap each filter (To review, Approved, Rejected, Published).
  - Expected: the right petitions and counts.
- [ ] **7.4** Admin: **Unpublish** one (choose Approved and save).
  - Expected: it disappears for the user straight away.

## 8. Delete

- [ ] **8.1** Admin: open a petition → bin icon (top right) → **Cancel**.
  - Expected: nothing happens.
- [ ] **8.2** Bin icon → **Delete**.
  - Expected: it leaves the admin list and disappears for users. If it had a photo, the photo is removed from Storage.
- [ ] **8.3** Delete all the test petitions.
  - Expected: the empty state again, and no banner on Home.

## 9. Security (optional, done on the emulators)

Already checked automatically (`emulator_tests/petitions.cjs`, 37 checks). On a phone you can only see part of it:
- [ ] **9.1** A normal user or support account has no Petitions entry in the admin side.
- [ ] **9.2** Users never see petitions that are To review, Approved or Rejected (tests 3.2, 3.4, 3.6).

---

## Results

| Section | Pass / Fail | Notes |
|---|---|---|
| 1. Empty state | | |
| 2. Form checks | | |
| 3. Review steps | | |
| 4. What users see | | |
| 5. Image | | |
| 6. Petition status | | |
| 7. Several petitions | | |
| 8. Delete | | |
| 9. Security | | |

Already passed on the Oppo (Mon 26 Oct): 1.1–1.3, 2.1–2.3, 2.5, 3.7, 4.1–4.5, 6.3, 8.2. Not yet: images (section 5) and the rest.
