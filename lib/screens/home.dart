import 'package:flutter/material.dart';
import 'package:todos/logic/services/database.dart';
import 'package:todos/widgets/home/add_todo_button.dart';
import 'package:todos/widgets/home/logout_button.dart';
import 'package:todos/widgets/home/theme_switch_button.dart';
import 'package:todos/widgets/home/todo_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Stream<int> _todosCount;

  @override
  void initState() {
    _todosCount = Database.getTodosCount();
    super.initState();
  }

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
                  StreamBuilder<int>(
                    stream: _todosCount,
                    builder: (context, snapshot) {
                      return Text(
                        '${(snapshot.data ?? '').toString()} Todos',
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                    },
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
