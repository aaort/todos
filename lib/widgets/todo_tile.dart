import 'package:flutter/material.dart' hide Checkbox;
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/notifications.dart';
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
      return DismissibleTile(
        key: UniqueKey(),
        onDismissed: (_) => onDeleteTodo(todo),
        confirmDismiss: (_) => onConfirmDelete(context),
        ltrDismissedColor: Colors.red,
        rtlDismissedColor: Colors.red,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        delayBeforeResize: const Duration(milliseconds: 500),
        child: GestureDetector(
          onLongPress: toggleTodoState,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if (!hasFocus) {
                        setState(() => enabled = false);
                      }
                    },
                    child: TextFormField(
                      autofocus: true,
                      focusNode: focusNode,
                      controller: taskController,
                      enabled: enabled,
                      cursorColor: Colors.blueGrey,
                      textCapitalization: TextCapitalization.sentences,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          decoration: todo.checked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
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
                          onPressed: () {
                            final newTodo = todo;
                            newTodo.task = taskController.text;
                            onEditTodo(newTodo);
                          },
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
    toggleTodoState();
    taskController.text = initialTask;
  }

  Future<void> onEditTodo(Todo todo) async {
    toggleTodoState();
    context.read<Todos>().editTodo(todo.id, taskController.text);
    await TodosIO.editTodo(todo);
  }

  Future<void> onDeleteTodo(Todo todo) async {
    context.read<Todos>().deleteTodo(todo.id);
    await TodosIO.deleteTodo(todo.id);
    final reminderId = todo.reminderId;
    if (reminderId != null) {
      await Notifications.removeTodoReminder(reminderId);
    }
  }

  void toggleTodoState() async {
    setState(() => enabled = !enabled);
    await Future.delayed(const Duration(milliseconds: 100));
    enabled ? focusNode.requestFocus() : null;
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}

Future<bool?> onConfirmDelete(BuildContext context) async {
  bool confirmation = true;
  await ScaffoldMessenger.of(context)
      .showSnackBar(
        SnackBar(
          content: const Text('Todo\'s deleted'),
          duration: const Duration(seconds: 4),
          width: MediaQuery.of(context).size.width - 30,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              confirmation = false;
            },
          ),
        ),
      )
      .closed;

  return confirmation;
}
