import 'package:flutter/material.dart';
import 'package:todos/logic/user_actions.dart';
import 'package:todos/navigation/app_navigator.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    onLogout() {
      UserActions.logout().then((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AppNavigator()),
          (route) => false,
        );
      });
    }

    return IconButton(
      onPressed: onLogout,
      icon: const Icon(
        Icons.logout_outlined,
        color: Colors.white,
      ),
    );
  }
}
