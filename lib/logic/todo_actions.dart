import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/notifications/notifications.dart';

import 'todo.dart';
import 'todos_io.dart';

class TodoActions {
  final BuildContext context;
  final Todo currentTodo;

  TodoActions(this.context, this.currentTodo);

  Future<void> updateTodo(Todo updatedTodo) async {
    final todo = Todo.fromMap(
      task: updatedTodo.task,
      checked: currentTodo.checked,
      id: currentTodo.id,
      reminderId: updatedTodo.reminderId,
      reminderDateTime: updatedTodo.reminderDateTime,
      repeatOption: updatedTodo.repeatOption,
    );

    context.read<TodoManager>().editTodo(todo);
    await TodosIO.editTodo(todo);
    if (todo.reminderDateTime != null) {
      Notifications.updateReminder(todo);
    }
  }

  Future<void> createTodo() async {
    context.read<TodoManager>().addTodo(currentTodo);
    await TodosIO.createTodo(currentTodo);

    if (currentTodo.reminderId != null) {
      Notifications.scheduleReminder(currentTodo);
    }
  }

  Future<void> deleteTodo() async {
    context.read<TodoManager>().deleteTodo(currentTodo.id);
    await TodosIO.deleteTodo(currentTodo.id);
    final reminderId = currentTodo.reminderId;
    if (reminderId != null) {
      await Notifications.cancelReminder(reminderId);
    }
  }

  Future<void> dropReminder() async {
    currentTodo.updateReminder(null);
    updateTodo(currentTodo);
  }

  void toggleCheck() {
    context.read<TodoManager>().toggleCheckById(currentTodo.id);
    TodosIO.toggleCheck(currentTodo.id);
    final todo = context.read<TodoManager>().getTodoById(currentTodo.id);
    if (todo.reminderId == null) return;
    if (todo.checked) {
      Notifications.cancelReminder(todo.reminderId!);
    } else {
      if (todo.reminderDateTime!.isAfter(DateTime.now())) {
        Notifications.scheduleReminder(todo);
      }
    }
  }

  void updateReminder(DateTime newReminder) {
    context.read<TodoManager>().updateReminder(currentTodo.id, newReminder);
    Notifications.scheduleReminder(currentTodo);
  }
}
