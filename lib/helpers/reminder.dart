import 'package:date_time_format/date_time_format.dart';
import 'package:todos/widgets/repeat_option_button.dart';

String getReminderText(DateTime dateTime) {
  if (dateTime.isBefore(DateTime.now())) {
    return 'Completed';
  }
  return 'Remind me in ${dateTime.relative()}';
}

DateTime getDateTimeOfDuration(Duration duration) {
  return DateTime.now().add(duration);
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

int getRepeatOptionSeconds(RepeatOption repeatOption) {
  switch (repeatOption) {
    case RepeatOption.hourly:
      return 60 * 60;
    case RepeatOption.daily:
      return (24 * 60) * 60;
    case RepeatOption.weekly:
      return ((7 * 24) * 60) * 60;
  }
}
