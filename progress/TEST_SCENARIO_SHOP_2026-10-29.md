# CodaMi: Shop test (day 1)

Test of the shop built on Thu 29 Oct 2026 (switch, catalogue, Shop tab). Rules are deployed. Cart and checkout are not built yet, so "Add to cart" is greyed out on purpose.

**You need:** the new build on the phone, an **admin** account, and a **user** account (a second phone, or sign out and in). The user account should have a pet (for example a cat) for test 6.

Write down anything that looks wrong in `PENDING_TASKS.md` under "Fixes found while testing".

---

## 1. Shop is off at the start (user)

1. Sign in as the **user**.
2. Bottom bar shows **Home, Pets, Videos, Profile**, no Shop tab.

## 2. Categories (admin)

1. Sign in as **admin** → More → **Shop**. The switch says the shop is off.
2. **Categories** → empty screen → tap **Add the starting categories**. 8 categories appear (Pet food, Accessories, Pet care, Toys, Beds, Carriers, Pet tech, Other).
3. **Add category** "Dry food", Inside category = Pet food, Position 1. It shows indented under Pet food.
4. Add "Wet food" inside Pet food, Position 2. Dry comes before Wet.
5. Save with an empty name → red "Required".
6. Try to delete **Pet food** → refused ("Still used…") because it has sub-categories.

## 3. Brands and suppliers (admin)

1. **Brands** → **Add brand** "Test Brand", website `test.com` → red link error; change to `https://test.com`, pick a logo, save.
2. Add a second brand "Hidden Brand", switch **Visible to users** off, save. It shows a grey "Hidden" badge.
3. **Suppliers** → **Add supplier** "Test Supplier", choose **Automatic email**, leave email empty → red email error; enter `orders@test.com`, save.
4. Add "Off Supplier" (By hand), switch it off, save.

## 4. Products (admin)

Shop → **Products** → **Add product**. Make these four:

| # | Name | Category | Model | Brand / Supplier | Price | Before discount | Animals | Other |
|---|---|---|---|---|---|---|---|---|
| A | Cat dry food 2 kg | Pet food › Dry food | Our stock | Test Brand | 12,90 | 15,90 | Cat | 2–3 photos |
| B | Dog toy | Toys | Dropshipping | Test Supplier | 7.5 | – | Dog | 1 photo, availability "Only a few left" |
| C | Harness on Amazon | Accessories | Affiliate link | Test Brand | empty | – | Dog | partner "Amazon", any https Amazon link |
| D | Hidden brand bed | Beds | Brand partner | Hidden Brand | 30 | – | – | |

Switch **Visible to users** on for all four. Then check:

1. Save with no name, no category and no price → red marks, "Check the fields marked in red". Typing clears them.
2. Price `12.999` or `abc` → refused. Before-discount lower than the price → refused. With 12,90 / 15,90 the help text shows **-19%**.
3. Photos: add several, drag one to first place (hold, then drag), remove one with the X. After saving, the first photo is the cover in the list.
4. Affiliate (C): the supplier box disappears; saving without partner or with an `http://` link is refused.
5. Edit A, change the price, save → list updates.
6. Make a 5th product "Off supplier toy" with **Off Supplier**, visible on.

## 5. Preview while off (admin)

1. Shop → **Preview the shop**. Orange banner "Preview: the shop is off".
2. You see A, B, C. **Not** D (hidden brand) and **not** the Off-supplier toy.
3. Open A: photos swipe with dots, red price 12,90 with 15,90 crossed out, -19% badge, "In stock", "Cat", greyed "Add to cart" and "Buying in the app is coming soon".
4. Open C: "Price on Amazon", the commission note, **Buy on Amazon** opens the link in the browser.

## 6. Open the shop (admin, then user)

1. Admin → Shop → turn the switch **on** → confirm → "Saved". Text now says everyone sees the Shop tab.
2. On the **user** phone (app open, no restart): the **Shop** tab appears between Videos and Profile.
3. Shop tab: A, B, C only. If the user has a **cat**, A (cat food) is first.
4. Search "dog" → B and C. Search "test brand" → A and C. Search "xyz" → "No products match".
5. Animal chip **Cat** → A only (and products with no animal set). **All** → back.
6. Tap **Pet food** → A; the sub-chips Dry food / Wet food appear; **Wet food** → empty message. Tap Pet food again to clear.
7. Open B: "Only a few left" badge.

## 7. Switching things off (admin, check on user)

1. Sales models: switch **Affiliate link** off → C disappears for the user. Switch it back on.
2. Hide brand **Test Brand** → A and C disappear. Show it again.
3. Hide category **Toys** → B disappears. Show it again.
4. Switch **Test Supplier** off → B disappears. Back on.
5. Product A → Visible off → disappears. Back on.

## 8. Close the shop

1. While the user is **on the Shop tab**, admin turns the shop **off** → confirm.
2. The user's Shop tab disappears and the app goes to Home without an error. If the user was on Profile, they stay on Profile.
3. Turn it on again → the tab comes back with the products (no error screen, no restart).
4. Leave the shop **off** at the end of the test.

## 9. Delete and clean up (admin)

1. Try to delete **Test Brand** or **Test Supplier** while products use them → refused.
2. Delete product D → confirm → gone; its photos are removed from Storage (Firebase console → Storage → `shop/products/`).
3. Delete Hidden Brand → works (no products left).
4. Keep or delete the test data as you prefer; it is invisible to users while the shop is off.

## 10. Languages and layout

1. Switch the app to Italian and one right-to-left language (Arabic): Shop screens, admin screens and prices (€) read correctly, nothing overflows.
2. Small phone: the product grid shows 2 columns, long names cut with "…".

---

**Expected results:** every step behaves as written, no red error screens, nothing visible to users while the shop is off.
