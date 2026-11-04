# CodaMi: AI breed scanner test (Wed 4 Nov)

Phase 5, request 1 (`PHASE_5_REQUESTS.md` §6).

**Before testing**
1. Google Cloud → project `codami-cd91e` → APIs & Services → enable **Vertex AI API** (`aiplatform.googleapis.com`).
2. Deploy: `firebase deploy --only functions,firestore:rules` (new `scanBreed` function, `config/scanner` rules).
3. Run the new build on the phone (a full build, not a hot restart).
4. You need an **admin** account and a **user** account with at least one pet. Have a few photos ready: a pure-breed dog, a cat, a mixed-breed dog, another animal (rabbit, bird…), a blurry or dark photo, and a photo with no animal.

Note anything wrong in `PENDING_TASKS.md` under "Fixes found while testing".

---

## 1. Admin settings
1. Admin → More → **Breed scanner** (new row after Places to walk).
2. Header text, "Show to users" off, **Scans per user per day** 10, **AI model** `gemini-3.8-flash`.
3. Type 0 or 101 in scans per day → Save → error. Put back 10, Save → "Saved".
3b. Tap the **AI model** tile → list "Gemini models Google offers right now" (if it says Google's list couldn't be loaded, send the `scannerModels` log), newest first, each with a note (cheapest / fast and accurate / most accurate), `gemini-3.8-flash` marked **Recommended**. Pick another model, Save, scan once, then put back `gemini-3.8-flash` and Save.

## 2. Admin tries it while it's off
4. **Try the scanner** → intro: title, text, 3 photo tips, Take a photo, Choose from gallery, AI estimate note and "photo is not saved" note.
5. Take a photo of a dog → photo with a spinner and "Looking at the photo…" (a few seconds) → result.
6. User account: while it's off there's **no** scanner card in the Pets tab, no Breed scanner row in Profile and no "Find the breed with AI" button in the pet form.

## 3. The result
7. Pure-breed dog: species chip, **Most likely** breed with % and coloured bar, "Very likely" / "Likely" / "Not sure", **Other possible breeds** with %, **About this breed** (size, weight, life span, temperament, characteristics, care), the AI estimate note.
8. Mixed-breed dog: **Mixed breed** chip, "Other breeds in the mix", "About this mix".
9. Cat and another animal (rabbit, bird…): right species and breeds.
10. Blurry or dark photo: orange "The photo isn't very clear…" box.
11. Photo with no animal: "No animal found" and only "Try another photo".
12. **Try another photo** opens camera / gallery and scans again.

## 4. Users
13. Admin: switch **Show to users** on → "Saved" appears straight away (no Save button needed). Leave the screen and come back: still on.
14. User: **Pets tab** → purple card "Which breed is it?" under the header (also with no pets yet) → opens the scanner. Also Profile → **Breed scanner** row. Scan a photo of their pet.
15. **Save breed to my pet** → choose the pet (same species listed first) → "Breed saved for …" → open the pet: breed field filled (mixed: "Breed A × Breed B").
16. User without pets: Save breed → "Add a pet first…".
17. Add / edit a pet → under Breed, **Find the breed with AI** → scan → **Use this breed** → back in the form with the breed filled; save the pet.

## 5. Daily limit
18. Admin: set scans per day to 2, Save. User: scan 3 times → the third shows "You've used today's scans. Try again tomorrow." Set it back to 10.

## 6. Languages
19. Switch to Italian: scanner texts **and** the breed names and facts from the AI come in Italian.
20. Arabic: right-to-left layout, percentages and bars fine, nothing cut off. German: long words fit.

## 7. Server side (optional)
21. Google Cloud → Logging: each scan logs "Breed scanned" with the model, species and confidence; no photo is kept anywhere (Storage and Firestore have nothing new except `scanUsage/{uid}` with the day and count).
