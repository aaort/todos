import 'package:flutter/material.dart';

void popupModalBottomSheet(
    {required BuildContext context, required Widget child}) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) => child,
  );
}
