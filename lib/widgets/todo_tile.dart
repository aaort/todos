import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/theme/theme.dart' show CustomTextStyles;
import 'package:todos/widgets/dismissible.dart';
import 'package:todos/widgets/modal_bottom_sheet.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  const TodoTile({super.key, required this.todo});

  // void onLongPress(BuildContext context) async {
  //   final todo = context.read<TodoManager>().getTodoById(id);
  //   popupModalBottomSheet(
  //     context: context,
  //     child: TodoEditor(initialTodo: todo),
  //   );
  // }

  // onTap(BuildContext context) {
  //   final todo = context.read<TodoManager>().getTodoById(id);
  //   TodoActions(context, todo).toggleCheck();
  // }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DismissibleTile(
      onDismiss: () {},
      onLongPress: () {},
      child: CheckboxListTile(
        title: Text(
          todo.task,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: todo.isDone ? textTheme.lineThrough : textTheme.bodySmall,
        ),
        value: false,
        onChanged: (_) => {},
      ),
    );
  }
}
