import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/auth_state.dart';
import 'package:tech_gate/provider/auth_provider.dart';
import 'package:tech_gate/screens/bottom_app_bar.dart';
import 'package:tech_gate/screens/welcome_screen.dart';

class AuthWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    print('AuthWrapper: Current auth state: $authState');

    return authState.when(
      initial: () => WelcomeScreen(),
      authenticated: (user) => BottomAppBars(),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}
