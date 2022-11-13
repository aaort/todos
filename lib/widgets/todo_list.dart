import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/theme/constants.dart';
import 'package:todos/theme/theme_manager.dart';
import 'package:todos/widgets/todo_tile.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: specify this color in theme
    final backgroundColor = context.watch<ThemeManager>().isDark
        ? kBackgroundDarkColor
        : Colors.white;
    final todos = context.watch<Todos>().todos;
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(kModalBorderRadius),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
        itemCount: todos.length,
        itemBuilder: (_, index) => TodoTile(id: todos[index].id),
      ),
    );
  }
}
