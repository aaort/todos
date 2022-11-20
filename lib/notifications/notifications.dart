import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/helpers/reminder.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/notifications/constants.dart';
import 'package:todos/notifications/listeners.dart';

class Notifications {
  static final _notifications = AwesomeNotifications();

  static initialize() async {
    final allowed = await _notifications.requestPermissionToSendNotifications();
    if (!allowed) return;
    AwesomeNotifications().initialize(
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
      onActionReceivedMethod: onActionReceived,
    );
  }

  static scheduleReminder(Todo todo) async {
    if (todo.reminderId == null) return;
    _notifications.createNotification(
      schedule: await _getNotificationScheduleFromTodo(todo),
      content: NotificationContent(
        id: todo.reminderId!,
        channelKey: notificationChannelKey,
        title: todo.task,
        body: todo.task,
        payload: {'todoId': todo.id},
        wakeUpScreen: true,
        criticalAlert: true,
        category: NotificationCategory.Reminder,
      ),
      actionButtons: actionButtons,
    );
  }

  static updateReminder(Todo todo) async {
    await cancelReminder(todo.reminderId!);
    scheduleReminder(todo);
  }

  static cancelReminder(int id) {
    _notifications.cancel(id);
  }
}

Future<NotificationSchedule> _getNotificationScheduleFromTodo(Todo todo) async {
  final localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();
  if (todo.repeat != null) {
    return NotificationInterval(
      interval: getRepeatOptionSeconds(todo.repeat!),
      timeZone: localTimeZone,
      preciseAlarm: true,
      repeats: true,
    );
  }
  return NotificationCalendar.fromDate(date: todo.reminder!);
}
