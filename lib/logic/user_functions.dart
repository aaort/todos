import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserFunctions {
  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  static Future<void> logout() async {
    await _auth.signOut();
  }

  static login({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static createUser({required String email, required String password}) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credentials.user == null) return;

    final user = {
      'email': credentials.user!.email,
      'id': credentials.user!.uid,
    };

    await _db.collection('users').doc(user['id']).set(user);
  }
}
