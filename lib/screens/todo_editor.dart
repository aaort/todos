import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/helpers/reminder.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/theme/constants.dart';
import 'package:todos/theme/theme_manager.dart';
import 'package:todos/widgets/reminder_picker_button.dart';
import 'package:todos/widgets/repeat_option_button.dart';
import 'package:todos/widgets/todo_icon_button.dart';

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

  void onReminderChange(dynamic reminder) =>
      setState(() => _reminder = reminder);

  void onRepeatOptionChange(RepeatOption option) {
    Navigator.pop(context);
    setState(() => _repeatOption = option);
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
                ReminderPickerButton(
                  enabled: createEnabled,
                  reminder: _reminder,
                  onReminderChange: onReminderChange,
                  child: const Icon(
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
              cursorColor: isDark ? kPrimaryDarkColor : kPrimaryColor,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              key: const Key('createTodoButtonId'),
              onPressed: onTodoSaved,
              child: Text(
                'Save',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            if (_reminder != null) ...[
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 8,
                    child: ReminderPickerButton(
                      enabled: createEnabled,
                      reminder: _reminder,
                      onReminderChange: onReminderChange,
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
