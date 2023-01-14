import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/extensions.dart' show Stringify;
import 'package:todos/widgets/todo_editor/repeat_button.dart';
import 'package:uuid/uuid.dart';

const _maxReminderIdValue = 999999;

class Todo {
  late final String id;
  String task;
  bool isDone;
  DateTime? reminder;
  Repeat? repeat;
  int? reminderId;
  late final Timestamp createdAt;

  Todo({
    required this.task,
    this.isDone = false,
    this.reminder,
    this.repeat,
  })  : id = const Uuid().v4(),
        createdAt = Timestamp.now() {
    if (reminder != null || repeat != null) {
      reminderId = Random().nextInt(_maxReminderIdValue);
    }
  }

  // This private constructor SHOULD be used only inside this class methods
  // It makes possible the creation of copied object with same id field
  Todo._custom({
    required this.id,
    required this.task,
    required this.isDone,
    required this.reminder,
    required this.repeat,
    required this.reminderId,
    required this.createdAt,
  });

  /// Returns new [Todo] instance with mutated [isDone] field (uses [copyWith] method).
  Todo toggleIsDone([bool? value]) => copyWith({'isDone': value ?? !isDone});

  Todo updateReminder(DateTime? newReminder) {
    final stillHasReminder = (newReminder != null && repeat != null);
    // Set reminderId to null if both repeat and newReminder are null
    return copyWith(
        {'reminder': reminder, if (!stillHasReminder) 'reminderId': null});
  }

  /// Creates a new instance of [Todo] class with specified overridden values.
  ///
  /// Should be used carefully because [id], [reminderId] and [createdAt]
  /// fields also can be mutated which might be changed in the future.
  Todo copyWith(Map<String, dynamic> todoMap) {
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

  factory Todo.fromMap(Map todoMap) {
    return Todo._custom(
        id: todoMap['id'],
        task: todoMap['task'],
        isDone: todoMap['isDone'],
        reminder: DateTime.tryParse('${todoMap['reminder']}'),
        reminderId: todoMap['reminderId'],
        createdAt: todoMap['createdAt'],
        repeat: todoMap['repeat'] != null
            ? Repeat.values.byName(todoMap['repeat'])
            : null);
  }
}

class TodoState extends StateNotifier<Todo> {
  final Todo todo;
  TodoState(this.todo) : super(todo);
  updateValues(Map<String, dynamic> values) {
    final stateObj = {
      ...values,
      // [reminder] and [repeat] will not be updated unless explicit value given
      // in a [values] map
      if (!values.containsKey('reminder')) 'reminder': state.reminder,
      if (!values.containsKey('repeat')) 'repeat': state.repeat,
      'reminderId': state.reminderId,
    };
    // If both [reminder] and [repeat] are null, set [reminderId] to null
    if (stateObj['reminder'] == null && stateObj['repeat'] == null) {
      stateObj['reminderId'] = null;
      // If either [reminder] or [repeat] have value but [reminderId] is null, give reminderId a value
    } else if (stateObj['reminderId'] == null) {
      stateObj['reminderId'] = Random().nextInt(_maxReminderIdValue);
    }
    state = state.copyWith(stateObj);
  }
}
