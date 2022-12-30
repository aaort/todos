import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/app_navigator.dart';
import 'package:todos/notifications/notifications.dart';
import 'package:todos/theme/theme.dart';
import 'package:todos/theme/theme_manager.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'todos',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Notifications.initialize();

  runApp(const ProviderScope(child: App()));
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeManager, ThemeMode>((ref) {
  return ThemeModeManager();
});

class App extends ConsumerWidget {
  const App({super.key});

  // TODO: unused
  static final materialAppKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      key: materialAppKey,
      title: 'Todos',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const AppNavigator(),
    );
  }
}
