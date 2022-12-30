import 'package:flutter/material.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/widgets/common/modal_bottom_sheet.dart';

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({super.key});

  showAddTodoModal(BuildContext context) {
    popupModalBottomSheet(
      context: context,
      child: const TodoEditor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showAddTodoModal(context),
      child: const Icon(Icons.edit_outlined),
    );
  }
}
