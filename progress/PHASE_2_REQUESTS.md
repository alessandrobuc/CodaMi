# CodaMi: Phase 2 Requests

The client's new feature requests (received Thu 15 Oct 2026), what already exists, and the proposed approach. Scope is still to be agreed with the client before work starts.

## Decisions (Thu 15 Oct)
- **Admin side inside the same app, fully separate from the user side.** After login, `AuthWrapper` reads the role: admins and support staff go to the **admin side** with its own navigation bar and screens; everyone else goes to the normal app.
- **Roles:** a `role` field on each user's profile (`users/{userId}`): `user` (default when missing), `support` or `admin`. The first admin is set once by hand in the Firebase console. Admins then add or remove support staff from inside the app.
- **Reward:** a private arrangement between users. CodaMi does not guarantee or process the payment.
- **Donations:** the interface is built first; the payment integration is decided by the client after reviewing the options below. CodaMi is not a registered nonprofit, so in-app payments must use Google Play Billing and Apple In-App Purchase.
- **Videos are uploaded and managed by admins** from the admin section of the app.

_Last updated: Fri 16 Oct 2026_

| # | Request | Status | Size |
|---|---|---|---|
| 1 | Language selection on first launch | Done (Thu 15 Oct) | Small |
| 2 | Administrative dashboard | Mostly done (roles, dashboard, support staff, reported content, listings, users). Tickets and videos left | Large |
| 3 | Custom notification sounds | Not started | Medium |
| 4 | Optional cash reward on lost listings | Done (Thu 15 Oct) | Small |
| 5 | Educational videos and support prompts | Not started | Medium |
| 6 | Optional donations | Not started | Small (interface) + Medium (payments) |
| 7 | Support tickets and live chat | Not started | Large |

---

## 1. Language selection on first launch

**Already done**
- [x] All 10 languages, each shown in its own name with a flag
- [x] Choice saved on the phone and on the user's profile, kept between launches
- [x] Change it later in Profile → Language
- [x] Every screen, button, error message, phone notification, share text and legal page translated; notifications sent in each user's language

- [x] Full-screen language picker with a **Continue** button, shown once on first launch before onboarding. Tapping a language previews it straight away. Existing users who already chose a language do not see it again.

## 2. Administrative dashboard

**Done (Thu 15 Oct)**
- [x] `role` on `users/{userId}`; missing means `user`. New accounts are saved with `role: user`.
- [x] Firestore rules: nobody can change their own role; admins can only switch other users between `user` and `support` and cannot touch any other field; admins can never be created or removed from the app; only admins can read other users' profiles (31 rule checks pass in the emulator)
- [x] `AuthWrapper` sends staff to the **admin side** (`AdminShell`) and everyone else to the user app. A role change takes effect live.
- [x] Admin side navigation: **Dashboard**, **Listings** (admin only), **Reported**, **Tickets**, **More**
- [x] Dashboard: registered users (admin only), open lost reports, open found reports, pets back home
- [x] More: **Support staff** (admin only: add by email, list, remove), Users and Videos (soon), language, sign out
**Done (Fri 16 Oct)**
- [x] In-app **report a listing** (reason + optional note, once per user) and **block a user** (listings and alerts hidden, Profile → Blocked users)
- [x] **Reported** tab (staff): reports grouped per listing; dismiss, hide or (admin) delete
- [x] **Listings** tab (admin): Open / Resolved / Hidden filters; hide, restore, delete
- [x] **Users** (admin): list, search by email, details, disable / enable (server function, also hides and restores their open listings), delete (server function)
- [x] Rules: `flags` collection, staff hide/restore, admin delete, protected `disabled` field (32 rule checks pass in the emulator)
- [ ] Tickets and Videos screens (marked "Soon")

**First admin:** Firebase console → Firestore → `users` → your user document → add field `role` (string) = `admin`.

**Approach (decided: same app, role-based navigation)**
- **Role** stored on the user profile (`users/{userId}.role`), protected by the rules so users can never change it themselves.
- **Admins add support staff** from the admin side (search a user by email, set or remove the support role). New admins are added only in the console, so an admin account can never be taken over through the app.
- The role is checked in Firestore rules (and later Storage rules and Cloud Functions), so hiding screens is not the only protection.
- `support` role: tickets and live chat. `admin` role: everything, including users, listings and videos.
- Screens: users (view, disable, delete), listings (view status, edit, hide, remove), reported content queue, support tickets and chat (see 7), videos (see 5)
- Store review: Apple and Google reviewers sign in with a normal account, so admin screens are never shown to them. No extra store forms needed.
- Needs **in-app report / block** first (also required by Apple guideline 1.2 and expected by Google Play)

