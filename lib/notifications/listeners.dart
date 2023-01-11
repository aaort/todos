import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/extensions.dart';
import 'package:todos/logic/services/database.dart';
import 'package:todos/notifications/constants.dart';
import 'package:todos/notifications/notifications.dart';

class NotificationListeners {
  @pragma("vm:entry-point")
  static Future<void> onActionReceived(ReceivedAction action) async {
    if (action.payload?['todoId'] == null) return;
    final todo = await Database.getTodoById(action.payload!['todoId']!);
    if (todo == null || todo.reminderId == null) return;
    if (action.buttonKeyPressed == notificationActions[completedButtonKey]) {
      final toggledTodo = todo.toggleIsDone();
      if (toggledTodo.repeat == null) {
        // if not a repeating reminder, cancel it
        Notifications.cancelReminder(todo.reminderId!);
        Database(toggledTodo.updateReminder(null)).updateTodo();
      }
    } else if (action.buttonKeyPressed !=
        notificationActions[cancelButtonKey]) {
      final is5Minutes =
          action.buttonKeyPressed == notificationActions[in5MinutesButtonKey];
      final updatedReminderTodo = todo.updateReminder(
          Duration(minutes: is5Minutes ? 5 : 15)
              .toDateTime()
              .toMinutePrecision());
      Database(updatedReminderTodo).updateTodo();
      Notifications.updateReminder(updatedReminderTodo);
    } else {
      Notifications.cancelReminder(todo.reminderId!);
    }
  }
}
