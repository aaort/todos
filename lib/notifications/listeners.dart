import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/helpers/reminder.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/notifications/constants.dart';
import 'package:todos/notifications/notifications.dart';

@pragma("vm:entry-point")
Future<void> onActionReceived(ReceivedAction action) async {
  final todoId = action.payload?['todoId'];
  if (todoId == null) return;
  if (action.buttonKeyPressed == notificationActions[completedButtonKey]) {
    final todo = await TodoActions.getTodoById(todoId);
    if (todo == null) return;
    TodoActions(todo).toggleIsDone();
    if (todo.repeat == null && todo.reminderId != null) {
      // if not a repeating reminder, cancel it
      Notifications.cancelReminder(todo.reminderId!);
      todo.updateReminder(null); // drop reminder
      TodoActions(todo).updateTodo();
    }
  } else {
    final is5Minutes =
        action.buttonKeyPressed == notificationActions[in5MinutesButtonKey];
    final todo = await TodoActions.getTodoById(todoId);
    if (todo == null) return;
    final reminder = getDateTimeWithPrecisionToMinutes(
      DateTime.now().add(Duration(minutes: is5Minutes ? 5 : 15)),
    );
    final updatedTodo = todo.copyWith({'reminder': reminder});
    TodoActions(updatedTodo).updateTodo();
    Notifications.updateReminder(updatedTodo);
  }
}
