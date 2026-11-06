import {FieldValue, getFirestore, type Transaction} from "firebase-admin/firestore";

import type {PointAction} from "./points";

export interface Award {
  uid: string;
  action: PointAction;
  key: string;
  points: number;
  note?: string;
}

const usersRef = () => getFirestore().collection("users");

// Each award has a fixed ledger ID, so the same award can never count twice.
// Firestore wants every read before the first write, so callers finish their reads first.
export async function awardInTx(tx: Transaction, awards: Award[]): Promise<Award[]> {
  const wanted = awards.filter((a) => a.points !== 0);
  const refs = wanted.map((a) => usersRef().doc(a.uid).collection("pointsLedger").doc(`${a.action}_${a.key}`));
  const snaps = await Promise.all(refs.map((ref) => tx.get(ref)));
  const given = wanted.filter((_, i) => !snaps[i].exists);
  given.forEach((award) => {
    tx.set(refs[wanted.indexOf(award)], {
      action: award.action,
      points: award.points,
      ...(award.note ? {note: award.note} : {}),
      createdAt: FieldValue.serverTimestamp(),
    });
    tx.set(usersRef().doc(award.uid), {points: FieldValue.increment(award.points)}, {merge: true});
  });
  return given;
}
