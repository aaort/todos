import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const String plainNotificationCategory = 'plainCategory';

const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
final iosSettings = DarwinInitializationSettings(
  onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  notificationCategories: _darwinNotificationCategories,
);

final _darwinNotificationCategories = <DarwinNotificationCategory>[
  DarwinNotificationCategory(
    plainNotificationCategory,
    actions: _darwinNotificationActions,
    options: {DarwinNotificationCategoryOption.hiddenPreviewShowTitle},
  ),
];

final _darwinNotificationActions = <DarwinNotificationAction>[
  DarwinNotificationAction.plain(
    'action_id_1',
    'Mark as completed',
    options: {
      DarwinNotificationActionOption.foreground,
    },
  ),
];

const darwinNotificationDetails = DarwinNotificationDetails(
  categoryIdentifier: plainNotificationCategory,
);

void onDidReceiveLocalNotification(id, title, body, payload) {}

final InitializationSettings initializationSettings = InitializationSettings(
  android: androidSettings,
  iOS: iosSettings,
  // macOS: initializationSettingsDarwin,
  // linux: initializationSettingsLinux,
);

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'reminder_channel',
  'reminding notification',
  description: 'This channel is used for reminding notifications',
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
