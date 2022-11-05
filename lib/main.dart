import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/notifications/notifications.dart';
import 'package:todos/screens/home.dart';
import 'package:todos/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Notifications.initialize();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Todos>(
      create: (_) => Todos(),
      child: MaterialApp(
        title: 'Todos',
        theme: themeData,
        home: const Home(),
      ),
    );
  }
}
