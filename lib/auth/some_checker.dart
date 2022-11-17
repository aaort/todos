import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos/auth/sign_in.dart';
import 'package:todos/screens/home.dart';

class SomeChecker extends StatelessWidget {
  const SomeChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data is User) {
          const Home();
        }
        return SignIn();
      }),
    );
  }
}
