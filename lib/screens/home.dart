import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/theme/theme_manager.dart';
import 'package:todos/widgets/add_todo_button.dart';
import 'package:todos/widgets/todo_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void toggleTheme(BuildContext context) {
    context.read<ThemeManager>().toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: const AddTodoButton(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => toggleTheme(context),
              icon: const Icon(Icons.sunny),
            )
          ],
          title: Text('${context.watch<Todos>().todos.length} Tasks'),
        ),
        body: const SafeArea(
          bottom: false,
          child: TodoList(),
        ),
      ),
    );
  }
}
