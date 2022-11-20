import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todos/logic/todo.dart';
import 'package:todos/logic/todo_actions.dart';
import 'package:todos/theme/constants.dart';
import 'package:todos/widgets/loading_indicator.dart';
import 'package:todos/widgets/todo_editor/todo_tile.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late Stream<QuerySnapshot<Map>> _todoSnaps;

  @override
  void initState() {
    _todoSnaps = TodoActions.getTodos();
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
      child: StreamBuilder<QuerySnapshot<Map>>(
        stream: _todoSnaps,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          final todos =
              snapshot.data?.docs.map((snapshot) => snapshot.data()).toList();
          if (todos == null) return const SizedBox();
          return ListView.builder(
            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
            itemCount: todos.length,
            itemBuilder: (_, index) {
              return TodoTile(todo: Todo.fromMap(todos[index]));
            },
          );
        },
      ),
    );
  }
}
