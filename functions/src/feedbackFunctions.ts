import "./options";

import {FieldValue, getFirestore} from "firebase-admin/firestore";
import {HttpsError, onCall} from "firebase-functions/https";
import * as logger from "firebase-functions/logger";

import {feedbackUpdateOf, thanksKindOf, thanksText} from "./feedback";
import {requireStaff} from "./supportFunctions";
import {refreshTitles} from "./titlesFunctions";
import {pushToUsers} from "./userPush";

// The team changes the status or note; marking it done can thank the user once.
export const updateFeedback = onCall(async (request) => {
  const staff = await requireStaff(request);
  const update = feedbackUpdateOf(request.data);
  if (!update) throw new HttpsError("invalid-argument", "Nothing to change.");
  const ref = getFirestore().collection("feedback").doc(update.id);
  const doc = await ref.get();
  if (!doc.exists) throw new HttpsError("not-found", "This feedback no longer exists.");

  const thank = update.notify && update.status === "done" && !doc.get("thankedAt") &&
    typeof doc.get("uid") === "string";
  await ref.update({
    ...(update.status ? {status: update.status} : {}),
    ...(update.note !== null ? {note: update.note} : {}),
    handledBy: staff.uid,
    updatedAt: FieldValue.serverTimestamp(),
    ...(thank ? {thankedAt: FieldValue.serverTimestamp()} : {}),
  });

  let notified = false;
  if (thank) {
    const kind = thanksKindOf(doc.get("type"));
    notified = await pushToUsers([doc.get("uid")], {
      title: (lang) => thanksText(lang, kind).title,
      body: (lang) => thanksText(lang, kind).body,
    }, {kind: "feedback_thanks"}, null) > 0;
  }
  if (update.status && typeof doc.get("uid") === "string") await refreshTitles(doc.get("uid"));
  logger.info("Feedback updated", {id: update.id, status: update.status, by: staff.uid, notified});
  return {notified};
});
