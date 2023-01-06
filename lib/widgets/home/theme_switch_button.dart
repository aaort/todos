import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/main.dart';

class ThemeSwitchIconButton extends ConsumerWidget {
  const ThemeSwitchIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (child, anim) => RotationTransition(
            turns: child.key == const ValueKey('dark_key')
                ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                : Tween<double>(begin: 0.75, end: 1).animate(anim),
            child: ScaleTransition(scale: anim, child: child),
          ),
          child: isDarkMode ? _darkIcon : _lightIcon,
        ),
        const SizedBox(width: 10),
        const Text('Switch Theme')
      ],
    );
  }
}

const _darkIcon = Icon(Icons.dark_mode, key: ValueKey('dark_key'));
const _lightIcon = Icon(Icons.light_mode, key: ValueKey('light_key'));
