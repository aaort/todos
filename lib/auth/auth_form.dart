import 'package:flutter/material.dart';
import 'package:todos/auth/utils.dart';
import 'package:todos/widgets/loading_indicator.dart';

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
            // TODO: uncomment
            // autofocus: true,
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
