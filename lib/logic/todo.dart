import 'package:uuid/uuid.dart';

class Todo {
  String task;
  bool checked;
  late final String id;

  Todo(this.task, [this.checked = false]) {
    id = const Uuid().v4();
  }

  Todo.fromMap({required this.task, required this.checked, required this.id});

  void toggleCheck() {
    checked = !checked;
  }

  Map<String, dynamic> get asMap =>
      {'task': task, 'checked': checked, 'id': id};
}
