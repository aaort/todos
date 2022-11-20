import 'package:flutter/material.dart';
import 'package:todos/extensions.dart' show Reminder;
import 'package:todos/helpers/keyboard.dart';
import 'package:todos/theme/constants.dart';
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

  void showReminderOptionPicker() async {
    await ensureKeyboardIsHidden(_key.currentContext!);
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
      await ensureKeyboardIsHidden(_key.currentContext!);
      showDateTimePicker(
        context: _key.currentContext!,
        title: 'Remind me...',
        initialDateTime: reminder is Duration
            ? (reminder as Duration).toDateTime()
            : reminder,
        onChange: onReminderChange,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: enabled ? showReminderOptionPicker : null,
      child: Opacity(opacity: enabled ? 1 : kDisabledOpacity, child: child),
    );
  }
}
