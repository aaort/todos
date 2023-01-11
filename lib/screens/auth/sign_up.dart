import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:todos/app_navigator.dart';
import 'package:todos/services/auth.dart';
import 'package:todos/screens/auth/sign_in.dart';
import 'package:todos/widgets/auth/auth_form.dart';

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

  _onSignUp() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _loading = true);
    try {
      final user = await Auth.createUser(
        _emailController.text,
        _passwordController.text,
      );

      if (user != null && mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AppNavigator()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _errorText = getErrorText(e.code));
    }
    setState(() => _loading = false);
  }

  _onSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
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
                onSubmit: _onSignUp,
                formKey: _formKey,
                buttonTitle: 'Sign up',
                errorText: _errorText,
                loading: _loading,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ? ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  InkWell(
                    onTap: _onSignIn,
                    child: Text(
                      'Sign in',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
