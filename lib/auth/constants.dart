import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos/screens/home.dart';

final auth = FirebaseAuth.instance;

final Set authExceptions = <String>{
  'wrong-password',
  'weak-password',
  'email-already-in-use',
  'user-not-found',
};

final Map errorMessages = <String, String>{
  authExceptions.elementAt(0): 'Provided password is incorrect',
  authExceptions.elementAt(1): 'Provided password is too weak',
  authExceptions.elementAt(2): 'Provided email is already in use',
  authExceptions.elementAt(3):
      "There is no user found with provided credentials",
};

String getErrorText(String errorCode) {
  return errorMessages.entries
      .firstWhere((entry) => entry.key == errorCode)
      .value;
}

String? emailValidator(String? email) {
  if (email == null) {
    return 'Your email is empty';
  }
  if (email.isEmpty) {
    return 'Please enter your email';
  }
  if (!email.contains('@')) {
    return 'Your email should container @ sign';
  }

  return null;
}

String? passwordValidator(String? password) {
  if (password == null) {
    return 'Your password is empty';
  }
  if (password.isEmpty) {
    return 'Please enter your password';
  }
  if (password.length < 6) {
    return 'Your password is too short';
  }

  return null;
}

navigateToHome(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const Home(),
    ),
  );
}
