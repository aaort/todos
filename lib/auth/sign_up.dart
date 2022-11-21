import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todos/auth/auth_form.dart';
import 'package:todos/auth/utils.dart';
import 'package:todos/logic/user_functions.dart';
import 'package:todos/widgets/dismiss_keyboard.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  String? _errorText;

  onSignUp() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _loading = true);
    try {
      await UserActions.createUser(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (mounted) navigateToHome(context);
    } on FirebaseAuthException catch (e) {
      setState(() => _errorText = getErrorText(e.code));
    }
    setState(() => _loading = false);
  }

  onSignIn() => navigateToSignIn(context);

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
                onSave: onSignUp,
                formKey: _formKey,
                buttonTitle: 'Sign up',
                errorText: _errorText,
                loading: _loading,
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
                      recognizer: TapGestureRecognizer()..onTap = onSignIn,
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
