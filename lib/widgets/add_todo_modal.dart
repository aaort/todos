import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todos/logic/notifications.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/logic/todos_io.dart';

// Using StatefulWidget here only to check for mounted field before pop call
class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final taskController = TextEditingController();
  bool createEnabled = false;

  DateTime? pickedReminder;

  Future<void> setReminder() async {
    BottomPicker.date(
      title: "Set your Birthday",
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Colors.blue,
      ),
      onChange: (reminderDate) {
        setState(() => pickedReminder = reminderDate);
      },
      displaySubmitButton: false,
    ).show(context);
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
                onPressed: setReminder,
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

    final reminderDate = pickedReminder;
    if (reminderDate != null) {
      Notifications.addTodoReminder(reminderDate, todo);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }
}
