import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/auth/sign_in.dart';
import 'package:todos/logic/user_functions.dart';
import 'package:todos/screens/home.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: UserFunctions.authStateChanges,
      builder: ((context, _) {
        return context.watch<User?>() == null ? const SignIn() : const Home();
      }),
    );
  }
}
