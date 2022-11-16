import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/widgets/add_todo_button.dart';
import 'package:todos/widgets/theme_switch_button.dart';
import 'package:todos/widgets/todo_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: const AddTodoButton(),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${context.watch<TodoManager>().todos.length} Tasks',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const ThemeSwitchIconButton()
                  ],
                ),
              ),
              const Flexible(child: TodoList())
            ],
          ),
        ),
      ),
    );
  }
}
