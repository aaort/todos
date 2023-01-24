import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/extensions.dart' show Capitalize;
import 'package:todos/theme/constants.dart';

enum TodosFilter { all, completed, uncompleted }

final todosFilterProvider =
    StateProvider<TodosFilter>((ref) => TodosFilter.all);

class TodosFilterButton extends ConsumerWidget {
  const TodosFilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      color: Colors.white,
      onPressed: () async {
        final filter = await showDialog<TodosFilter>(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kModalBorderRadius),
              ),
              title: Text(
                'Show...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: TodosFilter.values
                    .map((filter) => _FilterTile(filter))
                    .toList(),
              ),
            );
          },
        );
        if (filter == null) return;
        ref.read(todosFilterProvider.notifier).state = filter;
      },
      icon: const Icon(Icons.filter_list),
    );
  }
}

class _FilterTile extends StatelessWidget {
  final TodosFilter filter;
  const _FilterTile(this.filter);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context, filter);
      },
      title: Text(
        filter.name.capitalize(),
      ),
    );
  }
}
