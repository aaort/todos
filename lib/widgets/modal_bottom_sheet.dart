import 'package:flutter/material.dart';
import 'package:todos/styles.dart';

void popupModalBottomSheet({
  required BuildContext context,
  required Widget child,
  EdgeInsets? padding,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: Styles(context).getRoundedBordersShape(20),
    builder: (context) => Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 10.0),
      child: child,
    ),
  );
}
