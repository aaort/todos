import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/extensions.dart' show MinutePrecision;
import 'package:todos/logic/todo_functions.dart';
import 'package:todos/notifications/constants.dart';
import 'package:todos/notifications/notifications.dart';

@pragma("vm:entry-point")
Future<void> onActionReceived(ReceivedAction action) async {
  if (action.payload?['todoId'] == null) return;
  final todo = await TodoFunctions.getTodoById(action.payload!['todoId']!);
  if (todo == null || todo.reminderId == null) return;
  if (action.buttonKeyPressed == notificationActions[completedButtonKey]) {
    TodoFunctions(todo).toggleIsDone();
    if (todo.repeat == null) {
      // if not a repeating reminder, cancel it
      Notifications.cancelReminder(todo.reminderId!);
      todo.updateReminder(null); // drop reminder
      TodoFunctions(todo).updateTodo();
    }
  } else if (action.buttonKeyPressed != notificationActions[cancelButtonKey]) {
    final is5Minutes =
        action.buttonKeyPressed == notificationActions[in5MinutesButtonKey];
    final reminder = DateTime.now()
        .add(Duration(minutes: is5Minutes ? 5 : 15))
        .toMinutePrecision();
    final updatedTodo = todo.copyWith({'reminder': reminder});
    TodoFunctions(updatedTodo).updateTodo();
    Notifications.updateReminder(updatedTodo);
  } else {
    Notifications.cancelReminder(todo.reminderId!);
  }
}
