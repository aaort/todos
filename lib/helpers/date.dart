String getReminderText(DateTime dateTime) {
  final diff = dateTime.difference(DateTime.now());
  if (diff.isNegative) {
    return 'Reminded';
  } else if (diff.inMinutes < 60) {
    return 'Remind me in ${(diff.inSeconds / 60).round()} minutes';
  } else if (diff.inHours < 24) {
    return 'Remind me today at ${dateTime.hour.toString().padLeft(2, '0')}'
        ':${dateTime.minute.toString().padLeft(2, '0')}';
  } else {
    return 'Remind me in ${diff.inDays} day${diff.inDays > 1 ? 's' : ''}';
  }
}

DateTime getDateTimeOfDuration(Duration duration) {
  return DateTime.now().add(duration);
}
