import 'package:flutter/material.dart';

class Styles {
  final BuildContext context;

  Styles(this.context);

  Styles.of(this.context);

  TextStyle getTodoTextStyle(bool checked) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
        decoration: checked ? TextDecoration.lineThrough : TextDecoration.none);
  }

  BoxDecoration get getTodoListContainerStyle {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    );
  }
}
