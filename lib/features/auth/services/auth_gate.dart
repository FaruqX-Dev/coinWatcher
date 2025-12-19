import 'package:coin_watcher/features/auth/presentation/signup_screen.dart';
import 'package:coin_watcher/features/auth/presentation/welcome_screen.dart';
import 'package:coin_watcher/features/auth/provider/auth_provider.dart';
import 'package:coin_watcher/features/coin_data/presentation/coin_screen_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authstate = ref.watch(authStateProvider);

        return authstate.when(
          data: (user) {
            if (user == null) {
              return WelcomeScreen();
            }
              return CoinScreenList();
            
            }
          ,
          error: (error, StackTrace) {
            return Scaffold(body: Center(child: Text('Error: $error')));
          },
          loading: () {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          },
        );
      },
    );
  }
}
