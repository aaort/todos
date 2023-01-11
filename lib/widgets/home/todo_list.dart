import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/services/database.dart';
import 'package:todos/theme/constants.dart';
import 'package:todos/widgets/todo_editor/todo_tile.dart';

final todosProvider = StreamProvider<List<Todo>>((ref) => Database.todos);

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(kModalBorderRadius),
        ),
      ),
      child: todos.when(
        error: (_, __) => const Center(child: Text('Something went wrong')),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (todos) {
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
