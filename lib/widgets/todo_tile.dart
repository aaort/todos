import 'package:flutter/material.dart' hide Checkbox;
import 'package:provider/provider.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/styles.dart';
import 'package:todos/widgets/checkbox.dart';
import 'package:todos/widgets/dismissible.dart';
import 'package:todos/widgets/modal_bottom_sheet.dart';

class TodoTile extends StatelessWidget {
  final String id;

  const TodoTile({super.key, required this.id});

  void onLongPress(BuildContext context) async {
    final todo = context.read<Todos>().getTodoById(id);
    popupModalBottomSheet(context: context, child: AddTodo(initialTodo: todo));
  }

  void toggleCheck(BuildContext context) {
    context.read<Todos>().toggleCheck(id);
  }

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<Todos>().getTodoById(id);

    return DismissibleTile(
      onDismiss: () => TodoActions(context, todo).onDeleteTodo(todo),
      onLongPress: () => onLongPress(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                todo.task * 4,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Styles(context).getTodoTextStyle(todo.checked),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Checkbox(
                checked: todo.checked,
                onTap: () => toggleCheck(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
