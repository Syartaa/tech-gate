import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/provider/user_provider.dart';
import 'package:tech_gate/screens/bottom_app_bar.dart';
import 'package:tech_gate/screens/welcome_screen.dart';

class AuthWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);

    print('AuthWrapper: Current user state: $userAsyncValue');

    return userAsyncValue.when(
      data: (user) {
        if (user != null) {
          return BottomAppBars(); // If user is authenticated, go to HomeScreen
        } else {
          return WelcomeScreen(); // If user is null, go to WelcomeScreen
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}
