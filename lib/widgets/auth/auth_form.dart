import 'package:flutter/material.dart';
import 'package:todos/widgets/common/loading_indicator.dart';

class AuthForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function() onSave;
  final String buttonTitle;
  final String? errorText;
  final bool loading;

  const AuthForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSave,
    required this.buttonTitle,
    required this.loading,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: emailController,
            autofocus: true,
            validator: emailValidator,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              label: Text('Email'),
            ),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            validator: passwordValidator,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              label: Text('Password'),
            ),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onSave,
            child: loading ? const LoadingIndicator() : Text(buttonTitle),
          ),
          if (errorText != null) ...[
            const SizedBox(height: 20),
            Text(
              errorText!,
              textAlign: TextAlign.center,
              style: Theme.of(context).inputDecorationTheme.errorStyle,
            ),
          ]
        ],
      ),
    );
  }
}

final authExceptions = <String>[
  'wrong-password',
  'weak-password',
  'email-already-in-use',
  'user-not-found',
];

final Map errorMessages = <String, String>{
  authExceptions[0]: 'Provided password is incorrect',
  authExceptions[1]: 'Provided password is too weak',
  authExceptions[2]: 'Provided email is already in use',
  authExceptions[3]: "There is no user found with provided credentials",
};

String getErrorText(String errorCode) {
  try {
    return errorMessages.entries
        .firstWhere((entry) => entry.key == errorCode)
        .value;
  } catch (_) {
    return 'Unexpected exception occurred';
  }
}

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Please enter your email';
  }
  if (!email.contains('@')) {
    return 'Your email should container @ sign';
  }

  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Please enter your password';
  }
  if (password.length < 6) {
    return 'Your password is too short';
  }

  return null;
}
