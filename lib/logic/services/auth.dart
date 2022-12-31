import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos/logic/services/database.dart';

class Auth {
  static final _auth = FirebaseAuth.instance;

  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  static Future<void> logout() async {
    Database.terminateSession();
    await _auth.signOut();
  }

  static Future<UserCredential?> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential?> createUser(
      String email, String password) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Called to trigger new event on authStateChanges stream
    login(email, password);

    if (credentials.user == null) return null;

    final user = {
      'email': credentials.user!.email,
      'id': credentials.user!.uid,
    };

    await Database.createUser(user);

    return credentials;
  }
}
