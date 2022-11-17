import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos/navigation/app_navigator.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    onLogout() async {
      FirebaseAuth.instance.signOut().then((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AppNavigator()),
          (route) => false,
        );
      });
    }

    return IconButton(
        onPressed: onLogout, icon: const Icon(Icons.logout_outlined));
  }
}
