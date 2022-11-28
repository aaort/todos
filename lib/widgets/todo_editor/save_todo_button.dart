import 'package:flutter/material.dart';
import 'package:todos/logic/models/todo.dart';
import 'package:todos/logic/services/database.dart';
import 'package:todos/notifications/notifications.dart';
import 'package:todos/widgets/todo_editor/repeat_button.dart';
import 'package:todos/extensions.dart' show Reminder;

class SaveTodoButton extends StatelessWidget {
  final Todo? initialTodo;
  final String task;
  final dynamic reminder;
  final Repeat? repeat;

  const SaveTodoButton({
    super.key,
    this.initialTodo,
    this.repeat,
    required this.task,
    required this.reminder,
  });

  Future<void> onTodoSaved(BuildContext context) async {
    if (task.isEmpty) return;
    DateTime? reminder = this.reminder is Duration
        ? (this.reminder as Duration).toDateTime()
        : this.reminder;

    if (initialTodo != null) {
      final todo = initialTodo!.copyWith(
        {'task': task, 'reminder': reminder, 'repeat': repeat},
      );
      if (initialTodo!.reminderId != null) {
        Notifications.cancelReminder(initialTodo!.reminderId!);
      }
      Database(todo).updateTodo();
      if (todo.reminderId != null) {
        Notifications.scheduleReminder(todo);
      }
    } else {
      final todo = Todo(task, reminder: reminder, repeat: repeat);
      Database(todo).createTodo();
      if (todo.reminderId != null) Notifications.scheduleReminder(todo);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('createTodoButtonId'),
      onPressed: () => onTodoSaved(context),
      child: const Text('Save'),
    );
  }
}
