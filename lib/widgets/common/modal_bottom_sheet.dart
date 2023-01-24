import 'package:flutter/material.dart';

Future<void> popupModalBottomSheet({
  required BuildContext context,
  required Widget child,
  EdgeInsets? padding,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 10.0),
      child: child,
    ),
  );
}
