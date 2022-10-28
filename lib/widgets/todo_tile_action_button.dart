import 'package:flutter/material.dart';

class TodoTileActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;

  const TodoTileActionButton(
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
