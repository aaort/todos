import 'package:flutter/material.dart';

class AddTodoButton extends StatefulWidget {
  final VoidCallback onPressed;

  const AddTodoButton({super.key, required this.onPressed});

  @override
  State<AddTodoButton> createState() => _AddTodoButtonState();
}

class _AddTodoButtonState extends State<AddTodoButton>
    with TickerProviderStateMixin {
  late final _animController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final _animation =
      CurvedAnimation(parent: _animController, curve: Curves.bounceIn);

  @override
  void initState() {
    _animController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: FloatingActionButton(
        onPressed: widget.onPressed,
        child: const Icon(Icons.edit_outlined),
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
}
