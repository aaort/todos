import 'package:flutter/material.dart';

Future ensureKeyboardIsHidden(BuildContext ctx) async {
  if (MediaQuery.of(ctx).viewInsets.bottom > 0) {
    FocusManager.instance.primaryFocus?.unfocus();
    await Future.delayed(const Duration(milliseconds: 400));
  }
}
