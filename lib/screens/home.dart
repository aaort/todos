import 'package:flutter/material.dart';
import 'package:todos/widgets/home/add_todo_button.dart';
import 'package:todos/widgets/home/todo_list.dart';
import 'package:todos/widgets/home/top_bar.dart';

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
          children: const [TopBar(), Flexible(child: TodoList())],
        ),
      ),
    );
  }
}
