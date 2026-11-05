# CodaMi: Personal schedule test (Thu 5 Nov)

Phase 5, request 4 (`PHASE_5_REQUESTS.md` §4).

**Before testing**
1. Deploy: `firebase deploy --only functions,firestore:rules` (new `scheduleReminderSweep` every 5 minutes, rules for `scheduleEvents` and `config/schedule`).
2. Run the new build on the phone, with notifications allowed.
3. Accounts: **admin**, and a **user** with two pets (one female, with a heat recorded in the heat calendar).

Note anything wrong in `PENDING_TASKS.md` under "Fixes found while testing".

---

## 1. Admin switch
1. Admin → More → **My schedule** (before Heat calendar): "Show to users" is off.
2. While it's off, the admin already sees **My schedule** in the Pets tab; the user doesn't.
3. Switch it on → "Saved" straight away.

## 2. Where it shows
4. User → Pets tab: **My schedule** card at the top, "Plan vet visits, medicines and more, with reminders".
5. A pet's page: **My schedule** card with "No upcoming events for …", **See all** and **New event**.
6. Profile: a **My schedule** row.

## 3. New events and default reminders
7. **New event** → type **Vet visit**: reminders "1 day before" and "1 hour before" already chosen; the Place field shows.
8. Switch the type to **Medication** → "At the time" only, a "Medicine and dose" field. **Feeding** → "At the time". **Walk or activity** → "15 minutes before". **Note** → all day, no reminder.
9. Choose a third reminder → "You can choose up to 2 reminders."
10. Save a vet visit for tomorrow at a set time, for one pet, with a place → "Saved". The Pets tab card shows "Next: Vet visit · Tomorrow · 10:30".
11. Leave the title empty → the event shows its type ("Vet visit"). With a title → the title.
12. Save a general note with no pet → it shows in the schedule, not on any pet's page.

## 4. Repeats
13. Medication, every day, ends after 7 times → 7 days in the calendar.
14. Feeding, every week, Mon–Fri → dots only on weekdays.
15. Vaccination, every year → next year on the same day (the calendar arrows).
16. Ends on a date before the start → "The end date can't be before the start date." "Every 0" → error.

## 5. Calendar, Upcoming, Done
17. **Calendar**: dots under days with events (heat estimate days with a pink dot), today circled; tap a day → its list below; arrows change month, **Today** comes back.
18. **Upcoming**: Today, Tomorrow, then dates; the pet's expected heat shows as "…: heat expected · estimate" and opens the heat calendar.
19. Tick the circle on a row → it moves to **Done**; untick it in Done → back in Upcoming.
20. Filter: pet chips at the top (with 2+ pets), the filter icon for types.
21. A medicine from yesterday not ticked → under **Not done yet**.

## 6. Event details
22. Tap an event → details: date and time, repeat ("Every day · 7 times"), pets, place, reminders, notes.
23. **Mark as done** / **Mark as not done**.
24. On a repeating event: **Skip this time** → that day disappears, the next stays.
25. **Edit** a repeating event → "Only this time": change the time → only that day moves. "All times": change the title → every day changes.
26. **Delete** → "Only this time" removes one day; "All times" removes the series. A one-off event asks "Delete this event?".

## 7. Notifications
27. Add an event 20 minutes from now with "15 minutes before" → the notification arrives about 5 minutes before (the server checks every 5 minutes, so up to 5 minutes late), with the app closed: title "event · pet", text "In 15 minutes · time · place".
28. Tap the notification → the app opens the event's details.
29. Mark an event as done before its reminder → no notification.
30. Change the app language and reopen the app → the next notifications come in the new language.
31. All-day event with "On the day, at 9:00" → arrives at 9:00.

## 8. Privacy and clean-up
32. Another user never sees these events. Admins can't see them either (only the on/off switch).
33. Delete a pet that has events → "Luna has 3 scheduled events" → **Delete them** removes the events only for that pet; events shared with another pet stay, without it. **Keep them** keeps them as general events.
34. Deleting the account removes the whole schedule.

## 9. Languages and small phones
35. Italian, German and Arabic (right to left): tabs, form and details fit and read well.
