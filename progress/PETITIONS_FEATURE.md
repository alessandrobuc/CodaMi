# CodaMi: Animal Welfare Petitions

Request from the client (Mon 26 Oct 2026). The CodaMi team picks existing petitions from trusted sites and organizations; users read them in the app and sign on the original page.

_Last updated: Mon 26 Oct 2026 (built, live, tested on the Oppo; image upload still to try)_

---

## Client requirements

- Users never create petitions. Only the CodaMi team adds them, by hand.
- Sources such as Change.org, Care2, Avaaz and recognized animal protection organizations. Each petition is checked one by one; no source is approved automatically.
- Admins can add, review, approve or reject, publish, update and remove petitions.
- Each entry has the original URL, title, source, animal welfare topic, country or area (when relevant), publication date and status.
- Status: active, completed, closed or no longer available.
- Cards in the app: title, image (only with permission), short summary, source, "View petition" button.
- Detail page: the issue, the requested action, why it matters for animals, where the original petition is.
- Signing happens on the original site. No signatures collected in CodaMi, no signature counts shown.
- Before publishing, the team checks the page exists, is a genuine animal welfare issue, has a clear goal and makes no misleading claims.
- Our own summaries, not copied text. Respect the source sites' terms, copyright and image rights.
- Only admins can change petitions, enforced on the server.
- Keep the feature separate from Firebase-specific code so it can move to another backend later.

## Not in scope

- Users submitting petitions
- Signature collection or live signature counts
- Integration or API with petition sites (to be evaluated separately)

## Decisions (our defaults until the client answers)

- **Where:** a banner on Home (Home is the map / lost / found screen, so no room for a full section) and Profile → Petitions
- **Language:** one summary per petition, written by the admin
- **Approval:** any admin can approve and publish
- **Notifications:** none for now

## Questions sent to the client

- [ ] Home section or a separate section?
- [ ] Summaries in one language or several?
- [ ] Any admin publishes, or a second admin approves?
- [ ] Notify users when a new petition is published?

---

## Plan

**Data and security**
- [x] Petition model (URL, title, source, topic, country, date, summary, issue, action, why it matters, image, review status, petition status, created/updated by and at)
- [x] Repository interface plus Firebase implementation
- [x] Firestore rules: users read only published; admin-only writes; field and https link checks; `updatedBy` must be the signed-in admin
- [x] Firestore index (published + date)
- [x] Storage rules for `petitions/` images (admin only, images only, size limit)

**Admin side**
- [x] Admin → More → Petitions list with a status filter
- [x] Add / edit form with image upload and an "image permission confirmed" check
- [x] Approve, reject, publish, unpublish
- [x] Status: active, completed, closed, no longer available
- [x] Delete with confirmation

**App side**
- [x] Home banner "N animal welfare petitions to sign" (shown only when there are active ones), plus Profile → Petitions
- [x] Petitions list and cards
- [x] Detail page
- [x] "View petition" opens the original page in the browser

**Finish**
- [x] Labels in all 10 languages
- [x] Rule tests
- [x] Emulator test
- [x] Deploy rules, indexes and storage
- [x] Update PENDING_TASKS, the week file and LAUNCH_CHECKLIST
- [ ] Screenshots and an update to the client

## Later (only if the client asks)

- Daily check that flags petitions whose original page no longer opens
- Summaries in several languages
- Notification for new petitions
- Second-admin approval

---

## What was built (Mon 26 Oct)

- **Code:** `lib/features/petitions/`. `domain/` has the model and the `PetitionsRepository` interface (no Firebase code); `data/firestore_petitions_repository.dart` is the only Firebase part.
- **Data:** `petitions/{id}`: url, title, source, topic, country, startedOn, summary, issue, action, why, imageUrl / imagePath, imagePermission, review (pending / approved / rejected / published), status (active / completed / closed / unavailable), checks (exists, genuine, clearGoal, notMisleading), rejectReason, createdBy / createdAt, updatedBy / updatedAt, publishedAt.
- **Rules:** users read only `review == published`; only admins write; https links only; field lengths; approving or publishing needs all four checks; an image needs the permission box and must be in the petition's own folder; `updatedBy` is the signed-in admin and `updatedAt` the server time; no extra fields (so no signature counts).
- **Storage:** `petitions/{id}/image_<time>.(jpg|png|webp)`, admin only, images under 5 MB.
- **Topics:** pets, wildlife, farm animals, animal testing, circuses and zoos, marine life, other.
- **Users:** a "No longer available" petition keeps its card but the button is off; closed or completed ones show a badge and go below active ones.
- **Tests:** `test/petition_test.dart` (7) and `emulator_tests/petitions.cjs` (37 checks).
