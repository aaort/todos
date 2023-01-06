import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/logic/services/auth.dart';
import 'package:todos/screens/auth/sign_in_options.dart';
import 'package:todos/screens/home.dart';

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return Auth.authStateChanges;
});

class AppNavigator extends ConsumerWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateChangesProvider).when(
          error: (_, __) => const Center(child: Text('Something went wrong')),
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (user) => user != null ? const Home() : const SignInOptions(),
        );
  }
}
