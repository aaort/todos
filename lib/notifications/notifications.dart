import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/helpers/reminder.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/notifications/constants.dart';
import 'package:todos/notifications/listeners.dart';

class Notifications {
  static final notifications = AwesomeNotifications();

  static initialize() async {
    final allowed = await notifications.requestPermissionToSendNotifications();
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

    notifications.setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  static scheduleReminder(Todo todo) async {
    if (todo.reminderId == null || todo.reminderDateTime == null) return;
    notifications.createNotification(
      schedule: await getNotificationScheduleFromTodo(todo),
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
      actionButtons: [
        NotificationActionButton(
          key: notificationActions[completedButtonKey]!,
          label: 'Mark as completed',
          actionType: ActionType.SilentAction,
        ),
        NotificationActionButton(
          key: notificationActions[in5MinutesButtonKey]!,
          label: 'Repeat in 5 minutes',
          actionType: ActionType.SilentAction,
        ),
        NotificationActionButton(
          key: notificationActions[in15MinutesButtonKey]!,
          label: 'Repeat in 15 minutes',
          actionType: ActionType.SilentAction,
        ),
      ],
    );
  }

  static updateReminder(Todo todo) async {
    await cancelReminder(todo.reminderId!);
    scheduleReminder(todo);
  }

  static cancelReminder(int id) {
    notifications.cancel(id);
  }
}

Future<NotificationSchedule> getNotificationScheduleFromTodo(Todo todo) async {
  final localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();
  if (todo.repeatOption != null) {
    return NotificationInterval(
      interval: getRepeatOptionSeconds(todo.repeatOption!),
      timeZone: localTimeZone,
      preciseAlarm: true,
      repeats: true,
    );
  }
  return NotificationCalendar.fromDate(date: todo.reminderDateTime!);
}
