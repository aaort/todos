import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/main.dart';
import 'package:todos/screens/home.dart';
import 'package:todos/widgets/add_todo.dart';
import 'package:todos/widgets/todo_list.dart';
import 'package:todos/widgets/todo_tile.dart';

void main() {
  testWidgets('Testing widgets', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const App());

    final home = find.byType(Home);
    final todoList = find.byType(TodoList);
    final addTodoButton = find.byType(FloatingActionButton);
    final todoTile = find.byType(TodoTile);

    expect(home, findsOneWidget);
    expect(todoList, findsOneWidget);
    expect(addTodoButton, findsOneWidget);
    expect(todoTile, findsNothing);

    final addTodoModal = find.byType(AddTodo);
    expect(addTodoModal, findsNothing);

    await tester.tap(addTodoButton);
    await tester.pump();
    expect(addTodoModal, findsOneWidget);
  });
}
