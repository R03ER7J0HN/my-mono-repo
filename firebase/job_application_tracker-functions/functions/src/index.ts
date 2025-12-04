import * as functions from "firebase-functions/v1";
import * as admin from "firebase-admin";
import {FieldValue} from "firebase-admin/firestore";

admin.initializeApp();
const db = admin.firestore();

export const onUserCreate = functions.auth.user().onCreate(async (user) => {
  const userDocRef = db.collection("users").doc(user.uid);
  const userDoc = await userDocRef.get();

  const userData = {
    email: user.email,
    createdAt: FieldValue.serverTimestamp(),
    lastLogin: FieldValue.serverTimestamp(),
  };

  if (userDoc.exists) {
    await userDocRef.set(userData, {merge: true});
  } else {
    await userDocRef.set(userData);
  }
});

export const onUserDelete = functions.auth.user().onDelete(async (user) => {
  const userDocRef = db.collection("users").doc(user.uid);
  await userDocRef.delete();
});
