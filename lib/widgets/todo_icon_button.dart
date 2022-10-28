import 'package:flutter/material.dart';

class TodoIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;

  const TodoIconButton(
      {super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
    );
  }
}
