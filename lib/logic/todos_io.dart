import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:todos/logic/todo.dart';

const appDirName = 'todos';

class TodosIO {
  static Future<String> getAppDir() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<List<File>> _getTodoFiles() async {
    final dirPath = await getAppDir();
    final entitiesDir =
        await Directory('$dirPath/$appDirName').create(recursive: true);

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
        final filename =
            file.path.substring(path.lastIndexOf('/') + 1, path.indexOf('.'));
        if (filename == id) {
          return file;
        }
      }
      return null;
    } catch (e) {
      throw 'file with a given id was not found: $e';
    }
  }

  static Future<List<Todo>> getTodos() async {
    final todoFiles = await _getTodoFiles();

    final todos = <Todo>[];
    for (File file in todoFiles) {
      final todoMap = jsonDecode((await file.readAsString())) as Map;
      todos.add(
        Todo.fromMap(
          task: todoMap['task'],
          checked: todoMap['checked'],
          id: todoMap['id'],
        ),
      );
    }

    return todos;
  }

  static Future<void> createTodo(Todo todo) async {
    final dirPath = await getAppDir();
    final filename = todo.id;
    final todoAsJson = jsonEncode(todo.asMap);
    final file = await File('$dirPath/$appDirName/$filename.json')
        .create(recursive: true);
    await file.writeAsString(todoAsJson);
  }

  static Future<void> editTodo({required String id, required Todo todo}) async {
    final file = await _getTodoFileById(id);
    await file?.writeAsString(jsonEncode(todo.asMap));
  }

  static Future<void> deleteTodo(String id) async {
    final file = await _getTodoFileById(id);
    await file?.delete();
  }

  static Future<void> deleteAllTodos() async {
    final dirPath = await getAppDir();
    final todosDir = Directory('$dirPath/$appDirName');

    todosDir.list().forEach((entity) async {
      await entity.delete();
    });
  }
}
