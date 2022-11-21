import 'package:flutter/material.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/widgets/common/modal_bottom_sheet.dart';

class AddTodoButton extends StatefulWidget {
  const AddTodoButton({super.key});

  @override
  State<AddTodoButton> createState() => _AddTodoButtonState();
}

class _AddTodoButtonState extends State<AddTodoButton>
    with TickerProviderStateMixin {
  late final _animController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final _animation =
      CurvedAnimation(parent: _animController, curve: Curves.linear);

  showAddTodoModal() {
    popupModalBottomSheet(
      context: context,
      child: const TodoEditor(),
    );
  }

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
        onPressed: showAddTodoModal,
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
