import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/notifications.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/widgets/pickers.dart';

import 'todo.dart';
import 'todos_io.dart';

class TodoActions {
  final BuildContext context;
  final Todo currentTodo;

  TodoActions(this.context, this.currentTodo);

  Future<void> onEditTodo(Todo todo) async {
    context.read<Todos>().editTodo(todo);
    await TodosIO.editTodo(todo);
  }

  Future<void> onDeleteTodo(Todo todo) async {
    context.read<Todos>().deleteTodo(todo.id);
    await TodosIO.deleteTodo(todo.id);
    final reminderId = todo.reminderId;
    if (reminderId != null) {
      await Notifications.removeTodoReminder(reminderId);
    }
  }

  void onReminderDateTimeUpdate(DateTime newDateTime) {
    context
        .read<Todos>()
        .getTodoById(currentTodo.id)
        .updateReminder(newDateTime);
    Notifications.updateTodoReminder(currentTodo);
  }

  void onReminderPressed() {
    showDateTimePicker(
      context: context,
      onChange: onReminderDateTimeUpdate,
      initialDateTime: currentTodo.reminderDateTime,
    );
  }
}
