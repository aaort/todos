import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/models/reminder.dart';
import 'package:uuid/uuid.dart';

class Todo {
  late final String id;
  String task;
  bool isDone;
  Reminder? reminder;
  late final Timestamp createdAt;

  Todo({
    required this.task,
    this.isDone = false,
    this.reminder,
  })  : id = const Uuid().v4(),
        createdAt = Timestamp.now();

  // This private constructor SHOULD be used only inside this class methods
  // It makes possible the creation of copied object with same id field
  Todo._custom({
    required this.id,
    required this.task,
    required this.isDone,
    required this.reminder,
    required this.createdAt,
  });

  /// Returns new [Todo] instance with mutated [isDone] field (uses [copyWith] method).
  Todo toggleIsDone([bool? value]) => copyWith({'isDone': value ?? !isDone});

  Todo updateReminder(DateTime? newReminder) {
    return copyWith({
      'reminder': reminder?.copyWith({'dateTime': newReminder})
    });
  }

  /// Creates a new instance of [Todo] class with specified overridden values.
  ///
  /// Should be used carefully because [id], [reminderId] and [createdAt]
  /// fields also can be mutated which might be changed in the future.
  Todo copyWith(Map<String, dynamic> todoMap) {
    return Todo._custom(
      id: todoMap[' id'] ?? id,
      createdAt: todoMap['createdAt'] ?? createdAt,
      task: todoMap['task'] ?? task,
      isDone: todoMap['isDone'] ?? isDone,
      reminder: todoMap['reminder'] ??
          (todoMap.containsKey('reminder') ? null : reminder),
    );
  }

  Map<String, dynamic> get asMap => {
        'task': task,
        'isDone': isDone,
        'id': id,
        'reminder': reminder?.asMap,
        'createdAt': createdAt,
      };

  factory Todo.fromMap(Map todoMap) {
    return Todo._custom(
      id: todoMap['id'],
      task: todoMap['task'],
      isDone: todoMap['isDone'],
      reminder: todoMap['reminder'] != null
          ? Reminder.fromMap(todoMap['reminder'])
          : null,
      createdAt: todoMap['createdAt'],
    );
  }
}

class TodoState extends StateNotifier<Todo> {
  final Todo? todo;
  TodoState([this.todo]) : super(todo ?? Todo(task: ''));

  updateValues(Map<String, dynamic> values) {
    state = state.copyWith(values);
  }

  updateReminder(dynamic reminderValue) {
    if (reminderValue == null) {
      state = state.copyWith({'reminder': null});
      return;
    }
    Reminder? reminder = state.reminder;
    if (reminderValue is DateTime) {
      reminder ??= Reminder.dateTime(dateTime: reminderValue);
    } else {
      reminder ??= Reminder.repeat(repeat: reminderValue);
    }
    state = state.copyWith({'reminder': reminder});
  }
}
