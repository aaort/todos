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

  void editTodo(String id, String updatedTask) {
    // TODO: Maybe this could take a new todo as a one argument
    _todos.firstWhere((todo) => todo.id == id).task = updatedTask;
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
