import 'package:flutter/material.dart';
import 'package:todos/screens/home.dart';

import 'constants.dart';

String getErrorText(String errorCode) {
  try {
    return errorMessages.entries
        .firstWhere((entry) => entry.key == errorCode)
        .value;
  } catch (_) {
    return 'Unexpected exception occurred';
  }
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
