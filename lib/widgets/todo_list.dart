import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todos/logic/db_actions.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/theme/constants.dart';
import 'package:todos/widgets/todo_tile.dart';

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
      child: StreamBuilder<QuerySnapshot<Map>>(
        stream: DbActions.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final todos =
              snapshot.data?.docs.map((snapshot) => snapshot.data()).toList();
          if (todos == null) return const SizedBox();
          return ListView.builder(
            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
            itemCount: todos.length,
            itemBuilder: (_, index) {
              final todo = Todo.getTodoFromMap(todos[index]);
              return TodoTile(todo: todo);
            },
          );
        },
      ),
    );
  }
}
