import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/services/database.dart';
import 'package:todos/widgets/home/menu.dart';

final todosCountProvider = StreamProvider.autoDispose<int?>((ref) {
  return Database.todosCount;
});

class TopBar extends ConsumerWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosCount = ref.watch(todosCountProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${(todosCount.value ?? '').toString()} Todos',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Menu(),
        ],
      ),
    );
  }
}
