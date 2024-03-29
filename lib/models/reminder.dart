import 'dart:math';

import 'package:flutter/foundation.dart' show immutable;
import 'package:todos/widgets/todo_editor/repeat_button.dart' show Repeat;
import 'package:todos/extensions.dart' show RepeatName;

@immutable
class Reminder {
  /// Reminder id which should be of type int to be used as notification id
  final int id;

  /// Will have value only if [type == ReminderType.once] && [repeat == null]
  /// Represent the duration exact date and time at which this reminder should appear
  final DateTime? dateTime;

  /// Will have value only if [type == ReminderType.repeat] && [time == null]
  /// Represents the time interval it should be repeated by
  final Repeat? repeat;

  Reminder.dateTime({required this.dateTime})
      : id = randomId(),
        repeat = null,
        assert(dateTime != null);

  Reminder.repeat({required this.repeat})
      : id = randomId(),
        dateTime = null,
        assert(repeat != null);

  const Reminder._custom({
    required this.id,
    required this.dateTime,
    required this.repeat,
  }) : assert(!(repeat == null && dateTime == null));

  factory Reminder.fromMap(Map<String, dynamic> values) {
    return Reminder._custom(
      id: values['id'],
      dateTime: DateTime.tryParse('${values['dateTime']}'),
      repeat: Repeat.values
          .firstWhere((value) => value.toName() == values['repeat']),
    );
  }

  Reminder copyWith(Map<String, dynamic> values) {
    return Reminder._custom(
      id: id,
      dateTime: values['dateTime'],
      repeat: values['repeat'],
    );
  }

  Map<String, dynamic> get asMap => {
        'id': id,
        'dateTime': dateTime?.toIso8601String(),
        'repeat': repeat?.toName()
      };
}

randomId() => Random().nextInt(999999);
