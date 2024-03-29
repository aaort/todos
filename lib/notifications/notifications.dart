import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/helpers.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/services/database.dart';
import 'package:todos/notifications/constants.dart';
import 'package:todos/notifications/listeners.dart';

class Notifications {
  static final _notifications = AwesomeNotifications();

  static initialize() async {
    final allowed = await _notifications.requestPermissionToSendNotifications();
    if (!allowed) return;
    _notifications.initialize(
      appIconPath,
      [
        NotificationChannel(
          channelGroupKey: notificationGroupKey,
          channelKey: notificationChannelKey,
          channelName: notificationChannelName,
          channelDescription: notificationChannelDescription,
          criticalAlerts: true,
          importance: NotificationImportance.High,
        )
      ],
      // TODO: remove if not testing anymore
      debug: true,
    );

    _notifications.setListeners(
      onActionReceivedMethod: NotificationListeners.onActionReceived,
    );
  }

  static scheduleReminder(Todo todo) async {
    if (todo.reminder?.id == null) return;
    _notifications.createNotification(
      schedule: await _getNotificationScheduleFromTodo(todo),
      content: NotificationContent(
        id: todo.reminder!.id,
        channelKey: notificationChannelKey,
        title: todo.task,
        body: todo.task,
        payload: {'todoId': todo.id},
        wakeUpScreen: true,
        criticalAlert: true,
        category: NotificationCategory.Reminder,
      ),
      // if repeats, cancel will appear, otherwise repeat in 5/15 minutes buttons
      actionButtons: todo.reminder?.repeat == null
          ? actionButtons.sublist(0, 3)
          : [actionButtons[0], actionButtons[3]],
    );

    final todos = await Database.getTodosOnce();
    final notifications = await _notifications.listScheduledNotifications();
    for (Todo todo in todos) {
      final reminderId = todo.reminder?.id;
      if (reminderId == null) continue;
      for (var i = 0; i < notifications.length; i++) {
        if (notifications[i].content?.id == reminderId) return;
        if (i + 1 == notifications.length) {
          scheduleReminder(todo);
        }
      }
    }
  }

  static updateReminder(Todo todo) async {
    await cancelReminder(todo.reminder!.id);
    scheduleReminder(todo);
  }

  static cancelReminder(int id) async {
    await _notifications.cancel(id);
  }

  // TODO: used for development, delete later
  static cancelAllReminders() async {
    await _notifications.cancelAll();
  }
}

Future<NotificationSchedule> _getNotificationScheduleFromTodo(Todo todo) async {
  final localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();
  if (todo.reminder?.repeat != null) {
    return NotificationInterval(
      interval: getRepeatOptionSeconds(todo.reminder!.repeat!),
      timeZone: localTimeZone,
      preciseAlarm: true,
      repeats: true,
    );
  }
  return NotificationCalendar.fromDate(date: todo.reminder!.dateTime!);
}
