import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //stream for auth state changes
  Stream<User?> authStatechanges() => _auth.authStateChanges();

  //snapshot of current user
  User? get currentUser => _auth.currentUser;

  //Sign IN
  Future<User?> signIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  //Sign up
  Future<User?> signUp(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('SIGN UP ERROR: ${e.code} - ${e.message}');
      rethrow; // 🔥 THIS IS THE KEY LINE
    }
  }

  //Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //reset password
  Future<void> resetPassword(String email)async{
    await _auth.sendPasswordResetEmail(email: email);
  }

  //Sign in as guest
  Future<User?> signInAsGuest() async {
    final cred = await _auth.signInAnonymously();
    return cred.user;
  }
}
