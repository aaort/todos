import 'package:flutter/material.dart';
import 'package:todos/helpers/reminder.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/notifications/notifications.dart';
import 'package:todos/widgets/todo_editor/repeat_button.dart';

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
        ? getDateTimeOfDuration(this.reminder)
        : this.reminder;

    if (initialTodo != null) {
      final todo = initialTodo!.updateValues(
        {'task': task, 'reminder': reminder, 'repeat': repeat},
      );
      TodoActions(todo).updateTodo();
      if (todo.reminderId != null) {
        Notifications.cancelReminder(todo.reminderId!);
      }
    } else {
      final todo = Todo(task, reminder: reminder, repeat: repeat);
      TodoActions(todo).createTodo();
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
