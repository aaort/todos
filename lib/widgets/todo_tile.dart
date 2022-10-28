import 'package:flutter/material.dart' hide Checkbox;
import 'package:provider/provider.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/widgets/checkbox.dart';
import 'package:todos/widgets/dismissible.dart';
import 'package:todos/widgets/modal_bottom_sheet.dart';

class TodoTile extends StatefulWidget {
  final String id;

  const TodoTile({super.key, required this.id});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  bool enabled = false;

  void onLongPress() async {
    final todo = context.read<Todos>().getTodoById(widget.id);
    popupModalBottomSheet(context: context, child: AddTodo(initialTodo: todo));
  }

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<Todos>().getTodoById(widget.id);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DismissibleTile(
        onDismiss: () => TodoActions(context, todo).onDeleteTodo(todo),
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  todo.task,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Checkbox(
                  checked: todo.checked,
                  onTap: () => context.read<Todos>().toggleCheck(widget.id),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
