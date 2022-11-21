import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/helpers.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/notifications/constants.dart';
import 'package:todos/notifications/notifications.dart';

@pragma("vm:entry-point")
Future<void> onActionReceived(ReceivedAction action) async {
  if (action.payload?['todoId'] == null) return;
  final todo = await TodoActions.getTodoById(action.payload!['todoId']!);
  if (todo == null || todo.reminderId == null) return;
  if (action.buttonKeyPressed == notificationActions[completedButtonKey]) {
    TodoActions(todo).toggleIsDone();
    if (todo.repeat == null) {
      // if not a repeating reminder, cancel it
      Notifications.cancelReminder(todo.reminderId!);
      todo.updateReminder(null); // drop reminder
      TodoActions(todo).updateTodo();
    }
  } else if (action.buttonKeyPressed != notificationActions[cancelButtonKey]) {
    final is5Minutes =
        action.buttonKeyPressed == notificationActions[in5MinutesButtonKey];
    final reminder = getDateTimeWithPrecisionToMinutes(
      DateTime.now().add(Duration(minutes: is5Minutes ? 5 : 15)),
    );
    final updatedTodo = todo.copyWith({'reminder': reminder});
    TodoActions(updatedTodo).updateTodo();
    Notifications.updateReminder(updatedTodo);
  } else {
    Notifications.cancelReminder(todo.reminderId!);
  }
}
