# 06 — Accounts & access (ownership)

## Rule

Primary accounts belong to the **client (product owner)**.  
The developer (Noman) receives **collaborator** access, not ownership.

## Matrix

| Service | Owner | Developer access |
|----------|-------|-------------------|
| GitHub repository | Client | Collaborator (Write) |
| Firebase / GCP | Client | Editor on the project |
| Expo account (EAS) | Client (preferred) or client Expo org | Member |
| Google Maps / Places API (if used) | Client | Use key via env, do not export |
| Google Play Console | Client | Not required in trial (direct APK) |
| Apple Developer | Client | Only if signing an iOS build |
| Email domains / brand | Client | — |

## Recommended setup (client, day 0)

1. Create private GitHub repo `codami-mvp`
2. Upload this package
3. Invite the developer
4. Create Firebase project `codami-dev`
5. Enable Email Auth, Firestore, Storage
6. Create Expo account and link EAS to the repo
7. Share via official invites only:
   - GitHub invite
   - Firebase invite
   - Expo invite
   - **Do not** share personal account passwords in chat

## Do NOT

- Create the repo under the developer’s account
- Leave API billing only on the developer
- Commit service-account JSON to the repository
- Share a raw `.env` over WhatsApp (use EAS secrets / 1Password / a secure shared doc)

## Revocation

At the end of the collaboration: remove GitHub / Firebase / Expo collaborator access in a few clicks.
