import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos/logic/services/database.dart';

class Auth {
  static final _auth = FirebaseAuth.instance;

  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  static User? get currentUser => _auth.currentUser;

  static bool? get isAnonymous => currentUser?.isAnonymous;

  static Future<void> logout() async {
    await Future.wait([Database.terminateSession(), _auth.signOut()]);
  }

  static Future<UserCredential> signInAnonymously() async {
    return await _auth.signInAnonymously();
  }

  static Future<UserCredential?> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<User?> createUser(String email, String password) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credentials.user;
  }
}
