import 'package:flutter/material.dart';
import 'package:todos/logic/cloud_todo_actions.dart';

import 'todo.dart';

class TodoActions {
  final BuildContext context;
  final Todo currentTodo;

  TodoActions(this.context, this.currentTodo);

  Future<void> createTodo() async {
    CloudTodoActions.createTodo(currentTodo);
  }
}
