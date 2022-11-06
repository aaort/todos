import 'package:flutter/material.dart' hide Checkbox;
import 'package:provider/provider.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/logic/todos_io.dart';
import 'package:todos/notifications/notifications.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/styles.dart';
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

  void toggleCheck(BuildContext context) {
    context.read<Todos>().toggleCheckById(id);
    TodosIO.toggleCheck(id);
    final todo = context.read<Todos>().getTodoById(id);
    if (todo.reminderId == null) return;
    if (todo.checked) {
      Notifications.removeTodoReminder(todo.reminderId!);
    } else {
      if (todo.reminderDateTime!.isAfter(DateTime.now())) {
        Notifications.addTodoReminder(todo);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<Todos>().getTodoById(id);

    return DismissibleTile(
      onDismiss: () => TodoActions(context, todo).onDeleteTodo(todo),
      onLongPress: () => onLongPress(context),
      child: CheckboxListTile(
        title: Text(
          todo.task,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Styles(context).getTodoTextStyle(todo.checked),
        ),
        contentPadding: EdgeInsets.zero,
        value: todo.checked,
        onChanged: (value) => toggleCheck(context),
        checkColor: Colors.white,
        activeColor: Colors.blueGrey,
        side: const BorderSide(color: Colors.blueGrey, width: 1),
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
