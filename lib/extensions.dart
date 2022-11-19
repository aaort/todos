import 'package:flutter/material.dart';
import 'package:todos/widgets/todo_editor/repeat_button.dart';

extension Stringify on Repeat {
  String toName() => toString().split('.').last;
}

extension CustomTextStyles on TextTheme {
  TextStyle get lineThrough =>
      bodySmall!.copyWith(decoration: TextDecoration.lineThrough);
}
