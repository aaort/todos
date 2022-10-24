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
    titleStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 25.0),
    pickerTextStyle: const TextStyle(fontSize: 20.0, color: Colors.blueGrey),
    onChange: (pickedReminderDateTime) {
      onChange(pickedReminderDateTime);
    },
    dismissable: true,
    displaySubmitButton: false,
    displayCloseIcon: false,
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
    final capitalizedTitle =
        optionTitle[0].toUpperCase() + optionTitle.substring(1);
    return TextButton(
      onPressed: () => onChange(options[options.indexOf(option)]),
      child: Text(
        capitalizedTitle,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20.0),
      ),
    );
  }).toList();

  showModalBottomSheet(
    context: context,
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: optionWidgets,
      );
    },
  );
}
