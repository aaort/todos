import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todos/widgets/modal_bottom_sheet.dart';

void showDateTimePicker({
  required BuildContext context,
  required Function(DateTime) onChange,
  String? title,
  DateTime? initialDateTime,
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
              // Append some time to initial date to avoid conflicts
              initialDateTime: dateTime.add(const Duration(seconds: 10)),
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

void showOptionsPicker<T>({
  required BuildContext context,
  required String title,
  required List<PickerOption<T>> options,
  required Function(T) onChange,
}) {
  final optionWidgets = options.map((option) {
    return TextButton(
      onPressed: () => onChange(option.value),
      child: Text(
        option.title.capitalize(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
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

class PickerOption<T> {
  final String title;
  final T value;

  PickerOption(this.title, this.value);
}

extension ExtendedString on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}
