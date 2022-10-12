import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/logic/todos_io.dart';

const addTodoButtonTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

class AddTodo extends StatefulWidget {
  final String? initialTask;

  const AddTodo({super.key, this.initialTask});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  late TextEditingController taskController;
  late bool isNewTodo;
  bool addButtonEnabled = false;

  @override
  void initState() {
    taskController = TextEditingController(text: widget.initialTask);
    isNewTodo = widget.initialTask == null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final addTodoModalHeight = bottomInset == 0 ? 500.0 : bottomInset * 2;
    return Consumer<Todos>(
      builder: (context, data, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
          height: addTodoModalHeight,
          child: ListView(
            children: [
              if (widget.initialTask != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop('returned string');
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              Text(
                'Add Todo',
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
                    isNewTodo
                        ? onCreateTodo(context, task)
                        : onEditTodo(context, task);
                  }
                },
                child: const Text(
                  'Save',
                  style: addTodoButtonTextStyle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> onCreateTodo(BuildContext context, String task) async {
    Provider.of<Todos>(context, listen: false).addTodo(Todo(task));
    await TodosIO.createTodo(Todo(task));

    if (mounted) Navigator.pop(context);
  }

  void onEditTodo(BuildContext context, String task) {
    Navigator.of(context).pop(task);
  }
}
