import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todos/widgets/modal_bottom_sheet.dart';

void showDateTimePicker({
  required BuildContext context,
  String? title,
  DateTime? initialDateTime,
  required Function(DateTime) onChange,
}) {
  DateTime dateTime = initialDateTime ?? DateTime.now();

  popupModalBottomSheet(
    context: context,
    child: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20.0),
          Text(
            title ?? 'Remind me in...',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: CupertinoDatePicker(
              onDateTimeChanged: (newDateTime) => dateTime = newDateTime,
              minimumDate: DateTime.now(),
              initialDateTime: dateTime,
            ),
          ),
          InkWell(
            onTap: () {
              onChange(dateTime);
              Navigator.pop(context);
            },
            child: Text('Done', style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    ),
  );
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

  popupModalBottomSheet(
    context: context,
    child: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: optionWidgets,
      ),
    ),
  );
}
