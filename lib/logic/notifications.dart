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

const InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsDarwin,
  // macOS: initializationSettingsDarwin,
  // linux: initializationSettingsLinux,
);

const initializationSettingsDarwin =
    DarwinInitializationSettings(requestSoundPermission: true);
const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

const darwinNotificationDetails = DarwinNotificationDetails(badgeNumber: 3);
const androidNotificationDetails = AndroidNotificationDetails(
  'androidNotificationChannelId',
  'androidNotificationChannelName',
);

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

class Notifications {
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // ...
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static final androidNotificationDetails = AndroidNotificationDetails(
    channel.id,
    channel.name,
    channelDescription: channel.description,
    playSound: true,
    icon: '@mipmap/ic_launcher',
  );

  static Future<void> addTodoReminder(DateTime reminderDate, Todo todo) async {
    tz.initializeTimeZones();

    final scheduleDate = tz.TZDateTime.from(reminderDate, tz.local);

    FlutterLocalNotificationsPlugin().zonedSchedule(
      Random().nextInt(1000),
      'Todo reminder',
      todo.task,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      // TODO: provide additional details for notification if required
      NotificationDetails(
        android: androidNotificationDetails,
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}
