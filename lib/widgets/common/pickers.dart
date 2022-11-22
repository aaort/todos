import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todos/helpers.dart';
import 'modal_bottom_sheet.dart';

void showDateTimePicker({
  required BuildContext context,
  required Function(DateTime) onChange,
  String? title,
  DateTime? initialDateTime,
}) {
  DateTime dateTime = getInitialDateTime(initialDateTime);

  final minimumDate = getMinimumDateTime();

  void onDateTimeChange(DateTime newDateTime) => dateTime = newDateTime;

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
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle:
                      Theme.of(context).textTheme.bodySmall,
                ),
              ),
              child: CupertinoDatePicker(
                onDateTimeChanged: onDateTimeChange,
                minimumDate: minimumDate,
                use24hFormat: true,
                // Append some time to initial date to avoid conflicts
                initialDateTime: dateTime,
              ),
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

Future<void> showOptionPicker<T>({
  required BuildContext context,
  required String title,
  required List<PickerOption<T>> options,
  required Function(T) onChange,
}) async {
  final optionWidgets = options.map((option) {
    return TextButton(
      onPressed: () => onChange(option.value),
      child: Text(
        option.title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }).toList();

  await popupModalBottomSheet(
    context: context,
    child: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ...optionWidgets,
        ],
      ),
    ),
  );
}

class PickerOption<T> {
  final String title;
  final T value;

  PickerOption(this.title, this.value);
}
