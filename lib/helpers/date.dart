import 'package:date_time_format/date_time_format.dart';

String getReminderText(DateTime dateTime) {
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
