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

class TaskTile extends StatelessWidget {
  final String id;

  const TaskTile({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Todos>(context);
    final todo = data.getTodoById(id);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        onLongPress: () {
          data.removeTodo(id);
          TodosIO.deleteTodo(id);
        },
        leading: SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: Text(
            todo.task,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: todo.checked ? Colors.blueGrey : Colors.black,
                decoration: todo.checked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                onEditTodo(context, todo);
              },
              icon: const Icon(Icons.edit, size: 27, color: Colors.blueGrey),
            ),
            Checkbox(
              checked: todo.checked,
              onTap: () => data.toggleCheck(id),
            ),
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
      await TodosIO.eidtTodo(id: id, todo: updatedTodo);
    }
  }
}
