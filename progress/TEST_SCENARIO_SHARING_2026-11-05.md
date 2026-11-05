# CodaMi: Social sharing test (Thu 5 Nov)

Phase 5, request 5 (`PHASE_5_REQUESTS.md` §2).

**Before testing**
1. Deploy: `firebase deploy --only functions,firestore:rules,hosting` (new `reportPage` and `logReportShare`, the `/r/**` page on hosting, rules for `config/sharing`, `reportShares`, `shareStats`).
2. Run the new build (it has the new "Open in CodaMi" link, so install it fresh).
3. A phone with WhatsApp, Facebook, Instagram and TikTok installed if possible, and a second phone or a computer to open links.

Note anything wrong in `PENDING_TASKS.md` under "Fixes found while testing".

---

## 1. Admin
1. Admin → More → **Social sharing** (before My schedule): "Share pop-up" off, Last 30 days 0 / 0.
2. While it's off, admins already get the pop-up; users don't (the Share button on reports always works).
3. Switch it on → "Saved".

## 2. Pop-up after publishing
4. Publish a **lost** report with a photo and a reward → the sheet "Help bring … home" opens with the share image: photo, orange LOST label, CodaMi logo, name, species and area, "Lost on …", the reward, a QR code and the green CodaMi bar.
5. **Not now** closes it. Publish a **found** report → green FOUND label, "Help find the family", no reward.

## 3. Each app (the image always goes with it)
6. **WhatsApp** → on Android WhatsApp opens straight away with the **image and the text + link as its caption**; pick a chat and send. On iPhone the share menu opens with the image and text: pick WhatsApp.
7. **Facebook** → "Caption with the link copied…", then Facebook opens with the **image**; paste the caption (Facebook doesn't accept text from other apps). Without the Facebook app: the Facebook share page opens with the link card.
8. **Instagram** → "Caption copied…", Instagram opens with the image (feed, story or message); paste the caption. In a story you can add Instagram's link sticker with the copied link.
9. **TikTok** → same: photo post with the image, paste the caption.
10. **More** → the phone's share menu (Telegram, Messenger, X, SMS, email) with image + text + link.
11. **Save image** → in the gallery, 1080×1080. **Copy link** → "Link copied".
12. An app that isn't installed → the share menu opens instead, still with the image.

## 4. The public page
12. Open the link on another phone or a computer: CodaMi header, photo with the LOST label, name, species, area, date, reward, description, "Seen Luna? Open CodaMi…", store buttons, **Share this page**.
13. No phone number, email, owner name or exact address anywhere.
14. On Android with CodaMi installed: **Open in CodaMi** opens the report in the app. Without the app: it goes to Google Play.
15. Scan the QR code on the saved image → the same page.
16. Change the phone to Italian / German → the page follows the sharer's language (`?l=`).

## 5. Back home
17. Mark the lost report as found → after the confirmation, the sheet "Share the happy news! 🎉" with a green BACK HOME image ("Luna is back home!"). The page now shows "Luna is back home! 🎉".
18. Delete a report → its page says "This report is no longer available".

## 6. Numbers
19. On your own report, Share → "Shared 3 times · 5 page visits" above the buttons.
20. Admin → Social sharing: shares and page visits for the last 30 days, "Shared to" and "Visits from" (WhatsApp, QR code, Direct link…).

## 7. Languages and small phones
21. Italian, German and Arabic (right to left): the sheet, the image and the page fit and read well.
