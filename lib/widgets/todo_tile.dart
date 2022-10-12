import 'package:flutter/material.dart' hide Checkbox;
import 'package:provider/provider.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/logic/todos_io.dart';
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
        onLongPress: () {
          setState(() => enabled = true);
          Future.delayed(const Duration(milliseconds: 100), () {
            // delay is required for focus to work as expected
            focusNode.requestFocus();
          });
        },
        leading: SizedBox(
          width: MediaQuery.of(context).size.width - 150,
          child: TextFormField(
            focusNode: focusNode,
            controller: taskController,
            enabled: enabled,
            decoration: const InputDecoration(border: InputBorder.none),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.blueGrey,
                decoration: todo.checked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            enabled
                ? IconButton(
                    onPressed: () {
                      setState(() => enabled = false);
                      taskController.text = todo.task;
                      focusNode.unfocus();
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
                  setState(() => enabled = false);
                  focusNode.unfocus();
                  data.editTodo(todo.id, taskController.text);
                  TodosIO.editTodo(id: todo.id, todo: todo);
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
      await TodosIO.editTodo(id: widget.id, todo: updatedTodo);
    }
  }
}
