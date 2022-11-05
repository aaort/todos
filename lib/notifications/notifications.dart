import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todos_io.dart';
import 'package:todos/notifications/constants.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // notification payload should be the todo id
  if (notificationResponse.payload != null) {
    TodosIO.toggleCheck(notificationResponse.payload!);
  }
}

class Notifications {
  static final notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    await notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> addTodoReminder(Todo todo) async {
    final scheduleDate = tz.TZDateTime.from(todo.reminderDateTime!, tz.local);

    notifications.zonedSchedule(
      todo.reminderId!,
      'Todo reminder',
      todo.task,
      scheduleDate,
      NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: todo.id,
    );
  }

  static Future<void> removeTodoReminder(int id) async {
    try {
      await notifications.cancel(id);
    } catch (e) {
      throw 'Failed to cancel notification with id: $id, error: $e';
    }
  }

  static Future<void> updateTodoReminder(Todo todo) async {
    try {
      await addTodoReminder(todo);
    } catch (e) {
      throw 'Failed to cancel notification with id: ${todo.id}, error: $e';
    }
  }

  // Used only for debugging
  static Future<void> deleteAllReminders() async {
    await notifications.cancelAll();
  }

  static void showNotification({String? title, String? body}) {
    notifications.show(
      Random().nextInt(100),
      title ?? 'test title',
      body ?? 'test body',
      NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      ),
    );
  }
}
