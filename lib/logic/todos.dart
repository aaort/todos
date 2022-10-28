import 'dart:collection' show UnmodifiableListView;

import 'package:flutter/foundation.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todos_io.dart';

class Todos extends ChangeNotifier {
  Todos() {
    initiateTodos();
  }

  final _todos = <Todo>[];

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  Todo getTodoById(String id) {
    return _todos.firstWhere((todo) => todo.id == id);
  }

  Future<void> initiateTodos() async {
    final todos = await TodosIO.getTodos();
    _todos.addAll(todos);
    notifyListeners();
  }

  void toggleCheck(String id) {
    _todos.firstWhere((todo) => todo.id == id).toggleCheck();
    notifyListeners();
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void editTodo(Todo updatedTodo) {
    _todos[_todos.indexWhere((todo) => todo.id == updatedTodo.id)].task =
        updatedTodo.task;
    _todos[_todos.indexWhere((todo) => todo.id == updatedTodo.id)]
        .reminderDateTime = updatedTodo.reminderDateTime;
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
