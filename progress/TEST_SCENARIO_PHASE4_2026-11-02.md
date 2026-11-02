# CodaMi: Phase 4 test (Mon 2 Nov)

QR invites, Places to walk and the donation screens.

**Before testing**
1. Deploy: `firebase deploy --only hosting,functions,firestore:rules`
2. Run the new build on the phone (new packages and permissions: a full build, not a hot restart).
3. You need an **admin** account and a **user** account. For the QR page, a second phone or a computer helps.

Note anything wrong in `PENDING_TASKS.md` under "Fixes found while testing".

---

## 1. QR code (user)

1. Profile → **Invite friends**. Under Copy / Share there is a small QR with "Your QR code". Tap it.
2. **QR code and flyer** opens on **QR code**: white card, QR, your code under it.
3. **Save to photos**: the first time the phone may ask for permission (iPhone: "add photos"). "Saved to your photos" appears; open the gallery and check the image is sharp.
4. Switch to **Flyer**: green header with logo, "Help lost pets get back home", short text, big QR, "Scan with your phone camera", "Invite code: XXXXXX", "Free app". Save it and check it in the gallery.
5. **Share** on each: the share sheet shows the image and the invite text with the new link `https://codami-cd91e.web.app/i/XXXXXX`.
6. Deny the photo permission (phone settings) and save again → "Couldn't save. Allow CodaMi to add photos…".
7. Change the app language (for example to Italian) → flyer texts change.

## 2. The invite page

1. Scan the QR with **another Android phone's camera** (or open the link in its browser): the CodaMi page shows for a moment with the code, then **Google Play** opens on CodaMi.
2. On a **computer**: the page shows the code, "Get it on Google Play" and "Coming soon on the App Store" (greyed out until the App Store ID is set in Admin → More → App updates).
3. Open `https://codami-cd91e.web.app/i/hello`: no code box, only the store buttons.
4. On a phone set to Italian, the page is in Italian.
5. Full invite: on phone B uninstall CodaMi, scan phone A's QR, install from the Play Store (closed testing), sign up → "Did a friend invite you?" shows A's code. (Needs the Play Store build, like before.)
6. In the code box, paste the new link → the code is recognised.

## 3. Places to walk: admin

1. Admin → More → **Places to walk**. It is **off**. Settings: distance 5 km, all four types on, searches 40, details 60, no hidden places.
2. Tap **Open Places to walk** (works for admins while it's off). Allow location.
3. Turn it **on** and **Save** → "Saved".

## 4. Places to walk: user

1. As a user: **Home map** has a new park button under the full-screen button; **Profile** has "Places to walk". Both disappear when the admin turns it off.
2. Open it, allow location: "Looking for places…", then pins on the map (orange dog parks, green parks, yellow gardens, pink trails) and the 5 km circle. The line above says "N places near you".
3. Type chips: **Dog parks** shows only orange pins; **All** shows everything.
4. Distance chips: **1 km** zooms in and shows fewer places; **25 km** zooms out and searches again.
5. Move the map far away → **Search this area** appears; tap it → new places around that point.
6. List icon (top right) → list sorted by distance with type and distance, and "Places data from Google" at the bottom.
7. Tap a place: sheet with photo (and "Photo: name (Google)"), type and distance, name, address, rating, open now / closed, dogs allowed (when Google knows), opening hours, **Directions** (opens Google Maps on foot), Call and Website when available.
8. Deny location (phone settings) and open again → it uses your city ("N places near Milano") with "Use my location".

## 5. Hide a place (admin)

1. As admin, open a place → **Hide this place (admin)** → "Hidden for everyone"; it disappears from the map and list.
2. Admin → Places to walk → **Hidden places** lists it → **Show again** → it comes back.

## 6. Daily limit

1. Admin → Places to walk → Searches **1** → Save.
2. As a user, search a new area twice (move the map far, Search this area) → "You've reached today's search limit…".
3. Put it back to 40.

## 7. Donations: admin

1. Admin → More → **Support CodaMi**: an orange note says store payments aren't connected. It's **off**.
2. **Preview the page**: red header "CodaMi is free, and stays free", the seven uses, amount chips €1 / €3 / €5 / €10 / €25 (€5 selected), "Support with €5" → "Thank you!" with "Payments in the app are coming soon…". Fine print at the bottom.
3. Amounts: type `abc` → Save → red. Type `2, 5, 10` → Save → the page shows €2 / €5 / €10.
4. Turn it **on**, keep all three places on, days **30**, Save.

## 8. Donations: user

1. Profile shows **Support CodaMi** → opens the page.
2. Publish a lost or found report: after the success message and the map, a sheet "Your report is live" with **Support CodaMi** and **Not now**. Publishing is never delayed.
3. Publish another report the same day → no sheet (once every 30 days per phone).
4. To test "found": Admin → Support CodaMi → days **1**, Save; next day (or reinstall the app) mark a lost report as found → "Wonderful news!" sheet.
5. Admin turns **After a report** off → no sheet after publishing.
6. Admin turns donations **off** → the Profile row and all sheets disappear.

## 9. Languages and layout

1. Italian and Arabic: Places to walk, the place sheet, the Support page and the flyer read correctly and nothing overflows.
2. Small phone: the chips scroll sideways, the place sheet scrolls.

---

**Expected:** every step as written, no red error screens. If Places to walk shows "Couldn't load places", check the function logs (`firebase functions:log --only findWalkPlaces`) for a Places API error (for example a place type Google doesn't accept, or the API not enabled for the key).
