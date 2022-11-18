import 'package:flutter/material.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/theme/theme.dart' show CustomTextStyles;
import 'package:todos/widgets/dismissible.dart';
import 'package:todos/widgets/modal_bottom_sheet.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  const TodoTile({super.key, required this.todo});

  void onLongPress(BuildContext context) async {
    popupModalBottomSheet(
      context: context,
      child: TodoEditor(initialTodo: todo),
    );
  }

  // onTap(BuildContext context) {
  //   TodoActions(context, todo).toggleCheck();
  // }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DismissibleTile(
      onDismiss: () {},
      onLongPress: () => onLongPress(context),
      child: CheckboxListTile(
        title: Text(
          todo.task,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: todo.isDone ? textTheme.lineThrough : textTheme.bodySmall,
        ),
        value: false,
        onChanged: (_) => {},
      ),
    );
  }
}
