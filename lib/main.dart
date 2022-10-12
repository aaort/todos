import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/logic/todos.dart';
import 'package:todos/screens/home.dart';

void main() {
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
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blueGrey,
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              color: Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.w800,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            bodySmall: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
        home: const Home(),
      ),
    );
  }
}
