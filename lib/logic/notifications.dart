import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todos/logic/todo.dart';

// TODO: Customize setup for app needs

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
}

const _androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
const _iosSettings = DarwinInitializationSettings();

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
    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // ...
      },
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
  );

  static Future<void> addTodoReminder(DateTime reminderDate, Todo todo) async {
    tz.initializeTimeZones();

    final scheduleDate = tz.TZDateTime.from(reminderDate, tz.local);

    FlutterLocalNotificationsPlugin().zonedSchedule(
      Random().nextInt(1000),
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
    );
  }
}
