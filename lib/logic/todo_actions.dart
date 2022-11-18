import 'package:flutter/material.dart';
import 'package:todos/logic/db_actions.dart';

import 'todo.dart';

class TodoActions {
  final BuildContext context;
  final Todo currentTodo;

  TodoActions(this.context, this.currentTodo);

  Future<void> createTodo() async {
    await DbActions.createTodo(currentTodo);
  }

  Future<void> updateTodo() async {
    await DbActions.updateTodo(currentTodo);
  }

  Future<void> deleteTodo() async {
    await DbActions.deleteTodo(currentTodo.id);
  }

  Future<void> toggleIsDone() async {
    await DbActions.updateTodo(currentTodo..toggleIsDone());
  }
}
