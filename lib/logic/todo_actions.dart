import 'package:flutter/material.dart';
import 'package:todos/logic/db_actions.dart';

import 'todo.dart';

class TodoActions {
  final BuildContext context;
  final Todo currentTodo;

  TodoActions(this.context, this.currentTodo);

  Future<void> createTodo() async {
    DbActions.createTodo(currentTodo);
  }
}
