import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos/logic/todo.dart';

class DbActions {
  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static createTodo(Todo todo) {
    _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('todos')
        .doc(todo.id)
        .set(todo.asMap);
  }

  updateTodo(Todo updatedTodo) {
    _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('todos')
        .doc(updatedTodo.id);
  }

  static Future<QuerySnapshot<Map>> getTodos() async {
    return _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('todos')
        .get();
  }

  static Future<int> getTodosCount() async {
    return (await _db
            .collection('users')
            .doc(_auth.currentUser?.uid)
            .collection('todos')
            .get())
        .docs
        .length;
  }

  deleteTodo(String id) {}
}