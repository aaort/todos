import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/logic/todo.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

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
    tz.initializeTimeZones();
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
    // use date and time with local time zone for more precision
    final dateTime = tz.TZDateTime.from(todo.reminderDateTime!, tz.local);
    notifications.createNotification(
      schedule: NotificationCalendar.fromDate(date: dateTime),
      content: NotificationContent(
        id: todo.reminderId!,
        channelKey: _notificationChannelKey,
        title: todo.task,
        body: todo.task,
        category: NotificationCategory.Reminder,
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
