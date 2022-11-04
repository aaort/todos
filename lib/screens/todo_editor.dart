// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:todos/helpers/date.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/widgets/pickers.dart';
import 'package:todos/widgets/todo_icon_button.dart';

enum ReminderOption {
// using underscores here to be able separate words
// for displaying as option titles inside picker
  in_5_minutes,
  in_15_minutes,
  custom,
}

final _reminderOptions = <PickerOption<ReminderOption>>[
  PickerOption('In 5 minutes', ReminderOption.in_5_minutes),
  PickerOption('In 15 minutes', ReminderOption.in_15_minutes),
  PickerOption('Custom', ReminderOption.custom),
];

// Using StatefulWidget here only to check for mounted field before pop call
class TodoEditor extends StatefulWidget {
  final Todo? initialTodo;

  const TodoEditor({super.key, this.initialTodo});

  @override
  State<TodoEditor> createState() => _TodoEditorState();
}

class _TodoEditorState extends State<TodoEditor> {
  final taskController = TextEditingController();
  bool createEnabled = false;

  DateTime? _reminderDateTime;
  ReminderOption? _reminderOption;

  String get _reminderText {
    if (_reminderDateTime != null) {
      return getReminderText(_reminderDateTime!);
    }
    return 'Remind me in ${_reminderOption == ReminderOption.in_5_minutes ? 5 : 15} minutes';
  }

  void onReminderOptionPick() {
    showOptionsPicker<ReminderOption>(
      context: context,
      title: 'Remind me',
      options: _reminderOptions,
      onChange: onReminderOptionChange,
    );
  }

  void onDateTimeChange(DateTime newDateTime) {
    setState(() {
      _reminderDateTime = newDateTime.add(const Duration(milliseconds: 10));
    });
  }

  void onReminderOptionChange(ReminderOption option) async {
    Navigator.pop(context);
    if (option == ReminderOption.custom) {
      FocusManager.instance.primaryFocus?.unfocus();
      await Future.delayed(const Duration(milliseconds: 400));
      showDateTimePicker(
        context: context,
        title: 'Remind me...',
        initialDateTime: _reminderDateTime,
        onChange: onDateTimeChange,
      );
    } else {
      _reminderDateTime = null;
    }
    setState(() => _reminderOption = option);
  }

  Future<void> onTodoSaved() async {
    if (taskController.text.isNotEmpty) {
      DateTime? reminder = _reminderDateTime;
      reminder ??= DateTime.now().add(Duration(
          minutes: _reminderOption == ReminderOption.in_5_minutes ? 5 : 15));
      final todo = Todo(taskController.text, reminderDateTime: reminder);
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
    _reminderDateTime = widget.initialTodo?.reminderDateTime;
    taskController.addListener(() {
      setState(() => createEnabled = taskController.text.isNotEmpty);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 2.5 +
            MediaQuery.of(context).viewInsets.bottom,
      ),
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
                onPressed: createEnabled ? onReminderOptionPick : null,
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
            cursorColor: Colors.blueGrey,
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
          if (_reminderDateTime != null || _reminderOption != null) ...[
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 8,
                  child: GestureDetector(
                    onTap: onReminderOptionPick,
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
          ]
        ],
      ),
    );
  }

  void clearReminder() {
    setState(() {
      _reminderOption = null;
      _reminderDateTime = null;
    });
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }
}
