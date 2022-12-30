import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:todos/logic/services/database.dart';
import 'package:todos/widgets/home/logout_button.dart';
import 'package:todos/widgets/home/theme_switch_button.dart';

final todosCountProvider = StreamProvider<int?>((ref) {
  return Database.getTodosCount();
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
          Row(
            children: const [
              LogoutButton(),
              ThemeSwitchIconButton(),
            ],
          )
        ],
      ),
    );
  }
}
