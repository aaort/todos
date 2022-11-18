import 'package:flutter/material.dart';
import 'package:todos/logic/db_actions.dart';
import 'package:todos/widgets/add_todo_button.dart';
import 'package:todos/widgets/logout_button.dart';
import 'package:todos/widgets/theme_switch_button.dart';
import 'package:todos/widgets/todo_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: const AddTodoButton(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder(
                    future: DbActions.getTodosCount(),
                    builder: ((context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          '${snapshot.data.toString()} Todos',
                          style: Theme.of(context).textTheme.titleLarge,
                        );
                      }
                      return const Text('');
                    }),
                  ),
                  Row(
                    children: const [
                      LogoutButton(),
                      ThemeSwitchIconButton(),
                    ],
                  )
                ],
              ),
            ),
            const Flexible(child: TodoList())
          ],
        ),
      ),
    );
  }
}
