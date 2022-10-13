import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/logic/todos_io.dart';

class AddTodo extends StatefulWidget {
  final String? initialTask;

  const AddTodo({super.key, this.initialTask});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  late TextEditingController taskController;
  late bool isNewTodo;

  @override
  void initState() {
    taskController = TextEditingController(text: widget.initialTask);
    isNewTodo = widget.initialTask == null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Todos>(
      builder: (context, data, child) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height / 2.5 +
                MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0),
          child: ListView(
            children: [
              Text(
                'New Todo',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextField(
                autofocus: true,
                controller: taskController,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.lightBlue),
              ),
              const SizedBox(height: 30),
              RawMaterialButton(
                fillColor: taskController.text.length > 5
                    ? Colors.lightBlue
                    : Colors.blueGrey,
                disabledElevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                onPressed: () {
                  final task = taskController.text;
                  if (task.length > 5) {
                    isNewTodo ? onCreateTodo(task) : onEditTodo(context, task);
                  }
                },
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> onCreateTodo(String task) async {
    Provider.of<Todos>(context, listen: false).addTodo(Todo(task));
    await TodosIO.createTodo(Todo(task));

    if (mounted) Navigator.pop(context);
  }

  void onEditTodo(BuildContext context, String task) {
    Navigator.of(context).pop(task);
  }
}
