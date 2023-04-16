import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  static final _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  static Future<SignUpStatus> createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return const SignUpStatus();
    } on FirebaseAuthException catch(e) {
      return SignUpStatus.error(e.code);
    } catch (_) {
      return SignUpStatus.error();
    }
  }

  static Future<LogInStatus> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return const LogInStatus();
    } on FirebaseAuthException catch(e) {
      return LogInStatus.error(e.code);
    } catch (_) {
      return LogInStatus.error();
    }
  }

  static Future<bool?> isEmailInUse(String email) async {
    try {
      return (await FirebaseAuth.instance.fetchSignInMethodsForEmail(email)).isNotEmpty;
    } catch (_) {
      return null;
    }
  }

  static Future<void> logout() async => await _auth.signOut();
}

class SignUpStatus {
  final bool errorOccurred;
  final String? errorMessage;
  final String? errorCode;
  const SignUpStatus([this.errorOccurred = false, this.errorMessage, this.errorCode]);


  factory SignUpStatus.error([String code = "unknown-error"]){
    switch (code) {
      case 'weak-password':
        return SignUpStatus(true, 'Please enter a stronger password.', code);
      case 'invalid-email':
        return SignUpStatus(true, 'Email is not valid.', code);
      case 'email-already-in-use':
        return SignUpStatus(true, 'An account already exists with that email.', code);
      case 'operation-not-allowed':
        return SignUpStatus(true, 'Operation is not allowed. Please contact support.', code);
      default:
        return SignUpStatus(true, 'An Unknown error occurred.', code);
    }
  }
}

class LogInStatus {
  final bool errorOccurred;
  final String? errorMessage;
  final String? errorCode;
  const LogInStatus([this.errorOccurred = false, this.errorMessage, this.errorCode]);

  factory LogInStatus.error([String code = "unknown-error"]){
    switch(code){
      case 'wrong-password':
        return LogInStatus(true, 'Wrong password.', code);
      case 'invalid-email':
        return LogInStatus(true, 'Email is not valid.', code);
      case 'user-not-found':
        return LogInStatus(true, "This user doesn't exist.", code);
      case 'user-disabled':
        return LogInStatus(true, 'This user has been disabled. Please contact support for help.', code);
      default:
        return LogInStatus(true, 'An Unknown error occurred.', code);
    }
  }
}