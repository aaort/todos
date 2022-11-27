import 'package:flutter/material.dart';
import 'package:todos/logic/user_functions.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: UserFunctions.logout,
      icon: Icon(
        Icons.logout_outlined,
        color: Colors.white,
      ),
    );
  }
}
