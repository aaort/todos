import 'package:flutter/material.dart';
import 'package:todos/helpers/reminder.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/widgets/reminder_picker_button.dart';
import 'package:todos/widgets/repeat_option_button.dart';
import 'package:todos/widgets/save_todo_button.dart';
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
            ),
            const SizedBox(height: 30),
            SaveTodoButton(
              task: taskController.text,
              reminder: _reminder,
              repeatOption: _repeatOption,
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
