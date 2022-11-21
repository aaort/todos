import 'package:flutter/material.dart';
import 'package:todos/auth/sign_in.dart';
import 'package:todos/auth/sign_up.dart';
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
  if (email == null || email.isEmpty) {
    return 'Please enter your email';
  }
  if (!email.contains('@')) {
    return 'Your email should container @ sign';
  }

  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Please enter your password';
  }
  if (password.length < 6) {
    return 'Your password is too short';
  }

  return null;
}

navigateToHome(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const Home(),
    ),
  );
}

navigateToSignIn(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const SignIn(),
    ),
  );
}

navigateToSignUp(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const SignUp(),
    ),
  );
}
