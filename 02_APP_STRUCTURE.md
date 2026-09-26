# 02 — MVP structure / Navigation

## Screen tree

### Auth stack
1. **Login**
2. **Register**
3. **Forgot password**

### Main tabs (after login + city setup)
1. **Home**
2. **Pets**
3. **Profile**

### Stack / modals
- City setup (first time)
- Create / edit pet
- Create report
- Report detail
- Notifications (bell)
- My pets (if not only the tab)
- My reports

---

## Home

Must clearly include:

| Block | Content |
|--------|-----------|
| Header | Title + notifications bell |
| Local segment / tabs | **Map** · **Lost** · **Found** |
| Filters | City · Radius · All |
| Map | Lost/found pins |
| Lost list | Photo card + name + city + date |
| Found list | Same |
| Primary CTA | Button / FAB **New report** |

---

## Profile

| Item | Detail |
|------|-----------|
| User data | Name, email, preferred city, notification radius |
| My pets | Link / pets list |
| My reports | User’s lost + found posts |
| Notify preferences | City / radius toggles |
| Sign out | Logout |

---

## Pet — Create pet profile

Required / optional fields as in the main spec:

- Photo (required)
- Name
- Species (Dog / Cat / Other)
- Breed
- Color
- Sex
- Age
- Distinctive features

Actions: Save · (later) Edit · Delete (owner only)

---

## Report — Create

1. Type: **Lost** / **Found**
2. If Lost → select existing pet (or create pet inline)
3. Photo
4. Location (city autocomplete) + optional place detail
5. Date/time
6. Description
7. Contacts
8. Publish

---

## Report detail

- Hero photo
- Lost/Found badge + status
- Pet info
- Place + date
- Description
- Contact (Phone / WhatsApp / Email)
- If owner: Mark as resolved
- (Optional) Comments / sightings
