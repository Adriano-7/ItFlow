
import 'package:flutter/cupertino.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/controllers/firebase/auth.dart';
import 'package:itflowapp/controllers/firebase/database.dart';
import 'package:itflowapp/models/user.dart';

class LoginFormController {
  bool rememberLogin = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? _errorMessage;
  String? _errorCode;

  String get email => emailController.text;
  String get password => passwordController.text;
  String? get errorMessage => _errorMessage;
  String? get errorCode => _errorCode;

  String? emailValidator(value) {
    if (value == null || value!.isEmpty) {
      return "Email can't be empty!";
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value == null || value!.isEmpty) {
      return "password can't be empty!";
    }
    if (value.length < kPasswordMinimumLength || value.length > kPasswordMaximumLength) {
      return "Password length must be between $kPasswordMinimumLength and $kPasswordMaximumLength characters.";
    }
    return null;
  }

  Future<bool> submit() async {
    AuthController.rememberMe = rememberLogin;
    LogInStatus status = await AuthController.loginUser(email, password);
    if (status.errorOccurred) {
      _errorMessage = status.errorMessage;
      _errorCode = status.errorCode;
      return false;
    } else {
      // All Good
      final info = await DataBaseController.getUser(AuthController.currentUser!.uid);
      if (info == null) return false;
      AuthController.currentUserModel = UserModel.fromFirestore(info);
      return true;
    }
  }
}
