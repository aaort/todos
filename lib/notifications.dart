import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/logic/todo.dart';

const String _notificationChannelKey = 'basic_channel';
const String _notificationGroupKey = 'basic_channel_group';
const String _notificationChannelName = 'Basic notifications';
const String _notificationChannelDescription =
    'Notification channel for basic tests';

const String _appIconDir = 'resource://drawable/res_app_icon';

class Notifications {
  static final notifications = AwesomeNotifications();

  static initialize() async {
    final allowed = await notifications.requestPermissionToSendNotifications();
    if (!allowed) return;
    AwesomeNotifications().initialize(
      _appIconDir,
      [
        NotificationChannel(
          channelGroupKey: _notificationGroupKey,
          channelKey: _notificationChannelKey,
          channelName: _notificationChannelName,
          channelDescription: _notificationChannelDescription,
        )
      ],
      // TODO: remove if not testing anymore
      debug: true,
    );
  }

  static scheduleReminder(Todo todo) {
    if (todo.reminderId == null || todo.reminderDateTime == null) return;
    notifications.createNotification(
      schedule: NotificationCalendar.fromDate(date: todo.reminderDateTime!),
      content: NotificationContent(
        id: todo.reminderId!,
        channelKey: _notificationChannelKey,
        title: todo.task,
        body: todo.task,
      ),
      actionButtons: [
        NotificationActionButton(key: 'COMPLETED', label: 'Mark as completed'),
      ],
    );
  }

  static cancelReminder(int id) {
    notifications.cancel(id);
  }
}
