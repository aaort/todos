import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/main.dart';
import 'package:todos/screens/home.dart';
import 'package:todos/screens/todo_editor.dart';
import 'package:todos/widgets/home/todo_list.dart';
import 'package:todos/widgets/todo_editor/todo_tile.dart';

void main() {
  testWidgets('Testing widgets', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const App());

    final home = find.byType(Home);
    final todoList = find.byType(TodoList);
    final showTodoEditorButton = find.byType(FloatingActionButton);
    final todoTile = find.byType(TodoTile);

    expect(home, findsOneWidget);
    expect(todoList, findsOneWidget);
    expect(showTodoEditorButton, findsOneWidget);
    expect(todoTile, findsNothing);

    final todoEditorModal = find.byType(TodoEditor);
    expect(todoEditorModal, findsNothing);

    /// Required because of animation taking time to
    /// let button actually appear on the screen
    await tester.pumpAndSettle();
    await tester.tap(showTodoEditorButton);
    await tester.pumpAndSettle();
    expect(todoEditorModal, findsOneWidget);

    final createTodoButton = find.byKey(const Key('createTodoButtonId'));
    expect(createTodoButton, findsOneWidget);

    final createTodoInput = find.byKey(const Key('createTodoInputId'));
    expect(createTodoInput, findsOneWidget);

    const inputContent = 'something really important';
    await tester.enterText(createTodoInput, inputContent);
    await tester.pump();
    final createTodoInputText = find.text(inputContent);
    expect(createTodoInputText, findsOneWidget);
  });
}
