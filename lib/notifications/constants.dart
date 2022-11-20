import 'package:awesome_notifications/awesome_notifications.dart'
    show NotificationActionButton, ActionType;

const String notificationChannelKey = 'reminder_notifications_key';
const String notificationGroupKey = 'reminding_notifications_group_key';
const String notificationChannelName = 'Reminding notifications';
const String notificationChannelDescription =
    'Notification channel for sending reminders';

const String appIconPath = 'resource://drawable/ic_launcher';

const String completedButtonKey = 'COMPLETED';
const String in5MinutesButtonKey = 'IN_5_MINUTES';
const String in15MinutesButtonKey = 'IN_15_MINUTES';
const String cancelButtonKey = "CANCEL";

const Map<String, String> notificationActions = {
  completedButtonKey: completedButtonKey,
  in5MinutesButtonKey: in5MinutesButtonKey,
  in15MinutesButtonKey: in15MinutesButtonKey,
  cancelButtonKey: cancelButtonKey,
};

final actionButtons = [
  NotificationActionButton(
    key: notificationActions[completedButtonKey]!,
    label: 'Mark as completed',
    actionType: ActionType.SilentAction,
  ),
  NotificationActionButton(
    key: notificationActions[in5MinutesButtonKey]!,
    label: 'Repeat in 5 minutes',
    actionType: ActionType.SilentAction,
  ),
  NotificationActionButton(
    key: notificationActions[in15MinutesButtonKey]!,
    label: 'Repeat in 15 minutes',
    actionType: ActionType.SilentAction,
  ),
  NotificationActionButton(
    key: notificationActions[cancelButtonKey]!,
    label: 'Cancel',
    actionType: ActionType.SilentAction,
  ),
];
