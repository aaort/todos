import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/styles.dart';
import 'package:todos/widgets/todo_tile.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<Todos>().todos;
    return Expanded(
      child: Container(
        decoration: Styles(context).todoListContainerDecoration,
        child: ListView.builder(
          padding: Styles(context).todoListPadding,
          itemCount: todos.length,
          itemBuilder: (_, index) {
            return TodoTile(id: todos[index].id);
          },
        ),
      ),
    );
  }
}
