import 'package:flutter/material.dart';
import 'package:todos/widgets/todo_editor/confirm_discard.dart';

Future<void> popupModalBottomSheet({
  required BuildContext context,
  required Widget child,
  bool shouldConfirmPop = false,
  EdgeInsets? padding,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        if (!shouldConfirmPop) return Future.value(true);
        final value = await showConfirmDiscard(context);
        return value;
      },
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 10.0),
        child: child,
      ),
    ),
  );
}
