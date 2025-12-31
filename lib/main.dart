import 'package:coin_watcher/core/themes/theme.dart';
import 'package:coin_watcher/features/auth/services/auth_gate.dart';
import 'package:coin_watcher/features/notifications/services/local_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Must be first!
  await Firebase.initializeApp();
  await LocalNotificationService().init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coin Watcher',
      theme: ref.watch(themeModeToggleProvider),
      home: AuthGate(),
    );
  }
}
