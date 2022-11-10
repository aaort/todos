import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/helpers/reminder.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/theme/constants.dart';
import 'package:todos/theme/theme_manager.dart';
import 'package:todos/widgets/pickers.dart';
import 'package:todos/widgets/repeat_option_button.dart';
import 'package:todos/widgets/todo_icon_button.dart';

enum ReminderOption {
  custom,
}

final _reminderOptions = <PickerOption<dynamic>>[
  PickerOption('In 5 minutes', const Duration(minutes: 5)),
  PickerOption('In 15 minutes', const Duration(minutes: 15)),
  PickerOption('Custom', ReminderOption.custom),
];

class TodoEditor extends StatefulWidget {
  final Todo? initialTodo;

  const TodoEditor({super.key, this.initialTodo});

  @override
  State<TodoEditor> createState() => _TodoEditorState();
}

class _TodoEditorState extends State<TodoEditor> {
  final taskController = TextEditingController();
  bool createEnabled = false;

  dynamic _reminder; // Duration | DateTime | null
  RepeatOption? _repeatOption;

  String get _reminderText {
    return getReminderText(
        _reminder is Duration ? getDateTimeOfDuration(_reminder) : _reminder);
  }

  void showReminderOptionPicker() {
    showOptionPicker<dynamic>(
      context: context,
      title: 'Remind me',
      options: _reminderOptions,
      onChange: onReminderOptionChange,
    );
  }

  void onRepeatOptionChange(RepeatOption option) {
    Navigator.pop(context);
    setState(() => _repeatOption = option);
  }

  void onReminderOptionChange(dynamic option) async {
    Navigator.pop(context);
    if (option is Duration) {
      setState(() => _reminder = option);
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(const Duration(milliseconds: 400));
      showDateTimePicker(
        context: context,
        title: 'Remind me...',
        initialDateTime: _reminder is Duration
            ? getDateTimeOfDuration(_reminder)
            : _reminder,
        onChange: (option) => setState(() => _reminder = option),
      );
    }
  }

  Future<void> onTodoSaved() async {
    if (taskController.text.isNotEmpty) {
      DateTime? reminder =
          _reminder is Duration ? getDateTimeOfDuration(_reminder) : _reminder;

      final todo = Todo(taskController.text,
          reminderDateTime: reminder, repeatOption: _repeatOption);
      if (widget.initialTodo != null) {
        TodoActions(context, widget.initialTodo!).updateTodo(todo);
      } else {
        TodoActions(context, todo).createTodo();
      }
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  void initState() {
    taskController.text = widget.initialTodo?.task ?? '';
    _reminder = widget.initialTodo?.reminderDateTime;
    taskController.addListener(() {
      setState(() => createEnabled = taskController.text.isNotEmpty);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeManager>().isDark;
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Todo',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TodoIconButton(
                  onPressed: createEnabled ? showReminderOptionPicker : null,
                  icon: const Icon(
                    Icons.timer_outlined,
                  ),
                ),
              ],
            ),
            TextField(
              key: const Key('createTodoInputId'),
              autofocus: true,
              controller: taskController,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(context).textTheme.bodySmall,
              cursorColor: isDark ? primaryDarkColor : primaryColor,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              key: const Key('createTodoButtonId'),
              onPressed: onTodoSaved,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            if (_reminder != null) ...[
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 8,
                    child: GestureDetector(
                      onTap: showReminderOptionPicker,
                      child: Text(
                        _reminderText,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  TodoIconButton(
                    onPressed: clearReminder,
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              if (_reminder != null) ...[
                const SizedBox(height: 30),
                RepeatOptionButton(
                  repeatOption: _repeatOption,
                  onOptionChange: onRepeatOptionChange,
                )
              ]
            ]
          ],
        ),
      ),
    );
  }

  void clearReminder() {
    setState(() => _reminder = null);
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }
}
