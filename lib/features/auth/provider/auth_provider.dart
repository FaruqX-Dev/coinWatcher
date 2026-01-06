import 'package:coin_watcher/features/auth/controllers/auth_controller.dart';
import 'package:coin_watcher/features/auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart' ;


//Provides the auth service
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});


//provides the auth state
final authStateProvider = StreamProvider<User?>((ref){
final authService = ref.watch(authServiceProvider);
return authService.authStatechanges();
});


//provides current user snapshot
final currentUserProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStatechanges(); // Use the stream!
});

//
final authenticatedUserProvider = Provider<User?>((ref) {
  final authAsync = ref.watch(currentUserProvider);

  return authAsync.when(
    data: (user) {
      if (user == null || user.isAnonymous) return null;
      return user;
    },
    loading: () => null,
    error: (_, __) => null,
  );
});
//provides the authstatecontroller(for auth actions)
final authcontrollerProvider= Provider<AuthController>((ref){
final authService = ref.watch(authServiceProvider);
return AuthController(authService);
});

// Add this to your providers file
final hasSeenWelcomeProvider = StateProvider<bool>((ref) => false);