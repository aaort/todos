import 'package:todos/widgets/todo_editor/repeat_button.dart';

extension Stringify on Repeat {
  String toName() => toString().split('.').last;
}

extension Reminder on Duration {
  DateTime toDateTime() => DateTime.now().add(this);
}

extension MinutePrecision on DateTime {
  DateTime toMinutePrecision() {
    return DateTime(
      year,
      month,
      day,
      hour,
      minute,
    );
  }
}

extension Capitalize on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
