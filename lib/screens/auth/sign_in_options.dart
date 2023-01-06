import 'package:flutter/material.dart';
import 'package:todos/logic/services/auth.dart';
import 'package:todos/screens/auth/sign_in.dart';

const _laterText =
    'Your todos will be visible only on this device. However, You can sign in later to be able to sync your data across multiple devices';

class SignInOptions extends StatefulWidget {
  const SignInOptions({super.key});

  @override
  State<SignInOptions> createState() => _SignInOptionsState();
}

class _SignInOptionsState extends State<SignInOptions> {
  onEmailAndPassword() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const SignIn(),
      ),
    );
  }

  onLater() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(_laterText, textAlign: TextAlign.center),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    // Await until dialog will be hidden
                    await Future.delayed(const Duration(milliseconds: 300));
                    Auth.signInAnonymously();
                  },
                  child: const Text('Ok'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: onLater,
              child: const Text('Later'),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: onEmailAndPassword,
              child: const Text('Email & Password'),
            ),
          ],
        ),
      ),
    );
  }
}
