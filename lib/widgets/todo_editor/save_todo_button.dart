import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/services/database.dart';
import 'package:todos/notifications/notifications.dart';
import 'package:todos/screens/todo_editor.dart';

class SaveTodoButton extends ConsumerWidget {
  final Todo? initialTodo;

  const SaveTodoButton({super.key, this.initialTodo});

  Future<void> onTodoSaved(WidgetRef ref) async {
    final todo = ref.read(todoProvider(initialTodo));
    if (todo.task.isEmpty) return;

    if (initialTodo != null) {
      if (initialTodo!.reminder?.id != null) {
        Notifications.cancelReminder(initialTodo!.reminder!.id);
      }
      Database(todo).updateTodo();
      if (todo.reminder?.id != null) {
        Notifications.scheduleReminder(todo);
      }
    } else {
      Database(todo).createTodo();
      if (todo.reminder?.id != null) Notifications.scheduleReminder(todo);
    }

    Navigator.pop(ref.context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      key: const Key('createTodoButtonId'),
      onPressed: () => onTodoSaved(ref),
      child: const Text('Save'),
    );
  }
}
