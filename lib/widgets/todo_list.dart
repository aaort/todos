import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/widgets/todo_tile.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Consumer<Todos>(
          builder: (context, data, _) {
            final todos = data.todos;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 10.0,
              ),
              itemCount: todos.length,
              itemBuilder: (_, index) {
                return TodoTile(id: todos[index].id);
              },
            );
          },
        ),
      ),
    );
  }
}
