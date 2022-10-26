import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/main.dart';
import 'package:todos/screens/home.dart';
import 'package:todos/screens/add_todo.dart';
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

    final createTodoButton = find.byKey(const Key('createTodoButtonId'));
    expect(tester.widget<ElevatedButton>(createTodoButton).enabled, false);

    final createTodoInput = find.byKey(const Key('createTodoInputId'));
    expect(createTodoButton, findsOneWidget);

    const inputContent = 'something really important';
    await tester.enterText(createTodoInput, inputContent);
    await tester.pump();
    final createTodoInputText = find.text(inputContent);
    expect(createTodoInputText, findsOneWidget);

    expect(tester.widget<ElevatedButton>(createTodoButton).enabled, true);

    await tester.tap(createTodoButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    // Wait until hide animation's complete
    expect(
        addTodoModal.evaluate().first.renderObject!.debugNeedsPaint, isFalse);
    // Checks whether widget is visible or not (true if visible)
  });
}
