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

  void onDateTimeChange(DateTime newDateTime) =>
      setState(() => _reminderDateTime = newDateTime);

  void onReminderOptionChange(ReminderOption option) async {
    switch (option) {
      case ReminderOption.in_5_minutes:
        break;
      // TODO: implement notification scheduled in 5 minutes
      case ReminderOption.in_15_minutes:
        break;
      // TODO: implement notification scheduled in 15 minutes
      case ReminderOption.custom_date_and_time:
        FocusNode().unfocus();
        await Future.delayed(const Duration(milliseconds: 200));
        showDateTimePicker(
          context: context,
          title: 'Set reminder date and time',
          initialDateTime: _reminderDateTime,
          onChange: onDateTimeChange,
        );
    }
  }

  @override
  void initState() {
    taskController.addListener(() {
      setState(() => createEnabled = taskController.text.length >= 5);
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
                icon: const Icon(Icons.date_range),
                onPressed: onReminderOptionPick,
              ),
            ],
          ),
          TextField(
            autofocus: true,
            controller: taskController,
            style: const TextStyle(color: Colors.blueGrey),
            cursorColor: Colors.blueGrey,
          ),
          const SizedBox(height: 30),
          RawMaterialButton(
            fillColor: createEnabled ? Colors.blueGrey : Colors.blueGrey[300],
            disabledElevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            onPressed:
                createEnabled ? () => onCreateTodo(taskController.text) : null,
            child: Text(
              'Save',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onCreateTodo(String task) async {
    final todo = Todo(task);
    context.read<Todos>().addTodo(todo);
    await TodosIO.createTodo(todo);

    final reminderDateTime = _reminderDateTime;
    if (reminderDateTime != null) {
      Notifications.addTodoReminder(reminderDateTime, todo);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }
}
