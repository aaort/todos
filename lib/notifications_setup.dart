import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
}

// TODO: Customize setup for app needs
const InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsDarwin,
  // macOS: initializationSettingsDarwin,
  // linux: initializationSettingsLinux,
);

const initializationSettingsDarwin =
    DarwinInitializationSettings(requestSoundPermission: false);
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

class NotificationsSetup {
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
