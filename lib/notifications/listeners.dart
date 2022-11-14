import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/logic/todos_io.dart';
import 'package:todos/notifications/constants.dart';
import 'package:provider/provider.dart';

import '../main.dart';

Future<void> onActionReceivedMethod(ReceivedAction action) async {
  final todoId = action.payload?['todoId'];
  if (todoId == null) return;
  if (action.buttonKeyPressed == notificationActions[completedButtonKey]) {
    if (action.actionLifeCycle != NotificationLifeCycle.AppKilled) {
      App.materialAppKey.currentContext
          ?.read<Todos>()
          .toggleCheckById(todoId, value: true);
    }
    TodosIO.toggleCheck(action.payload!['todoId']!, value: true);
  }
}
