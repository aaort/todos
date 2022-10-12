import 'package:flutter/material.dart' hide Checkbox;
import 'package:provider/provider.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/logic/todos_io.dart';
import 'package:todos/styles/text_field.dart';
import 'package:todos/widgets/add_todo_modal.dart';
import 'package:todos/widgets/checkbox.dart';

final checkboxColors = MaterialStateProperty.resolveWith<Color>((states) {
  if (states.contains(MaterialState.selected)) {
    return Colors.blueGrey;
  } else {
    return Colors.grey;
  }
});

class TodoTile extends StatefulWidget {
  final String id;

  const TodoTile({super.key, required this.id});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  bool enabled = false;
  late FocusNode focusNode;
  late TextEditingController taskController;

  @override
  void initState() {
    focusNode = FocusNode();
    final initialTask = context.read<Todos>().getTodoById(widget.id).task;
    taskController = TextEditingController(text: initialTask);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Todos>(context);
    final todo = data.getTodoById(widget.id);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        onLongPress: () => toggleTodoState(true),
        leading: SizedBox(
          width: MediaQuery.of(context).size.width - 150,
          child: TextFormField(
            focusNode: focusNode,
            controller: taskController,
            enabled: enabled,
            cursorColor: Colors.blueGrey,
            decoration: const InputDecoration(border: InputBorder.none),
            style:
                todo.checked ? kTodoCheckedTextStyle : kTodoUncheckedTextStyle,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            enabled
                ? IconButton(
                    onPressed: () {
                      toggleTodoState(false);
                      taskController.text = todo.task;
                    },
                    icon: const Icon(Icons.close,
                        size: 27, color: Colors.blueGrey),
                  )
                : Checkbox(
                    checked: todo.checked,
                    onTap: () => data.toggleCheck(widget.id),
                  ),
            if (enabled)
              IconButton(
                onPressed: () {
                  toggleTodoState(false);
                  data.editTodo(todo.id, taskController.text);
                  TodosIO.editTodo(todo);
                },
                icon: const Icon(Icons.check, size: 27, color: Colors.blueGrey),
              )
          ],
        ),
      ),
    );
  }

  Future<void> onEditTodo(BuildContext context, Todo todo) async {
    final updatedTask = await showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) => AddTodo(
        initialTask: todo.task,
      ),
    );
    if (updatedTask != null) {
      Provider.of<Todos>(context, listen: false).editTodo(todo.id, updatedTask);
      final updatedTodo =
          Todo.fromMap(task: updatedTask, checked: todo.checked, id: todo.id);
      await TodosIO.editTodo(updatedTodo);
    }
  }

  void toggleTodoState(bool edtiable) {
    if (edtiable) {
      setState(() => enabled = true);
      // Delay is required for focus to work as expected
      Future.delayed(
        const Duration(milliseconds: 10),
        () => focusNode.requestFocus(),
      );
    } else {
      setState(() => enabled = false);
      focusNode.unfocus();
    }
  }
}
