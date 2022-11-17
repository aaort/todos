import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todos/auth/custom_form.dart';
import 'package:todos/auth/sign_in.dart';
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
  final _formKey = GlobalKey<FormState>();

  String? _errorText;

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

  onSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomForm(
                emailController: _emailController,
                passwordController: _passwordController,
                onSave: onSignUp,
                formKey: _formKey,
                errorText: _errorText,
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Already have an account ? ',
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                    TextSpan(
                        text: 'Sign in',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = onSignIn)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}