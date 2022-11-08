import 'dart:math';

import 'package:todos/widgets/repeat_option_button.dart';
import 'package:uuid/uuid.dart';

class Todo {
  String task;
  bool checked;
  late final String id;
  DateTime? reminderDateTime;
  RepeatOption? repeatOption;

  int? reminderId;

  Todo(
    this.task, {
    this.checked = false,
    this.reminderDateTime,
    this.repeatOption,
  }) {
    id = const Uuid().v4();
    if (reminderDateTime != null) {
      reminderId = Random().nextInt(1000);
    }
  }

  Todo.fromMap({
    required this.task,
    required this.checked,
    required this.id,
    required this.reminderDateTime,
    required this.repeatOption,
    this.reminderId,
  }) {
    if (reminderDateTime != null && reminderId == null) {
      reminderId = Random().nextInt(1000);
    }
  }

  void toggleCheck(bool? value) {
    checked = value ?? !checked;
  }

  void updateReminder(DateTime? newReminderDateTime) {
    reminderDateTime = newReminderDateTime;
    if (reminderDateTime == null) {
      reminderId = null;
    }
  }

  Map<String, dynamic> get asMap => {
        'task': task,
        'checked': checked,
        'id': id,
        'reminderDateTime': reminderDateTime,
        'reminderId': reminderId,
        'repeatOption': repeatOption,
      };
}
