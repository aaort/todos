import 'package:flutter/material.dart' hide Checkbox;
import 'package:provider/provider.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/styles.dart';
import 'package:todos/widgets/checkbox.dart';
import 'package:todos/widgets/dismissible.dart';
import 'package:todos/widgets/todo_tile_action_button.dart';

class TodoTile extends StatefulWidget {
  final String id;

  const TodoTile({super.key, required this.id});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  bool enabled = false;
  final FocusNode focusNode = FocusNode();
  final TextEditingController taskController = TextEditingController();

  void onChangesSaved() {
    toggleTodoState();
    final todo = context.read<Todos>().getTodoById(widget.id);
    final newTodo = todo..task = taskController.text;
    TodoActions(context, newTodo).onEditTodo(
      newTodo,
    );
  }

  void onDiscard(String initialTask) {
    toggleTodoState();
    taskController.text = initialTask;
  }

  void toggleTodoState() async {
    setState(() => enabled = !enabled);
    await Future.delayed(const Duration(milliseconds: 100));
    enabled ? focusNode.requestFocus() : null;
  }

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<Todos>().getTodoById(widget.id);
    final bool canSetReminder =
        todo.reminderDateTime?.isAfter(DateTime.now()) ?? true;

    return DismissibleTile(
      onDismiss: () => TodoActions(context, todo).onDeleteTodo(todo),
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
                  style: Styles(context).getTodoTextStyle(todo.checked),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (enabled) ...[
                    TodoTileActionButton(
                      onPressed: () => onDiscard(todo.task),
                      icon: const Icon(Icons.close),
                    ),
                    const SizedBox(width: 10),
                    TodoTileActionButton(
                      onPressed: canSetReminder
                          ? TodoActions(context, todo).onReminderPressed
                          : null,
                      icon: const Icon(Icons.timer_outlined),
                    ),
                    const SizedBox(width: 10),
                    TodoTileActionButton(
                      onPressed: onChangesSaved,
                      icon: const Icon(Icons.check),
                    )
                  ] else
                    Checkbox(
                      checked: todo.checked,
                      onTap: () => context.read<Todos>().toggleCheck(widget.id),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onFocusChange(bool hasFocus) {
    if (!hasFocus) {
      setState(() => enabled = false);
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    taskController.dispose();
    super.dispose();
  }
}
