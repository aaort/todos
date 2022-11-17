import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos/screens/home.dart';
import 'package:todos/widgets/dismiss_keyboard.dart';

final _auth = FirebaseAuth.instance;

final Set _authExceptions = <String>{
  'wrong-password',
  'weak-password',
  'email-already-in-use',
  'user-not-found',
};

final Set _errorMessages = <String>{
  'Provided password is incorrect',
  'Provided password is too weak',
  'Provided email is already in use',
  "There is no user found with provided credentials",
};

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _errorText;

  final _formKey = GlobalKey<FormState>();

  onSignUp() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const Home(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == _authExceptions.elementAt(0)) {
        setState(() => _errorText = _errorMessages.elementAt(0));
      } else if (e.code == _authExceptions.elementAt(1)) {
        setState(() => _errorText = _errorMessages.elementAt(1));
      } else if (e.code == _authExceptions.elementAt(2)) {
        setState(() => _errorText = _errorMessages.elementAt(2));
      } else if (e.code == _authExceptions.elementAt(3)) {
        setState(() => _errorText = _errorMessages.elementAt(3));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _emailController,
                  autofocus: true,
                  validator: _emailValidator,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: _passwordValidator,
                  decoration: const InputDecoration(
                    label: Text('Password'),
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onSignUp,
                  child: const Text('Sign up'),
                ),
                if (_errorText != null) ...[
                  const SizedBox(height: 20),
                  Text(
                    _errorText!,
                    style: Theme.of(context).inputDecorationTheme.errorStyle,
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? _emailValidator(String? email) {
  if (email == null) {
    return 'Your email is empty';
  }
  if (email.isEmpty) {
    return 'Please enter your email';
  }
  if (!email.contains('@')) {
    return 'Your email should container @ sign';
  }

  return null;
}

String? _passwordValidator(String? password) {
  if (password == null) {
    return 'Your password is empty';
  }
  if (password.isEmpty) {
    return 'Please enter your password';
  }
  if (password.length < 6) {
    return 'Your password is too short';
  }

  return null;
}
