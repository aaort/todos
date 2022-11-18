import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/notifications/constants.dart';

@pragma("vm:entry-point")
Future<void> onActionReceived(ReceivedAction action) async {
  final todoId = action.payload?['todoId'];
  if (todoId == null) return;
  if (action.buttonKeyPressed == notificationActions[completedButtonKey]) {
    final todo = await TodoActions.getTodoById(todoId);
    if (todo == null) return;
    TodoActions(todo).toggleIsDone();
  } else {
    final is5Minutes =
        action.buttonKeyPressed == notificationActions[in5MinutesButtonKey];
    final duration = Duration(minutes: is5Minutes ? 1 : 2);
    // final todo = context?.read<TodoManager>().getTodoById(todoId);
    // if (context != null && todo != null) {
    // TodoActions(context, todo).updateReminder(DateTime.now().add(duration));
    // }
  }
}
