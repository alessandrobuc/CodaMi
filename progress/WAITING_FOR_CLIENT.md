# CodaMi: Waiting for the Client

Questions sent to the client that still need an answer. Move an item to **Answered** with the date and the answer when it comes back.

_Last updated: Tue 3 Nov 2026_

---

## Sent Wed 21 Oct 2026 (no reply yet)

The client replied with new requests instead (see `PHASE_3_REQUESTS.md`). These are still open:

- [ ] **Support email address** for the Privacy Policy, Terms of Service and the public privacy page (`legalEmail` in `lib/features/legal/legal_content.dart`, `support@email.com` in `docs/index.html`)
- [ ] **Apple Developer account access**, to test and finish Sign in with Apple and iPhone notifications (APNs key), test on a real iPhone and submit to the App Store
- [ ] **Donations: yes or no?** If yes:
  - [ ] Amounts (for example €1 / €3 / €5 / €10 / €25)
  - [ ] Payments profile in Google Play Console and Paid Apps agreement in App Store Connect (tax and bank details, must be done by the client)
  - [ ] RevenueCat account (free until about $2.5k a month, then about 1%), with access for the developer

## Still open from earlier (not in the last message)

- [ ] **Support team:** who answers, which hours, which languages
- [ ] **Support time limits:** confirm 5 min for chat, 24 h for requests, auto-close after 7 days (or new values; changed in `config/support`, no new build needed)
- [ ] **Photos in support chat:** wanted or not (not built)
- [ ] **Videos:** a first set (dogs, cats, general) with the rights to use them; YouTube links as well or not
- [ ] **iPhone sounds:** is Apple's limit acceptable (only the 4 CodaMi sounds on iPhone, no ringtones or music)
- [ ] **Translation review** by a native speaker (Italian first)
- [ ] **Android signing key backup:** confirm they keep a safe copy of the keystore and passwords

## New questions (Phase 3 requests, Wed 21 Oct)

See `PHASE_3_REQUESTS.md` for the details of each request.

AI moderation is decided by us, no questions for the client (see `PHASE_3_REQUESTS.md`).

Referral and emergency questions were answered on Thu 22 Oct (see **Answered** below).

**Follow-up (Thu 22 Oct)**
- [ ] **Emails to organizations:** emergency alerts to vets and associations by email need an email sending service (for example Brevo or SendGrid, free tiers exist). OK to set one up, and which sender address? Until then, organizations are shown in the app for users to call or email directly.
- [ ] **Real contacts:** the list of real vets, associations and services, with phone, email, address and area covered (test placeholders are used until then)

**Review popup (Fri 23 Oct)**
- [ ] **Reward for reviews:** stores forbid points for ratings and reviews. Built as proposed (review prompt without points, points for in-app feedback); the developer is telling the client. (See `PHASE_3_REQUESTS.md` §4)
- [ ] **Patch notes:** who writes them each version, and in which languages (English at least, the others fall back to English)

**Shop (request 18, Thu 29 Oct)**: plan and details in `SHOP_FEATURE.md`. Phase 1 approved Thu 29 Oct
- [ ] Countries we sell to at the start (Italy only?)
- [ ] Company name and VAT number for the shop; Stripe account in CodaMi's name
- [ ] Stripe: account in CodaMi's name, or OK for the developer to use Stripe test keys until then (asked again Mon 2 Nov; needed to start the order system)
- [ ] Email service for order confirmations and supplier order emails (same one as for emergency alerts; asked again Mon 2 Nov)
- [ ] First brands, suppliers or affiliate programmes (otherwise sample products)
- [ ] Languages for product texts (suggested: Italian and English, the others fall back to English)
- [ ] Shop as a new tab in the bottom bar
- [ ] Admin panel on the computer as well
- [ ] Who prepares the terms of sale and the return policy

**Phase 4 requests (Mon 2 Nov)**: details in `PHASE_4_REQUESTS.md`
- [ ] QR invites: invite page on the Firebase address OK for now? Flyer text and language? "Scan QR" button in the app?
- [ ] Donations: store payments (Google / Apple, about 15% fee) OK? Amounts? Payments profile in Play Console; "Supporter" badge? Accountant check
- [ ] Places to walk: where in the app? Default distance? Google cost OK with a budget alert?

**Invite tracking (Tue 3 Nov)**: details in `PHASE_4_REQUESTS.md` §4
- [ ] Confirm the meaning of Active (qualified: 3 active days with a city within 14 days) and Inactive (not active in time, or rejected), and the 30 days for "still using the app"

**Phase 5 requests (Tue 3 Nov)**: plan and details in `PHASE_5_REQUESTS.md`
- [x] Go-ahead: given Wed 4 Nov, no fixed order (the AI breed scanner was built first)
- [ ] Pet sitting: payment between users outside the app (recommended for now), or through the app?
- [ ] AI breed scanner: OK with a small cost per scan (less than 1 cent) and a daily limit? (built with 10 scans per user per day, changeable in Admin)
- [ ] Heat calendar: which animals besides dogs and cats? (built for all species: dogs and cats with typical cycles, other animals estimated from their own records; typical values changeable in Admin)
- [ ] Donor titles: amounts for Bronze, Silver, Gold, Platinum, Lifetime

---

## Answered

**Tue 3 Nov: invite tracking**
- The client wants invites tracked per user, with a count of active and inactive invites, for future activities. Told them the code is permanent and QR scans weren't counted yet; plan in `PHASE_4_REQUESTS.md` §4, built from Tue 3 Nov. The Active / Inactive meaning in the plan was sent for them to confirm.

**Disclaimer wording: approved**
- The client approved the text as it is: "CodaMi is not an emergency service. If an animal is in immediate danger, call 112 or a vet first. Don't rely only on app notifications." Already in the app in all 10 languages.

**Thu 22 Oct: referral system and points**
- Build a **flexible points system** that later features can plug into without rework. We choose the starting values; they must be changeable from the admin panel or config.
- For now: points from **referrals**, a **daily reward** for opening and actively using the app, and a basic **daily activity** system that can grow.
- Invited users don't need points just for registering. We design an **ambassador** strategy for organic growth.
- **No limit** on invitations, but reasonable **anti-fraud** checks (fake accounts, repeated sign-ups, abuse). Device checks allowed if they respect privacy law and store policies, collect no unnecessary data, and never automatically punish people who share a device.
- Points, referral rules and daily rewards must all be adjustable later.

**Thu 22 Oct: emergency management**
- Build it **now**, before launch.
- Users report animal emergencies; the right people or organizations are notified.
- Vets, associations and services show their **phone and email in the app** so users can contact them directly.
- Start with clearly marked **test placeholder contacts**, never presented as real or verified.
- **Contact directory managed from the admin panel**: add, edit, verify, remove.
- Notifications **prioritized by distance and relevance**: nearest suitable and available contacts first, recommended organizations can take precedence. **Radius and priority rules configurable**, not one fixed distance.
- The app must clearly say **CodaMi is not a replacement for emergency services**.
- Structure both features for future expansion.
