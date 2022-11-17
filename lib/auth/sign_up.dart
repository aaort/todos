import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos/auth/utils.dart';
import 'package:todos/widgets/dismiss_keyboard.dart';

final _auth = FirebaseAuth.instance;

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
      if (mounted) navigateToHome(context);
    } on FirebaseAuthException catch (e) {
      setState(() => _errorText = getErrorText(e.code));
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
                  validator: emailValidator,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: passwordValidator,
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
