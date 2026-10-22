import {getFirestore} from "firebase-admin/firestore";
import * as logger from "firebase-functions/logger";

import {DEFAULT_CHANNEL, chunk, languageOf, pushSettingsOf, type AlertType} from "./notifications";
import {sendToTokens, tokensOf} from "./push";

export interface LocalizedPush {
  title: (lang: string) => string;
  body: (lang: string) => string;
}

// With a type, the user's switch and sound for it apply; without one it's a plain account notice.
export async function pushToUsers(
  uids: string[],
  content: LocalizedPush,
  data: Record<string, string>,
  type: AlertType | null,
  options: {color?: string; imageUrl?: string | null} = {},
): Promise<number> {
  const db = getFirestore();
  let sent = 0;
  try {
    for (const group of chunk([...new Set(uids)], 100)) {
      const users = await db.getAll(...group.map((uid) => db.collection("users").doc(uid)));
      for (const user of users) {
        const tokens = tokensOf(user);
        const settings = type ?
          pushSettingsOf(user.get("notificationPrefs"), type) :
          {enabled: true, channelId: DEFAULT_CHANNEL, iosSound: "default"};
        if (!user.exists || !settings.enabled || tokens.length === 0) continue;
        const lang = languageOf(user.get("language"));
        const result = await sendToTokens(tokens, {
          notification: {title: content.title(lang), body: content.body(lang)},
          data,
          android: {
            priority: "high",
            notification: {
              channelId: settings.channelId,
              ...(options.color ? {color: options.color} : {}),
              ...(options.imageUrl ? {imageUrl: options.imageUrl} : {}),
            },
          },
          apns: {payload: {aps: settings.iosSound ? {sound: settings.iosSound} : {}}},
        });
        sent += result.success;
      }
    }
  } catch (error) {
    logger.error("Push failed", {kind: data.kind, error});
  }
  return sent;
}
