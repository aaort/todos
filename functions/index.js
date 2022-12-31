/* eslint-disable object-curly-spacing */
/* eslint-disable indent */
const functions = require("firebase-functions");

// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");
admin.initializeApp();

// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /messages/:documentId/original
exports.addUser = functions.auth.user().onCreate((user) => {
  const data = {
    id: user.uid,
    email: user.email,
  };
  admin.firestore().collection("users").doc(user.uid).set(data);
});
