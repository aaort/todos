import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos/logic/models/todo.dart';
import 'package:todos/logic/services/auth.dart';

class Database {
  final Todo todo;

  Database(this.todo);

  static final _db = FirebaseFirestore.instance;
  static User? get currentUser => Auth.currentUser;

  static CollectionReference<Map<String, dynamic>> get _todosRef =>
      _db.collection('users').doc(currentUser?.uid).collection('todos');

  createTodo() {
    _todosRef.doc(todo.id).set(todo.asMap);
  }

  updateTodo() {
    _todosRef.doc(todo.id).set(todo.asMap);
  }

  toggleIsDone([bool? value]) async {
    final toggledTodo = todo..toggleIsDone(value);
    await _todosRef.doc(todo.id).set(toggledTodo.asMap);
  }

  deleteTodo() async {
    await _todosRef.doc(todo.id).delete();
  }

  static Future<void> createUser(Map<String, dynamic> user) async {
    _db.collection('users').doc(user['id']).set(user);
  }

  static Stream<List<Todo>> get todos async* {
    final todosQuery = _todosRef.orderBy('createdAt');
    await for (QuerySnapshot snap in todosQuery.snapshots()) {
      yield [...snap.docs.map((doc) => Todo.fromMap(doc.data() as Map))];
    }
  }

  static Future<List<Todo>> getTodosOnce() async {
    final todos = await _todosRef.get();
    return todos.docs.map((doc) => Todo.fromMap(doc.data())).toList();
  }

  static Future<Todo?> getTodoById(String id) async {
    final todoMap = (await _todosRef.doc(id).get()).data();
    if (todoMap is Map) return Todo.fromMap(todoMap!);
    return null;
  }

  static Stream<int> get todosCount async* {
    await for (var snapshot in _todosRef.snapshots()) {
      yield snapshot.docs.length;
    }
  }

  static Future<void> terminateSession() async {
    await Future.wait([_db.terminate(), _db.clearPersistence()]);
  }
}
