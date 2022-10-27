import 'package:flutter/material.dart' hide Checkbox, Dismissible;
import 'package:provider/provider.dart';
import 'package:todos/logic/notifications.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/logic/todos_io.dart';
import 'package:todos/widgets/checkbox.dart';
import 'package:todos/widgets/dismissible.dart';

class TodoTile extends StatefulWidget {
  final String id;

  const TodoTile({super.key, required this.id});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  bool enabled = false;
  final FocusNode focusNode = FocusNode();
  late TextEditingController taskController = TextEditingController();

  void onFocusChange(bool hasFocus) {
    if (!hasFocus) {
      setState(() => enabled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<Todos>().getTodoById(widget.id);

    return Dismissible(
      onDismiss: () => onDeleteTodo(todo),
      child: GestureDetector(
        onLongPress: toggleTodoState,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Focus(
                  onFocusChange: onFocusChange,
                  child: TextFormField(
                    autofocus: true,
                    focusNode: focusNode,

                    /// Probably not the best solution because
                    /// will update text on each rerender
                    controller: taskController..text = todo.task,
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
                        padding: const EdgeInsets.only(right: 10.0),
                        constraints: const BoxConstraints(),
                        // TODO: implement reminder editing
                        onPressed: () {},
                        icon: const Icon(Icons.timer_outlined),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          onEditTodo(todo..task = taskController.text);
                        },
                        icon: const Icon(Icons.check),
                      )
                    ] else
                      Checkbox(
                        checked: todo.checked,
                        onTap: () =>
                            context.read<Todos>().toggleCheck(widget.id),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
