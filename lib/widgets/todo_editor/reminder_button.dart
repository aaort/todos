import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos/extensions.dart' show ToDateTime;
import 'package:todos/helpers.dart' show ensureKeyboardIsHidden;
import 'package:todos/models/todo.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/widgets/common/disabled_opacity.dart';
import 'package:todos/widgets/common/pickers.dart';

enum ReminderOption {
  custom,
}

const _reminderOptions = <PickerOption<ReminderOption>>[
  // PickerOption('In 5 minutes', Duration(minutes: 5)),
  // PickerOption('In 15 minutes', Duration(minutes: 15)),
  PickerOption('Custom', ReminderOption.custom),
];

class ReminderButton extends ConsumerWidget {
  final Widget child;
  final Todo? initialTodo;

  const ReminderButton({super.key, this.initialTodo, required this.child});

  void showReminderOptionPicker(WidgetRef ref) async {
    await ensureKeyboardIsHidden(ref.context);
    showOptionPicker<ReminderOption>(
      context: ref.context,
      title: 'Remind me',
      options: _reminderOptions,
      onChange: (_) => onReminderOptionChange(ref: ref, option: _),
    );
  }

  void onReminderOptionChange(
      {required WidgetRef ref, required dynamic option}) async {
    Navigator.pop(ref.context);
    if (option is Duration) {
      onReminderChange(ref: ref, option: option);
    } else {
      await ensureKeyboardIsHidden(ref.context);
      final reminder = ref.read(todoProvider(initialTodo)).reminder;
      showDateTimePicker(
        context: ref.context,
        title: 'Remind me...',
        initialDateTime: reminder?.dateTime,
        onChange: (_) => onReminderChange(ref: ref, option: _),
      );
    }
  }

  void onReminderChange({required WidgetRef ref, dynamic option}) {
    final reminder = option is Duration ? option.toDateTime() : option;
    ref
        .read(todoProvider(initialTodo).notifier)
        .updateReminder({'dateTime': reminder});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(todoProvider(initialTodo)).task.isNotEmpty;
    return DisabledOpacity(
      enabled: enabled,
      child: GestureDetector(
        onTap: enabled ? () => showReminderOptionPicker(ref) : null,
        child: child,
      ),
    );
  }
}
