import 'package:firebase_auth/firebase_auth.dart';

class UserActions {
  static final _auth = FirebaseAuth.instance;

  static logout() async => await _auth.signOut();
}
