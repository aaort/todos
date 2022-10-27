import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/screens/add_todo.dart';
import 'package:todos/widgets/modal_bottom_sheet.dart';
import 'package:todos/widgets/todo_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final _animController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final _animation =
      CurvedAnimation(parent: _animController, curve: Curves.bounceIn);

  showAddTodoModal(BuildContext context) {
    popupModalBottomSheet(
      context: context,
      child: const AddTodo(),
    );
  }

  @override
  void initState() {
    _animController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: ScaleTransition(
          scale: _animation,
          child: FloatingActionButton(
            onPressed: () => showAddTodoModal(context),
            child: const Icon(Icons.edit_outlined),
          ),
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
      ),
    );
  }
}
