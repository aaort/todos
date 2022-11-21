import 'package:flutter/material.dart';
import 'package:todos/logic/user_functions.dart';
import 'package:todos/app_navigator.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  onLogout() async {
    await UserActions.logout();

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AppNavigator()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: onLogout,
      icon: const Icon(
        Icons.logout_outlined,
        color: Colors.white,
      ),
    );
  }
}
