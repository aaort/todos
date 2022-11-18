import 'dart:math';

import 'package:todos/widgets/repeat_option_button.dart';
import 'package:uuid/uuid.dart';

class Todo {
  String task;
  bool isDone;
  late final String id;
  DateTime? reminder;
  RepeatOption? repeat;

  int? reminderId;

  Todo(
    this.task, {
    this.isDone = false,
    this.reminder,
    this.repeat,
  }) {
    id = const Uuid().v4();
    if (reminder != null || repeat != null) {
      reminderId = Random().nextInt(1000);
    }
  }

  Todo._fromMap({
    required this.task,
    required this.isDone,
    required this.id,
    required this.reminder,
    required this.repeat,
    this.reminderId,
  }) {
    if (reminder != null && reminderId == null) {
      reminderId = Random().nextInt(1000);
    }
  }

  void toggleIsDone({bool? value}) {
    isDone = value ?? !isDone;
  }

  void updateReminder(DateTime? newReminderDateTime) {
    reminder = newReminderDateTime;
    if (reminder == null) {
      reminderId = null;
      repeat = null;
    }
  }

  Map<String, dynamic> get asMap => {
        'task': task,
        'isDone': isDone,
        'id': id,
        'reminderDateTime': reminder?.toIso8601String(),
        'reminderId': reminderId,
        'repeatOption': repeat?.asString,
      };

  static Todo fromMap(Map todoMap) {
    dynamic repeat = _getRepeatOptionFromString(todoMap['repeatOption']);
    return Todo._fromMap(
      task: todoMap['task'],
      isDone: todoMap['isDone'],
      id: todoMap['id'],
      reminderId: todoMap['reminderId'],
      reminder: DateTime.tryParse('${todoMap['reminderDateTime']}'),
      repeat: repeat,
    );
  }

  Todo updateValues(Map<String, dynamic> todoMap) {
    return Todo._fromMap(
      id: id, // can't be mutated
      reminderId: reminderId, // can't be mutated
      task: todoMap['task'],
      isDone: todoMap['isDone'],
      reminder: todoMap['reminder'],
      repeat: todoMap['repeat'],
    );
  }

  static RepeatOption? _getRepeatOptionFromString(String? optionAsString) {
    if (optionAsString == null) return null;
    try {
      return RepeatOption.values.firstWhere(
          (option) => option.toString().split('.').last == optionAsString);
    } catch (_) {
      throw 'Unable to found repeat option to match $optionAsString';
    }
  }
}
