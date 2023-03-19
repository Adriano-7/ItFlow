import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final email = TextEditingController();
  final password = TextEditingController();

  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      final ex = SignUpFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION: ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpFailure();
      print('EXCEPTION: ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
    } catch (_) {}
  }

  Future<void> logout() async => await _auth.signOut();
}

class SignUpFailure {
  final String message;
  const SignUpFailure([this.message = "An Unknown error occurred."]);

  factory SignUpFailure.code(String code){
    switch(code){
      case 'weak-password':
        return const SignUpFailure('Please enter a stronger password.');
      case 'invalid-email':
        return const SignUpFailure('Email is not valid.');
      case 'email-already-in-use':
        return const SignUpFailure('An account already exists with that email.');
      case 'operation-not-allowed':
        return const SignUpFailure('Operation is not allowed. Please contact support.');
      case 'user-disabled':
        return const SignUpFailure('This user has been disabled. Please contact support for help.');
      default: return const SignUpFailure();
    }
  }
}