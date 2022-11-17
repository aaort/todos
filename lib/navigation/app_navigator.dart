import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/auth/sign_up.dart';
import 'package:todos/screens/home.dart';
import 'package:todos/theme/theme_manager.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

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
        context.read<ThemeManager>().toggleTheme(mode: ThemeMode.light);
        return const SignUp();
      }),
    );
  }
}
