import 'package:flutter/material.dart';
import 'package:todos/logic/models/todo.dart';
import 'package:todos/logic/services/database.dart';
import 'package:todos/theme/constants.dart';
import 'package:todos/widgets/common/loading_indicator.dart';
import 'package:todos/widgets/todo_editor/todo_tile.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late Stream<List<Todo>> _todos;

  @override
  void initState() {
    _todos = Database.getTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(kModalBorderRadius),
        ),
      ),
      child: StreamBuilder<List<Todo>>(
        stream: _todos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          final todos = snapshot.data;
          if (todos == null) return const SizedBox();
          return ListView.builder(
            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
            itemCount: todos.length,
            itemBuilder: (_, index) {
              return TodoTile(todo: todos[index]);
            },
          );
        },
      ),
    );
  }
}
