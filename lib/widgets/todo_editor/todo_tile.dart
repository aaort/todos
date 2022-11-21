import 'package:flutter/material.dart';
import 'package:todos/extensions.dart' show CustomTextStyles;
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todo_functions.dart';
import 'package:todos/notifications/notifications.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/widgets/common/modal_bottom_sheet.dart';
import 'package:todos/widgets/todo_editor/dismissible.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  TodoTile({super.key, required this.todo});

  // Only for accessing context inside methods
  final _key = GlobalKey();

  void onLongPress() async {
    popupModalBottomSheet(
      context: _key.currentContext!,
      child: TodoEditor(initialTodo: todo),
    );
  }

  onDismiss() {
    if (todo.reminderId != null) {
      Notifications.cancelReminder(todo.reminderId!);
    }
    DBActions(todo).deleteTodo();
  }

  onTap(bool? value) {
    if (todo.reminderId != null) {
      Notifications.cancelReminder(todo.reminderId!);
    }
    DBActions(todo).toggleIsDone(value);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DismissibleTile(
      onDismiss: onDismiss,
      onLongPress: onLongPress,
      child: CheckboxListTile(
        key: _key,
        title: Text(
          todo.task,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: todo.isDone ? textTheme.lineThrough : textTheme.bodySmall,
        ),
        value: todo.isDone,
        onChanged: onTap,
      ),
    );
  }
}
