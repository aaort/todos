import 'package:awesome_notifications/awesome_notifications.dart'
    show ReceivedAction;
import 'package:todos/extensions.dart' show Reminder, MinutePrecision;
import 'package:todos/models/todo.dart' show Todo;
import 'package:todos/notifications/notifications.dart';
import 'package:todos/notifications/constants.dart'
    show in5MinutesButtonKey, notificationActions;
import 'package:todos/services/database.dart';

// Those methods supposed to be used only inside ./listeners.dart file so far

toggleTodo(Todo todo) async {
  final toggledTodo = todo.toggleIsDone();
  if (toggledTodo.repeat == null) {
    // if not a repeating reminder, cancel it
    Notifications.cancelReminder(todo.reminderId!);
    Database(toggledTodo.updateReminder(null)).updateTodo();
  }
}

rescheduleReminder({required Todo todo, required ReceivedAction action}) async {
  final is5Minutes =
      action.buttonKeyPressed == notificationActions[in5MinutesButtonKey];
  final updatedReminderTodo = todo.updateReminder(
      Duration(minutes: is5Minutes ? 5 : 15).toDateTime().toMinutePrecision());
  Database(updatedReminderTodo).updateTodo();
  Notifications.updateReminder(updatedReminderTodo);
}
