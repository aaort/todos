import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';

Future<void> showDateTimePicker({
  required BuildContext context,
  String? title,
  DateTime? initialDateTime,
  required Function(DateTime) onChange,
}) async {
  initialDateTime ??= DateTime.now();

  BottomPicker.dateTime(
    title: title ?? "Pick date and time",
    initialDateTime: initialDateTime,
    titleStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Colors.blue,
    ),
    onChange: (pickedReminderDateTime) {
      onChange(pickedReminderDateTime);
    },
    displaySubmitButton: false,
  ).show(context);
}
