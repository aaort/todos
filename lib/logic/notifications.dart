import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
}
