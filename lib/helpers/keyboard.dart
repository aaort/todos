import 'package:flutter/material.dart';

Future<void> hideKeyboardAndWait() async {
  FocusManager.instance.primaryFocus?.unfocus();
  await Future.delayed(const Duration(milliseconds: 400));
}
