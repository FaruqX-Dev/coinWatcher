import 'package:coin_watcher/features/auth/presentation/welcome_screen.dart';
import 'package:coin_watcher/features/auth/provider/auth_provider.dart';
import 'package:coin_watcher/features/auth/services/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasSeenWelcome = ref.watch(hasSeenWelcomeProvider);

    // 1. If they haven't seen welcome, show it.
    if (!hasSeenWelcome) {
      return WelcomeScreen(
        onGetStarted: () {
          // Flip the switch to true
          ref.read(hasSeenWelcomeProvider.notifier).state = true;
        },
      );
    }

    // 2. Once they click "Get Started", the AuthGate takes over.
    return const AuthGate();
  }
}