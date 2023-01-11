import 'package:flutter/material.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/services/database.dart';
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
      shouldConfirmPop: true,
      child: TodoEditor(initialTodo: todo),
    );
  }

  onDismiss() {
    if (todo.reminderId != null) {
      Notifications.cancelReminder(todo.reminderId!);
    }
    Database(todo).deleteTodo();
  }

  onTap(bool? value) {
    if (todo.reminderId != null) {
      Notifications.cancelReminder(todo.reminderId!);
    }
    Database(todo).toggleIsDone(value);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DismissibleTile(
      onDismiss: onDismiss,
      onLongPress: !todo.isDone ? onLongPress : () {},
      child: CheckboxListTile(
        key: _key,
        title: Text(
          todo.task,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: todo.isDone
              ? textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).disabledColor,
                  decoration: TextDecoration.lineThrough,
                )
              : textTheme.bodySmall,
        ),
        value: todo.isDone,
        onChanged: onTap,
      ),
    );
  }
}
