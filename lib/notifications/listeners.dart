import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/notifications/utils.dart';
import 'package:todos/services/database.dart';
import 'package:todos/notifications/constants.dart';
import 'package:todos/notifications/notifications.dart';

class NotificationListeners {
  @pragma("vm:entry-point")
  static Future<void> onActionReceived(ReceivedAction action) async {
    if (action.payload?['todoId'] == null) return;

    // Get todo by id and return functions if null or does not have reminderId
    final todo = await Database.getTodoById(action.payload!['todoId']!);
    if (todo == null || todo.reminder?.id == null) return;

    // If todo's marked as completed
    if (action.buttonKeyPressed == notificationActions[completedButtonKey]) {
      await toggleTodo(todo);
      // If not marked as [CANCELED] then todo's rescheduled with either 5 or 15 minutes
    } else if (action.buttonKeyPressed !=
        notificationActions[cancelButtonKey]) {
      await rescheduleReminder(todo: todo, action: action);
    } else {
      Notifications.cancelReminder(todo.reminder!.id);
    }
  }
}
