import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:todos/logic/todo.dart';
import 'package:todos/widgets/repeat_option_button.dart';

const _appDirName = 'todos';

dynamic _toEncodable(value) {
  if (value is DateTime) {
    return value.toIso8601String();
  } else if (value is RepeatOption) {
    return value.toString();
  }

  return value;
}

class TodosIO {
  static Future<String> get _getAppDir async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<List<File>> _getTodoFiles() async {
    final dirPath = await _getAppDir;
    final entitiesDir =
        await Directory('$dirPath/$_appDirName').create(recursive: true);

    final entities = await entitiesDir.list().toList();

    return entities.map((entity) {
      return File(entity.path);
    }).toList();
  }

  static Future<File?> _getTodoFileById(String id) async {
    final todoFiles = await _getTodoFiles();
    try {
      for (File file in todoFiles) {
        final path = file.path;
        final filename = file.path
            .substring(path.lastIndexOf('/') + 1, path.lastIndexOf('.'));
        if (filename == id) {
          return file;
        }
      }
      return null;
    } catch (e) {
      throw 'file with a given id was not found: $e';
    }
  }

  static int _sortFilesBySize(File file1, File file2) {
    return file1.lastModifiedSync().compareTo(file2.lastModifiedSync());
  }

  static Future<List<Todo>> getTodos() async {
    final todoFiles = await _getTodoFiles();
    todoFiles.sort(_sortFilesBySize);

    final todos = <Todo>[];
    for (File file in todoFiles) {
      final todoMap = jsonDecode((await file.readAsString())) as Map;
      todos.add(
        Todo.fromMap(
          task: todoMap['task'],
          checked: todoMap['checked'],
          id: todoMap['id'],
          reminderDateTime: DateTime.tryParse('${todoMap['reminderDateTime']}'),
          reminderId: todoMap['reminderId'],
          repeatOption: todoMap['repeatOption'],
        ),
      );
    }

    return todos;
  }

  static Future<void> createTodo(Todo todo) async {
    final dirPath = await _getAppDir;
    final filename = todo.id;
    final file = await File('$dirPath/$_appDirName/$filename.json')
        .create(recursive: true);
    final content = jsonEncode(
      todo.asMap,
      toEncodable: _toEncodable,
    );
    await file.writeAsString(content);
  }

  static Future<void> editTodo(Todo todo) async {
    final file = await _getTodoFileById(todo.id);
    if (file == null) throw 'file with a given id is not found';
    await file.writeAsString(jsonEncode(todo.asMap, toEncodable: _toEncodable));
  }

  static Future<void> toggleCheck(String id, {bool? value}) async {
    // todo with updated check value should be passed here
    final file = await _getTodoFileById(id);
    if (file == null) return;
    final todoMap = jsonDecode((await file.readAsString())) as Map;
    todoMap['checked'] = value ?? !todoMap['checked'];
    await file.writeAsString(jsonEncode(todoMap));
  }

  static Future<void> deleteTodo(String id) async {
    final file = await _getTodoFileById(id);
    await file?.delete();
  }

  static Future<void> deleteAllTodos() async {
    final dirPath = await _getAppDir;
    final todosDir = Directory('$dirPath/$_appDirName');

    todosDir.list().forEach((entity) async {
      await entity.delete();
    });
  }
}
