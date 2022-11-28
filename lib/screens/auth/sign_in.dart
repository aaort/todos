import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todos/widgets/auth/auth_form.dart';
import 'package:todos/screens/auth/sign_up.dart';
import 'package:todos/logic/services/auth.dart';
import 'package:todos/widgets/common/dismiss_keyboard.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  String? _errorText;

  _onSignIn() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _loading = true);
    try {
      await Auth.login(
        _emailController.text,
        _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _errorText = getErrorText(e.code));
    }
    setState(() => _loading = false);
  }

  _onSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthForm(
                emailController: _emailController,
                passwordController: _passwordController,
                onSave: _onSignIn,
                formKey: _formKey,
                buttonTitle: 'Sign in',
                errorText: _errorText,
                loading: _loading,
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account ? ',
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text: 'Sign up',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()..onTap = _onSignUp,
                    )
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
