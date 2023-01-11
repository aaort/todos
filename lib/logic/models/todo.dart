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

  // This private constructor SHOULD be used only inside this class methods
  // It makes possible the creation of copied object with same id field
  Todo._custom({
    required this.id,
    required this.task,
    required this.isDone,
    required this.reminder,
    required this.repeat,
    required this.createdAt,
    required this.reminderId,
  });

  /// Returns new [Todo] instance with mutated [isDone] field (uses [copyWith] method).
  Todo toggleIsDone([bool? value]) => copyWith({'isDone': value ?? !isDone});

  void updateReminder(DateTime? newReminder) {
    reminder = newReminder;
    if (reminder == null && repeat == null) {
      reminderId = null;
    }
  }

  /// Creates a new instance of [Todo] class with specified overridden values.
  ///
  /// Should be used carefully because [id], [reminderId] and [createdAt]
  /// fields also can be mutated which might be changed in the future.
  Todo copyWith(Map<String, dynamic> todoMap) {
    // id, createdAt and reminderId values cannot be mutated
    return Todo._custom(
      id: todoMap[' id'] ?? id,
      createdAt: todoMap['createdAt'] ?? createdAt,
      reminderId: todoMap['reminderId'] ?? reminderId,
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
