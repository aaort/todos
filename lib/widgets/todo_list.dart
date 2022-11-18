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
      child: FutureBuilder<QuerySnapshot<Map>>(
        future: DbActions.getTodos(),
        builder: (context, snapshot) {
          final todoMap = snapshot.data?.docs.first.data();
          if (todoMap == null) return const SizedBox();
          final todo = Todo.getTodoFromMap(todoMap);
          return ListView.builder(
            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (_, index) => TodoTile(todo: todo),
          );
        },
      ),
    );
  }
}
