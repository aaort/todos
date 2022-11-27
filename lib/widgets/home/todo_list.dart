import 'package:flutter/material.dart';
import 'package:todos/logic/models/todo.dart';
import 'package:todos/logic/todo_functions.dart';
import 'package:todos/theme/constants.dart';
import 'package:todos/widgets/common/loading_indicator.dart';
import 'package:todos/widgets/todo_editor/todo_tile.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

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
        stream: TodoFunctions.getTodos(),
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
