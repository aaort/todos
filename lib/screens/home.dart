import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/widgets/add_todo.dart';
import 'package:todos/widgets/modal_bottom_sheet.dart';
import 'package:todos/widgets/todo_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  showAddTodoModal(BuildContext context) {
    popupModalBottomSheet(
      context: context,
      child: const AddTodo(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () => showAddTodoModal(context),
        child: const Icon(Icons.edit_outlined),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Todo',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${context.watch<Todos>().todos.length} Tasks',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const TodoList(),
          ],
        ),
      ),
    );
  }
}
