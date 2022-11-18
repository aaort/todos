import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos/logic/todo.dart';

class CloudTodoActions {
  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static createTodo(Todo todo) {
    _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('todos')
        .add(todo.asMap);
  }

  updateTodo(Todo updatedTodo) {
    _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('todos')
        .doc(updatedTodo.id);
  }

  getTodos(String userId) {}
  deleteTodo(String id) {}
}
