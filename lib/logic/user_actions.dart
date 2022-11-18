import 'package:firebase_auth/firebase_auth.dart';

class UserActions {
  static final _auth = FirebaseAuth.instance;

  static logout() async => await _auth.signOut();

  static login({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static createUser({required String email, required String password}) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
