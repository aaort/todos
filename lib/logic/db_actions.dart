import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos/logic/todo.dart';

class DbActions {
  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static final _todos =
      _db.collection('users').doc(_auth.currentUser?.uid).collection('todos');

  static createTodo(Todo todo) {
    _todos.doc(todo.id).set(todo.asMap);
  }

  static updateTodo(Todo updatedTodo) {
    _todos.doc(updatedTodo.id).set(updatedTodo.asMap);
  }

  static Stream<QuerySnapshot<Map>> getTodos() {
    return _todos.snapshots();
  }

  static Future<int> getTodosCount() async {
    return (await _todos.get()).docs.length;
  }

  static deleteTodo(String id) async {
    await _todos.doc(id).delete();
  }
}
