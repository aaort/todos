import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/styles.dart';
import 'package:todos/widgets/add_todo_button.dart';
import 'package:todos/widgets/modal_bottom_sheet.dart';
import 'package:todos/widgets/todo_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  showAddTodoModal(BuildContext context) {
    popupModalBottomSheet(
      context: context,
      child: const TodoEditor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: AddTodoButton(
          onPressed: () => showAddTodoModal(context),
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: Styles(context).todoListPadding,
                child: Text(
                  '${context.watch<Todos>().todos.length} Tasks',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const TodoList(),
            ],
          ),
        ),
      ),
    );
  }
}
