import 'package:flutter/material.dart';
import 'package:todos/auth/utils.dart';

class CustomForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function() onSave;
  final String buttonTitle;
  final String? errorText;

  const CustomForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSave,
    required this.buttonTitle,
    this.errorText,
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: widget.emailController,
            // autofocus: true,
            validator: emailValidator,
            decoration: const InputDecoration(
              label: Text('Email'),
            ),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextFormField(
            controller: widget.passwordController,
            obscureText: true,
            validator: passwordValidator,
            decoration: const InputDecoration(
              label: Text('Password'),
            ),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: widget.onSave,
            child: Text(widget.buttonTitle),
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
    );
  }
}
