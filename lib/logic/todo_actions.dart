import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'todo.dart';

class TodoActions {
  // TODO: delete if not used
  final BuildContext context;
  final Todo todo;

  TodoActions(this.context, this.todo);

  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static final _todos =
      _db.collection('users').doc(_auth.currentUser?.uid).collection('todos');

  createTodo() {
    _todos.doc(todo.id).set(todo.asMap);
  }

  updateTodo() {
    _todos.doc(todo.id).set(todo.asMap);
  }

  toggleIsDone({bool? value}) async {
    final toggledTodo = todo..toggleIsDone(value: value);
    await _todos.doc(todo.id).set(toggledTodo.asMap);
  }

  deleteTodo() async {
    await _todos.doc(todo.id).delete();
  }

  static Stream<QuerySnapshot<Map>> getTodos() {
    return _todos.snapshots();
  }

  static Future<Todo?> getTodoById(String id) async {
    final todoMap = (await _todos.doc(id).get()).data();
    if (todoMap is Map) return Todo.fromMap(todoMap!);
    return null;
  }

  static Future<int> getTodosCount() async {
    return (await _todos.get()).docs.length;
  }
}
