import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';

void showDateTimePicker({
  required BuildContext context,
  String? title,
  DateTime? initialDateTime,
  required Function(DateTime) onChange,
}) {
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

void showReminderOptionsPicker<T>({
  required BuildContext context,
  String? title,
  required List<T> options,
  required Function(T) onChange,
}) {
  final optionWidgets = options.map((option) {
    final optionTitle = option.toString().split('.').last.replaceAll('_', ' ');
    return Text(optionTitle);
  }).toList();

  BottomPicker(
    items: optionWidgets,
    title: title ?? 'Pick value',
    dismissable: true,
    onSubmit: (pickedOptionIndex) {
      onChange(options[pickedOptionIndex]);
    },
  ).show(context);
}
