import 'dart:math';

import 'package:uuid/uuid.dart';

class Todo {
  String task;
  bool checked;
  late final String id;
  DateTime? reminderDateTime;

  int? reminderId;

  Todo(this.task, {this.checked = false, this.reminderDateTime}) {
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
    this.reminderId,
  });

  void toggleCheck() {
    checked = !checked;
  }

  void updateReminder(DateTime newReminderDateTime) {
    reminderDateTime = newReminderDateTime;
  }

  Map<String, dynamic> get asMap => {
        'task': task,
        'checked': checked,
        'id': id,
        'reminderDateTime': reminderDateTime,
        'reminderId': reminderId
      };
}
