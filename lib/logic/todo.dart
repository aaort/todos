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

  Todo.fromMap({
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

  void toggleCheck(bool? value) {
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
        'checked': isDone,
        'id': id,
        'reminderDateTime': reminder?.toIso8601String(),
        'reminderId': reminderId,
        'repeatOption': repeat?.asString,
      };

  static Todo getTodoFromMap(Map todoMap) {
    dynamic repeatOption = _getRepeatOptionFromString(todoMap['repeatOption']);
    return Todo.fromMap(
      task: todoMap['task'],
      isDone: todoMap['checked'],
      id: todoMap['id'],
      reminderId: todoMap['reminderId'],
      reminder: DateTime.tryParse('${todoMap['reminderDateTime']}'),
      repeat: repeatOption,
    );
  }

  static RepeatOption? _getRepeatOptionFromString(String? optionAsString) {
    if (optionAsString == null) return null;
    try {
      return RepeatOption.values
          .firstWhere((option) => option.toString() == optionAsString);
    } catch (_) {
      throw 'Unable to found repeat option to match $optionAsString';
    }
  }
}
