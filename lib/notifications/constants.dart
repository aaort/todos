import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final darwinNotificationCategories = <DarwinNotificationCategory>[
  DarwinNotificationCategory(
    'plainCategory',
    actions: <DarwinNotificationAction>[
      DarwinNotificationAction.plain(
        'action_id_1',
        'Mark as completed',
        options: {
          DarwinNotificationActionOption.destructive,
          DarwinNotificationActionOption.foreground,
        },
      ),
    ],
    options: {DarwinNotificationCategoryOption.hiddenPreviewShowTitle},
  ),
];

const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
final iosSettings = DarwinInitializationSettings(
  onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  notificationCategories: darwinNotificationCategories,
);

void onDidReceiveLocalNotification(id, title, body, payload) {}

final InitializationSettings initializationSettings = InitializationSettings(
  android: androidSettings,
  iOS: iosSettings,
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

final androidNotificationDetails = AndroidNotificationDetails(
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

const darwinNotificationDetails = DarwinNotificationDetails(
  categoryIdentifier: 'plainCategory',
);
