import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/extensions.dart' show Capitalize;

enum TodosFilter { all, completed, uncompleted }

final todosFilterProvider =
    StateProvider<TodosFilter>((ref) => TodosFilter.all);

class TodosFilterButton extends ConsumerWidget {
  const TodosFilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton<TodosFilter>(
      value: ref.watch(todosFilterProvider),
      items: TodosFilter.values
          .map(
            (filter) => DropdownMenuItem<TodosFilter>(
              value: filter,
              child: Text(filter.toString().split('.').last.capitalize()),
            ),
          )
          .toList(),
      onChanged: (value) {
        ref.read(todosFilterProvider.notifier).state = value ?? TodosFilter.all;
      },
    );
  }
}
