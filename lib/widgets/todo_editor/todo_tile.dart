import 'package:flutter/material.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/notifications/notifications.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/extensions.dart' show CustomTextStyles;
import 'package:todos/widgets/todo_editor/dismissible.dart';
import 'package:todos/widgets/modal_bottom_sheet.dart';

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

  onTap(bool? _) {
    TodoActions(todo).toggleIsDone();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    onDismiss() {
      if (todo.reminderId != null) {
        Notifications.cancelReminder(todo.reminderId!);
      }
      TodoActions(todo).deleteTodo();
    }

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