## 3. Custom notification sounds

**Already there:** all notifications use the phone's default sound.

**Proposed approach**
- 4–6 short sounds bundled in the app, plus **Default** and **Silent**
- Preview by tapping a sound in Profile → Notifications
- Choice saved on the profile; the server sends each alert with the user's sound
- Android: one notification channel per sound (Android does not allow changing a channel's sound after it is created). iOS: sound files bundled in the app, under 30 seconds.

## 4. Optional cash reward on lost listings

**Done (Thu 15 Oct)**
- Optional **amount in euros** (whole euros, up to 99,999) on the "Details" step of a **lost** report; empty means no reward. Checked by the Firestore rules too.
- Shown as a badge on the listing card, a badge and a "Reward" card on the report page, in the review step and in the share text. Formatted for the app language (€1,500 / 1.500 €).
- Clear note: "The reward is a private arrangement between users. CodaMi does not guarantee or process payments."
- Hidden automatically when the report is marked as found
- CodaMi never handles money, so there are no payment or licensing obligations
- Re-check the Play content rating answer about cash rewards before release

## 5. Educational videos and support prompts

**Already there:** nothing.

**Proposed approach**
- **Admins upload videos from the admin section** (decided). Files go to Firebase Storage and each video gets a Firestore entry (title, language, topic, thumbnail, active flag), so content changes never need a new app version.
- Admins can hide, reorder or delete videos at any time
- A few test videos at first, rotated between sessions
- Shown only in calm places (for example the home list or a "Learn" card), never during report creation or contact flows
- Support prompts shown occasionally (for example at most once a week), always easy to dismiss

**Notes**
- Keep videos short (under 2 minutes) and compressed (720p). Firebase Storage charges for every view, so a budget alert is important.
- The client is responsible for having the rights to every uploaded video.

## 6. Optional donations

**Already there:** nothing.

**Interface (built first)**
- A friendly "Support CodaMi" prompt after publishing a report and after marking a pet as found, with **Not now** always visible. Never blocks the main action.
- Kept behind an on/off switch (Firestore config) and **off in the store build** until payments are connected, so users and store reviewers never see a button that does nothing.

**Payment integration (client to decide)**
- Because CodaMi is not a registered nonprofit, payments made inside the app must use **Google Play Billing** (Android) and **Apple In-App Purchase** (iOS), as one-time "support CodaMi" tips (for example €2 / €5 / €10). Built with the official `in_app_purchase` Flutter package. Stripe or PayPal links inside the app are not allowed for this.
- Store fees: 15% under the small developer programmes (Google: first $1M per year; Apple: Small Business Program, must apply), otherwise 30%.
- Setup: payments profile in Play Console, Paid Apps agreement on App Store Connect, tax and bank details, products created in both stores.
- Wording would have to say "support the app", not "charity" or "donation to animals".
- It would change the Data safety form and App Store privacy labels.

- Amounts must be **set in advance** as store products (users cannot type their own amount). Offer 4–5 choices, for example €1, €3, €5, €10, €25, using Apple's price points (€0.99, €2.99, €4.99, €9.99, €24.99). Products are consumable, so the same user can give again.

**Question for the client:** go ahead with store payments? If yes, which amounts?

## 7. Support tickets and live chat

**Already there:** a **Contact us** button on the legal pages that opens an email.

**Proposed approach**
- **Tickets** in Firestore: subject, category, description, screenshots (Firebase Storage), reference number (for example `CM-1042`), status (open, waiting, closed), message thread
- Users see their tickets in Profile → Help, and get a push notification when support replies
- Support staff answer from the admin section of the app (see 2)
- **Live chat:** the same message thread in real time when an operator is online. When no one is online, the app says so and offers to create a ticket instead.

**Questions for the client:** who answers, in which languages, and during which hours?

---

## Suggested order

1. Language screen on first launch (finishes request 1)
2. Optional reward (small, self-contained)
3. Roles and role-based navigation, plus in-app report / block (store requirement, foundation for 2, 5 and 7)
4. Admin section: listings, reported content, users
5. Support tickets, then live chat
6. Videos: admin upload, then rotation in the app and support prompts
7. Notification sounds
8. Donation interface, then store payments once the client decides and sets up the payment profiles
