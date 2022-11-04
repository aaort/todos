import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todos_io.dart';

// TODO: Customize setup for app needs

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // notification payload should be the todo id
  if (notificationResponse.payload != null) {
    TodosIO.toggleCheck(notificationResponse.payload!);
  }
}

const _androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
const _iosSettings = DarwinInitializationSettings(
  onDidReceiveLocalNotification: onDidReceiveLocalNotification,
);

void onDidReceiveLocalNotification(id, title, body, payload) {}

const InitializationSettings initializationSettings = InitializationSettings(
  android: _androidSettings,
  iOS: _iosSettings,
  // macOS: initializationSettingsDarwin,
  // linux: initializationSettingsLinux,
);

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'reminder_channel', // id
  'reminding notification', // title
  description:
      'This channel is used for reminding notifications', // description
  importance: Importance.high,
  playSound: true,
);

class Notifications {
  static final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static final _androidNotificationDetails = AndroidNotificationDetails(
    channel.id,
    channel.name,
    actions: <AndroidNotificationAction>[
      const AndroidNotificationAction(
        'mark_completed_id',
        'Mark as completed',
        cancelNotification: true,
      ),
    ],
  );

  static Future<void> addTodoReminder(Todo todo) async {
    final scheduleDate = tz.TZDateTime.from(todo.reminderDateTime!, tz.local);

    FlutterLocalNotificationsPlugin().zonedSchedule(
      todo.reminderId!,
      'Todo reminder',
      todo.task,
      scheduleDate,
      // TODO: provide additional details for notification if required
      NotificationDetails(
        android: _androidNotificationDetails,
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: todo.id,
    );
  }

  static Future<void> removeTodoReminder(int id) async {
    try {
      await FlutterLocalNotificationsPlugin().cancel(id);
    } catch (e) {
      throw 'Failed to cancel notification with id: $id, error: $e';
    }
  }

  static Future<void> updateTodoReminder(Todo todo) async {
    try {
      await FlutterLocalNotificationsPlugin().cancel(todo.reminderId!);
      addTodoReminder(todo);
    } catch (e) {
      throw 'Failed to cancel notification with id: ${todo.id}, error: $e';
    }
  }

  // Used only for debugging
  static Future<void> deleteAllReminders() async {
    await FlutterLocalNotificationsPlugin().cancelAll();
  }
}
