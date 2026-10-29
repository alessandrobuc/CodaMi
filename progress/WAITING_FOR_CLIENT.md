# CodaMi: Waiting for the Client

Questions sent to the client that still need an answer. Move an item to **Answered** with the date and the answer when it comes back.

_Last updated: Thu 29 Oct 2026_

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
- [ ] First brands, suppliers or affiliate programmes (otherwise sample products)
- [ ] Languages for product texts (suggested: Italian and English, the others fall back to English)
- [ ] Shop as a new tab in the bottom bar
- [ ] Admin panel on the computer as well
- [ ] Who prepares the terms of sale and the return policy

---

## Answered

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
