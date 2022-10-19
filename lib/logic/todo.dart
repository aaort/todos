import 'dart:math';

import 'package:uuid/uuid.dart';

class Todo {
  String task;
  bool checked;
  late final String id;
  bool? scheduled;

  int? reminderId;

  Todo(this.task, {this.checked = false, this.scheduled = false}) {
    id = const Uuid().v4();
    if (scheduled!) {
      reminderId = Random().nextInt(1000);
    }
  }

  Todo.fromMap({
    required this.task,
    required this.checked,
    required this.id,
    this.reminderId,
  });

  void toggleCheck() {
    checked = !checked;
  }

  Map<String, dynamic> get asMap =>
      {'task': task, 'checked': checked, 'id': id, 'reminderId': reminderId};
}
