import {FieldValue, type DocumentSnapshot} from "firebase-admin/firestore";
import {getMessaging, type MulticastMessage} from "firebase-admin/messaging";

import {chunk} from "./notifications";

const INVALID_TOKEN_CODES = new Set([
  "messaging/registration-token-not-registered",
  "messaging/invalid-registration-token",
  "messaging/invalid-argument",
]);

export interface PushToken {
  user: DocumentSnapshot;
  token: string;
}

export function tokensOf(user: DocumentSnapshot): PushToken[] {
  const list = user.get("fcmTokens");
  if (!Array.isArray(list)) return [];
  return list.flatMap((token) => typeof token === "string" ? [{user, token}] : []);
}

export interface PushResult {
  success: number;
  failed: number;
  removedTokens: number;
}

// Sends one message to many phones and removes tokens that no longer work.
export async function sendToTokens(
  tokens: PushToken[],
  message: Omit<MulticastMessage, "tokens">,
): Promise<PushResult> {
  const result: PushResult = {success: 0, failed: 0, removedTokens: 0};
  for (const group of chunk(tokens, 500)) {
    const response = await getMessaging().sendEachForMulticast({
      ...message,
      tokens: group.map((t) => t.token),
    });
    const stale = response.responses.flatMap((r, i) =>
      !r.success && INVALID_TOKEN_CODES.has(r.error?.code ?? "") ? [group[i]] : [],
    );
    await Promise.all(
      stale.map(({user, token}) =>
        user.ref.update({fcmTokens: FieldValue.arrayRemove(token)}),
      ),
    );
    result.success += response.successCount;
    result.failed += response.failureCount;
    result.removedTokens += stale.length;
  }
  return result;
}
