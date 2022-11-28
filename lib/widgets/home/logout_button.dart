import 'package:flutter/material.dart';
import 'package:todos/logic/services/auth.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: Auth.logout,
      icon: Icon(
        Icons.logout_outlined,
        color: Colors.white,
      ),
    );
  }
}
