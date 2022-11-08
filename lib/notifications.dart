import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/helpers/reminder.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todos_io.dart';

const String _notificationChannelKey = 'reminder_notifications_key';
const String _notificationGroupKey = 'reminding_notifications_group_key';
const String _notificationChannelName = 'Reminding notifications';
const String _notificationChannelDescription =
    'Notification channel for sending reminders';

const String _appIconPath = 'resource://drawable/ic_launcher';

class Notifications {
  static final notifications = AwesomeNotifications();

  static initialize() async {
    final allowed = await notifications.requestPermissionToSendNotifications();
    if (!allowed) return;
    AwesomeNotifications().initialize(
      _appIconPath,
      [
        NotificationChannel(
          channelGroupKey: _notificationGroupKey,
          channelKey: _notificationChannelKey,
          channelName: _notificationChannelName,
          channelDescription: _notificationChannelDescription,
          criticalAlerts: true,
        )
      ],
      // TODO: remove if not testing anymore
      debug: true,
    );

    notifications.setListeners(onActionReceivedMethod: _onActionReceivedMethod);
  }

  static Future<void> _onActionReceivedMethod(ReceivedAction action) async {
    if (action.payload?['todoId'] != null) {
      TodosIO.toggleCheck(action.payload!['todoId']!, value: true);
    }
  }

  static scheduleReminder(Todo todo) async {
    if (todo.reminderId == null || todo.reminderDateTime == null) return;
    notifications.createNotification(
      schedule: await getNotificationScheduleFromTodo(todo),
      content: NotificationContent(
        id: todo.reminderId!,
        channelKey: _notificationChannelKey,
        title: todo.task,
        body: todo.task,
        payload: {'todoId': todo.id},
        wakeUpScreen: true,
        criticalAlert: true,
        actionType: ActionType.DisabledAction,
        category: NotificationCategory.Reminder,
      ),
      actionButtons: [
        NotificationActionButton(key: 'COMPLETED', label: 'Mark as completed'),
      ],
    );
  }

  static updateReminder(Todo todo) async {
    await notifications.cancel(todo.reminderId!);
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
  } else {
    return NotificationCalendar.fromDate(date: todo.reminderDateTime!);
  }
}
