import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/extensions.dart' show Stringify;
import 'package:todos/widgets/todo_editor/repeat_button.dart';
import 'package:uuid/uuid.dart';

class Todo {
  String task;
  bool isDone;
  late final String id;
  DateTime? reminder;
  Repeat? repeat;
  late final Timestamp createdAt;

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
    createdAt = Timestamp.now();
  }

  Todo._fromMap({
    required this.task,
    required this.isDone,
    required this.id,
    required this.reminder,
    required this.repeat,
    required this.createdAt,
    this.reminderId,
  }) {
    if (repeat == null && reminder == null) {
      reminderId = null;
    } else if ((reminder != null || repeat != null) && reminderId == null) {
      reminderId = Random().nextInt(1000);
    }
  }

  void toggleIsDone([bool? value]) => isDone = value ?? !isDone;

  void updateReminder(DateTime? newReminder) {
    reminder = newReminder;
    if (reminder == null && repeat == null) {
      reminderId = null;
    }
  }

  Todo copyWith(Map<String, dynamic> todoMap) {
    return Todo._fromMap(
      id: id, // can't be mutated
      reminderId: reminderId, // can't be mutated
      createdAt: createdAt, // can't be mutated
      task: todoMap['task'] ?? task,
      isDone: todoMap['isDone'] ?? isDone,
      reminder: DateTime.tryParse('${todoMap['reminder']}'),
      repeat: todoMap['repeat'] != null
          ? Repeat.values.byName((todoMap['repeat'] as Repeat).toName())
          : null,
    );
  }

  Map<String, dynamic> get asMap => {
        'task': task,
        'isDone': isDone,
        'id': id,
        'reminder': reminder?.toIso8601String(),
        'reminderId': reminderId,
        'repeat': repeat?.toName(),
        'createdAt': createdAt,
      };

  Todo.fromMap(Map todoMap)
      : id = todoMap['id'],
        task = todoMap['task'],
        isDone = todoMap['isDone'],
        reminder = DateTime.tryParse('${todoMap['reminder']}'),
        reminderId = todoMap['reminderId'],
        createdAt = todoMap['createdAt'],
        repeat = todoMap['repeat'] != null
          ? Repeat.values.byName(todoMap['repeat'])
            : null;
}

class TodoState extends StateNotifier<Todo> {
  final Todo todo;
  TodoState(this.todo) : super(todo);

  updateValues(Map<String, dynamic> values) {
    state = state.copyWith(values);
  }
}
