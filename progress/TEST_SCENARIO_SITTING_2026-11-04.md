# CodaMi: Pet sitting test (Wed 4 Nov)

Phase 5, request 3 (`PHASE_5_REQUESTS.md` §8). Two phones: **A = owner**, **B = sitter**. Both accounts need a city set in Profile.

**Before testing**
1. Deploy: `firebase deploy --only functions,firestore:rules,firestore:indexes` (new functions `acceptSittingOffer`, `confirmSitting`, `reviewSitter`, `adminSetReviewHidden`, `onSittingOffer`, `onSittingMessage`; rules; a new index for open requests: wait until it shows "Enabled" in Firebase console → Firestore → Indexes).
2. New build on both phones.

Note anything wrong in `PENDING_TASKS.md` under "Fixes found while testing".

---

## 1. Switch it on (admin)
1. Admin → More → **Pet sitting** → Settings: switch **Show to users** on ("Saved" at once). Leave "Days before a new account can review" at 3, or set 0 for today's test → Save.
2. Both phones: Pets tab shows a blue **Pet sitting** card; Profile has a Pet sitting row.

## 2. Sitter profile (phone B)
3. Pet sitting → **Mine** → **Become a pet sitter**: about me, experience, animals, services, availability, distance, Save.
4. Mine shows the profile "Visible to pet owners".

## 3. Request (phone A)
5. Pet sitting → Mine → **New request**: choose a pet, "Overnight at home", dates **starting today**, details, budget → Publish. "Shown as: [city]" (never an address).

## 4. Offer (phone B)
6. **Requests** tab → the request (with distance) → **Send an offer** → message + price → Send.
7. Phone A gets a push "New pet sitting offer". The request shows **Offers (1)**.

## 5. Chat
8. Phone A → on the offer: **Chat** → write → phone B gets a push with the message; chat icon / Pets card shows the unread count.
9. Phone B replies. Both see the messages; the list in **Chats** shows the last one.

## 6. Book
10. Phone A → **Accept** → confirm → "Booked!". Phone B gets "Your offer was accepted"; the request shows "You're the pet sitter for this request".
11. A second sitter's offer (optional, phone C) turns "Declined".

## 7. Confirm and review
12. Phone A → **Did the pet sitting take place? → Yes, it was done** → "Waiting for the other person to confirm". Phone B gets a push.
13. Phone B → **Yes, it was done** → request "Completed"; B's profile "Completed: 1".
14. Phone A → **Review [name]** → 5 stars + text → Send. B's profile: stars, "(1)", the review with **Verified service**. "Review" again → not offered.

## 8. Report and block
15. Phone A → B's profile → ⋮ → **Report** → reason → Send. Admin → Pet sitting → **Reported** shows it → **Hide** → B's profile disappears for A; **Show** again from the Sitters tab.
16. Admin → **Reviews** → **Hide** a review → it leaves B's rating; Show brings it back.
17. Phone B → chat → ⋮ → **Block** A → "You blocked …" in place of the input; A can't send any more messages, and A's requests and offers no longer show for B.

## 9. Close
18. Phone A → a new open request → **Close the request** → status "Closed", no more offers.

## 10. Languages
19. Italian, German and Arabic: all screens, chips and dates fit; Arabic right-to-left.
