import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/helpers/reminder.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/theme/constants.dart';
import 'package:todos/theme/theme_manager.dart';
import 'package:todos/widgets/repeat_option_button.dart';

class SaveTodoButton extends StatelessWidget {
  final Todo? initialTodo;
  final String task;
  final dynamic reminder;
  final RepeatOption? repeatOption;

  const SaveTodoButton({
    super.key,
    this.initialTodo,
    this.repeatOption,
    required this.task,
    required this.reminder,
  });

  Future<void> onTodoSaved(BuildContext context) async {
    if (task.isNotEmpty) {
      DateTime? reminder = this.reminder is Duration
          ? getDateTimeOfDuration(this.reminder)
          : this.reminder;

      final todo =
          Todo(task, reminderDateTime: reminder, repeatOption: repeatOption);
      if (initialTodo != null) {
        TodoActions(context, initialTodo!).updateTodo(todo);
      } else {
        TodoActions(context, todo).createTodo();
      }
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeManager>().isDark;
    return ElevatedButton(
      key: const Key('createTodoButtonId'),
      onPressed: () => onTodoSaved(context),
      child: Text(
        'Save',
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: isDark ? kPrimaryColor : kPrimaryDarkColor),
      ),
    );
  }
}
