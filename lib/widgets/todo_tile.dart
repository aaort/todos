import 'package:flutter/material.dart' hide Checkbox;
import 'package:provider/provider.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/logic/todos_io.dart';
import 'package:todos/widgets/checkbox.dart';

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
    return Consumer<Todos>(builder: (context, data, _) {
      final todo = data.getTodoById(widget.id);
      return Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (_) => onDeleteTodo(todo.id),
        child: GestureDetector(
          onLongPress: () => toggleTodoState(true),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextFormField(
                    focusNode: focusNode,
                    controller: taskController,
                    enabled: enabled,
                    cursorColor: Colors.blueGrey,
                    decoration: const InputDecoration(border: InputBorder.none),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.blueGrey,
                        decoration: todo.checked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (enabled) ...[
                        IconButton(
                          padding: const EdgeInsets.only(right: 10.0),
                          constraints: const BoxConstraints(),
                          onPressed: () => onDiscard(todo.task),
                          icon: const Icon(Icons.close),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          constraints: const BoxConstraints(),
                          onPressed: () => onEditTodo(todo),
                          icon: const Icon(Icons.check),
                        )
                      ] else
                        Checkbox(
                          checked: todo.checked,
                          onTap: () => data.toggleCheck(widget.id),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void onDiscard(String initialTask) {
    toggleTodoState(false);
    taskController.text = initialTask;
  }

  Future<void> onEditTodo(Todo todo) async {
    toggleTodoState(false);
    context.read<Todos>().editTodo(todo.id, taskController.text);
    TodosIO.editTodo(todo);
  }

  Future<void> onDeleteTodo(String id) async {
    context.read<Todos>().deleteTodo(id);
    await TodosIO.deleteTodo(id);
  }

  void toggleTodoState(bool editable) {
    // Might be used for todo to always display the beginning of task
    // taskController.selection = TextSelection.fromPosition(
    //   TextPosition(offset: taskController.text.length),
    // );
    if (editable) {
      setState(() => enabled = true);
      // Delay is required for focus to work as expected
      Future.delayed(
        const Duration(milliseconds: 100),
        () => focusNode.requestFocus(),
      );
    } else {
      setState(() => enabled = false);
      focusNode.unfocus();
    }
  }
}
