import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:todos/widgets/todo_editor/repeat_button.dart';

Future ensureKeyboardIsHidden(BuildContext ctx) async {
  if (MediaQuery.of(ctx).viewInsets.bottom > 0) {
    FocusManager.instance.primaryFocus?.unfocus();
    await Future.delayed(const Duration(milliseconds: 400));
  }
}

String getReminderText(DateTime dateTime) {
  if (dateTime.isBefore(DateTime.now())) {
    // TODO: need to be removed, passed reminders should be deleted on todo
    return 'Completed';
  }
  return 'Remind me in ${dateTime.relative()}';
}

DateTime getInitialDateTime(DateTime? initialDateTime) {
  final now = DateTime.now();
  if (initialDateTime != null && initialDateTime.isAfter(now)) {
    return getDateTimeWithPrecisionToMinutes(initialDateTime);
  }
  return getDateTimeWithPrecisionToMinutes(now.add(const Duration(minutes: 1)));
}

DateTime getMinimumDateTime() {
  return getDateTimeWithPrecisionToMinutes(
    DateTime.now().add(const Duration(minutes: 1)),
  );
}

DateTime getDateTimeWithPrecisionToMinutes(DateTime dateTime) {
  return DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day,
    dateTime.hour,
    dateTime.minute,
  );
}

int getRepeatOptionSeconds(Repeat repeatOption) {
  switch (repeatOption) {
    case Repeat.hourly:
      return 60 * 60;
    case Repeat.daily:
      return (24 * 60) * 60;
    case Repeat.weekly:
      return ((7 * 24) * 60) * 60;
  }
}
