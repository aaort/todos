import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/theme/theme.dart' show CustomTextStyles;
import 'package:todos/widgets/dismissible.dart';
import 'package:todos/widgets/modal_bottom_sheet.dart';

class TodoTile extends StatelessWidget {
  final String id;

  const TodoTile({super.key, required this.id});

  void onLongPress(BuildContext context) async {
    final todo = context.read<Todos>().getTodoById(id);
    popupModalBottomSheet(
      context: context,
      child: TodoEditor(initialTodo: todo),
    );
  }

  onTap(BuildContext context) {
    final todo = context.read<Todos>().getTodoById(id);
    TodoActions(context, todo).toggleCheck();
  }

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<Todos>().getTodoById(id);
    final textTheme = Theme.of(context).textTheme;

    return DismissibleTile(
      onDismiss: TodoActions(context, todo).deleteTodo,
      onLongPress: !todo.checked ? () => onLongPress(context) : () {},
      child: CheckboxListTile(
        title: Text(
          todo.task,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: todo.checked ? textTheme.lineThrough : textTheme.bodySmall,
        ),
        value: todo.checked,
        onChanged: (_) => onTap(context),
      ),
    );
  }
}
