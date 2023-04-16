
import 'package:flutter/cupertino.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/controllers/auth.dart';
import 'package:itflowapp/main.dart';

class LoginFormController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? _errorMessage;
  String? _errorCode;

  String get getEmail => emailController.text;
  String get getPassword => passwordController.text;
  String? get getErrorMessage => _errorMessage;
  String? get getErrorCode => _errorCode;

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

  Future<bool> submit(GlobalKey<FormState> formKey, BuildContext context) async {
    if (!formKey.currentState!.validate()) return false;

    LogInStatus status = await AuthController.loginUser(getEmail, getPassword);
    if (status.errorOccurred) {
      _errorMessage = status.errorMessage;
      _errorCode = status.errorCode;
      return false;
    } else { // All Good
      // TODO: Save user info in data base
      // e.g. DatabaseController.saveInfo?
      return true;
    }
  }
}
