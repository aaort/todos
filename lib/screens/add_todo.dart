// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/notifications.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/logic/todos_io.dart';
import 'package:todos/widgets/pickers.dart';

enum ReminderOption {
// using underscores here to be able separate words
// for displaying as option titles inside picker
  in_5_minutes,
  in_15_minutes,
  custom_date_and_time,
}

// Using StatefulWidget here only to check for mounted field before pop call
class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final taskController = TextEditingController();
  bool createEnabled = false;

  DateTime? _reminderDateTime;

  void onReminderOptionPick() {
    showReminderOptionsPicker<ReminderOption>(
      context: context,
      options: ReminderOption.values,
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
    switch (option) {
      case ReminderOption.in_5_minutes:
        onDateTimeChange(DateTime.now().add(const Duration(minutes: 6)));
        break;
      case ReminderOption.in_15_minutes:
        onDateTimeChange(DateTime.now().add(const Duration(minutes: 16)));
        break;
      case ReminderOption.custom_date_and_time:
        FocusManager.instance.primaryFocus?.unfocus();
        await Future.delayed(const Duration(milliseconds: 400));
        showDateTimePicker(
          context: context,
          title: 'Remind me...',
          initialDateTime: _reminderDateTime,
          onChange: onDateTimeChange,
        );
    }
  }

  @override
  void initState() {
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
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Todo',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                onPressed: createEnabled ? onReminderOptionPick : null,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
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
            style: Theme.of(context).textTheme.bodySmall,
            cursorColor: Colors.blueGrey,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            key: const Key('createTodoButtonId'),
            onPressed: onCreateTodo,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Save',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          if (_reminderDateTime != null) ...[
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 8,
                  child: GestureDetector(
                    onTap: onReminderOptionPick,
                    child: Text(
                      _getReminderText(_reminderDateTime!),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => _reminderDateTime = null),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.delete_forever_outlined),
                )
              ],
            ),
          ]
        ],
      ),
    );
  }

  Future<void> onCreateTodo() async {
    final task = taskController.text;
    if (task.isEmpty) {
      Navigator.pop(context);
      return;
    }
    final todo = Todo(task, reminderDateTime: _reminderDateTime);
    context.read<Todos>().addTodo(todo);
    await TodosIO.createTodo(todo);

    if (todo.reminderDateTime != null) {
      Notifications.addTodoReminder(todo);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }
}

// TODO: need refactor
String _getReminderText(DateTime dateTime) {
  final diff = dateTime.difference(DateTime.now());
  if (diff.inHours < 1) {
    return 'Remind me in ${diff.inMinutes.toString()} minutes';
  } else if (diff.inHours < 24) {
    return 'Remind me today at ${dateTime.hour.toString().padLeft(2, '0')}'
        ':${dateTime.minute.toString().padLeft(2, '0')}';
  } else {
    return 'Remind me in ${diff.inDays} day${diff.inDays > 1 ? 's' : ''}';
  }
}
