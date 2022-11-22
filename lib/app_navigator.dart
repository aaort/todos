import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos/auth/sign_in.dart';
import 'package:todos/screens/home.dart';
import 'package:todos/widgets/common/loading_indicator.dart';
import 'package:todos/logic/user_functions.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UserFunctions.authStateChanges,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        } else if (snapshot.data is User) {
          return const Home();
        }
        return const SignIn();
      }),
    );
  }
}
