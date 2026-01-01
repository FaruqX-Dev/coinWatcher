import 'package:coin_watcher/features/auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final AuthService _authService;
  AuthController(this._authService);


  Future<User?> signIn(String email, String password)async{
    return _authService.signIn(email, password);
  }


  Future<User?> signUp(String email,String password)async{
    return _authService.signUp(email, password);
  }

  Future<void> signOut()async{
    return _authService.signOut();
  }

  Future<void> resetPassword(String email)async{
    return _authService.resetPassword(email);
  }

Future<User?> signInAsGuest()async{
  return _authService.signInAsGuest();
}

}
