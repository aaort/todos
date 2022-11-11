import 'package:flutter/material.dart';
import 'package:todos/helpers/reminder.dart';
import 'package:todos/widgets/pickers.dart';

enum ReminderOption {
  custom,
}

final _reminderOptions = <PickerOption<dynamic>>[
  PickerOption('In 5 minutes', const Duration(minutes: 5)),
  PickerOption('In 15 minutes', const Duration(minutes: 15)),
  PickerOption('Custom', ReminderOption.custom),
];

class ReminderPickerButton extends StatelessWidget {
  final bool enabled;
  final dynamic reminder;
  final Function(dynamic) onReminderChange;
  final Widget child;

  ReminderPickerButton({
    super.key,
    this.reminder,
    required this.enabled,
    required this.onReminderChange,
    required this.child,
  });

  final _key = GlobalKey();

  void showReminderOptionPicker() {
    showOptionPicker<dynamic>(
      context: _key.currentContext!,
      title: 'Remind me',
      options: _reminderOptions,
      onChange: onReminderOptionChange,
    );
  }

  void onReminderOptionChange(dynamic option) async {
    Navigator.pop(_key.currentContext!);
    if (option is Duration) {
      onReminderChange(option);
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(const Duration(milliseconds: 400));
      showDateTimePicker(
        context: _key.currentContext!,
        title: 'Remind me...',
        initialDateTime:
            reminder is Duration ? getDateTimeOfDuration(reminder) : reminder,
        onChange: onReminderChange,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: enabled ? showReminderOptionPicker : null,
      child: Opacity(opacity: enabled ? 1 : 0.4, child: child),
    );
  }
}