import 'package:flutter/material.dart';
import 'package:todos/helpers.dart';
import 'package:todos/widgets/common/pickers.dart';

final options = [
  PickerOption<bool>('Discard', true),
  PickerOption<bool>('Cancel', false),
];

Future<bool> showConfirmDiscard(BuildContext context) async {
  bool discard = false;

  void onChange(bool newValue) {
    discard = newValue;
    Navigator.pop(context);
  }

  await ensureKeyboardIsHidden(context);
  await showOptionPicker<bool>(
    context: context,
    title: 'Are you sure ?',
    options: options,
    onChange: onChange,
  );

  if (discard) await Future.delayed(const Duration(milliseconds: 300));
  return discard;
}
