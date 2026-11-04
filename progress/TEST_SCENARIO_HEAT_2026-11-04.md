# CodaMi: Heat calendar test (Wed 4 Nov)

Phase 5, request 2 (`PHASE_5_REQUESTS.md` §5).

**Before testing**
1. Deploy: `firebase deploy --only functions,firestore:rules` (new `heatReminderSweep`, rules for `heatCycles`, `heatReminders`, `config/heat`).
2. Run the new build on the phone.
3. Accounts: **admin**, and a **user** with a female dog, a female cat and a male pet.

Note anything wrong in `PENDING_TASKS.md` under "Fixes found while testing".

---

## 1. Admin settings
1. Admin → More → **Heat calendar** (after Breed scanner).
2. "Show to users" off; Dog 180 / 18, Cat 21 / 7, Other 0 / 7.
3. Type Dog cycle 3 → Save → error. Put back 180 → Save → "Saved".
4. While it's off, the admin's own female pet page already shows the **Heat calendar** card; the user's doesn't.
5. Switch **Show to users** on → "Saved" straight away.

## 2. Pet page
6. User → Pets → female dog: **Heat calendar** card under the details, "Record heats and get reminders…".
7. Male pet: no card.

## 3. First record
8. Open the card → "Record the first heat…", empty history, reminders switch greyed out.
9. **Record a heat** → start about 5 months ago, switch off "Still in heat", end 2 weeks after the start, note "test" → Save.
10. Now: "Next heat expected around …" about 6 months after the start, "In … days", "Cycle about 180 days · heat lasts about 14 days", "Typical for the species…".
11. Calendar: the recorded days in full pink (go back with the arrow), the expected ones light pink, today circled. **Next expected heats** lists 3 periods.

## 4. Own pattern
12. Record a second, older heat about 6 months before the first. The line changes to "Based on 2 recorded heats." and the cycle to their real distance.
13. Tap a heat in **History** → change the dates or notes → Save. Tap again → **Delete** → confirm.

## 5. In heat now
14. Record a heat that started 3 days ago, still in heat → top card "In heat now · Day 4", the card on the pet page says the same. **Heat ended today** closes it.

## 6. Reminders
15. Turn on **Remind me before the next heat** → chips 1 / 3 / 7 / 14 days before (3 selected) and "Next reminder: …".
16. Pick 7 → the date moves. Turn off → chips gone.
17. Real push (optional): record a heat so the next expected start is in 4 days (dog: start 176 days ago), turn reminders on with 3 days before → next morning at 9:00 a "…: heat expected soon" notification, in the phone's language. Check Firestore `heatReminders/{petId}` moves to the next cycle after it's sent.

## 7. Cat and others
18. Female cat with one heat → next expected about 3 weeks later.
19. A female "other" animal with one heat → "Record one more heat…"; after a second one → estimate from the two.

## 8. Privacy and clean-up
20. Another user can't see these heats (they're only on the owner's pet page).
21. Delete the pet → its heats and reminder are gone from Firestore (`heatCycles`, `heatReminders`).

## 9. Languages
22. Italian (calore), German (Läufigkeit), Arabic (right-to-left, calendar starts on the right day), dates in the right format, nothing cut off.
