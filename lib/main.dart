import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/app_navigator.dart';
import 'package:todos/theme/theme.dart';
import 'package:todos/theme/theme_mode_manager.dart';

import 'firebase_options.dart';

final themeModeManagerProvider =
    StateNotifierProvider<ThemeModeManager, ThemeMode?>((ref) {
  return ThemeModeManager();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'todos',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // On Android new notification is scheduled each second,
  // possibly issue inside awesome_notifications itself
  // await Notifications.initialize();

  runApp(
    ProviderScope(
      child: Consumer(
        builder: (_, ref, __) {
          final themeMode = ref.watch(themeModeManagerProvider);
          if (themeMode != null) {
            return const App();
          } else {
            // TODO: the idea was to do not display any UI until theme mode will be defined
            // This behavior should be tested in a release or profile mode
            // To be able to detect how app behaves without frame drops
            return const MaterialApp(home: Scaffold());
          }
        },
      ),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeManagerProvider)!;
    return MaterialApp(
      title: 'Todos',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const AppNavigator(),
    );
  }
}
