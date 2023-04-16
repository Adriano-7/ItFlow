
import 'package:flutter/cupertino.dart';
import 'package:itflowapp/controllers/auth.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/main.dart';

class RegisterFormController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String? _errorMessage;
  String? _errorCode;

  String get getEmail => emailController.text;
  String get getPassword => passwordController.text;
  String get getRepeatPassword => repeatPasswordController.text;
  String get getName => nameController.text;
  String get getPhone => phoneController.text;
  String? get getErrorMessage => _errorMessage;
  String? get getErrorCode => _errorCode;

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Username can't be empty!";
    }
    if (value.length < userNameMinimumSize || value.length > userNameMaximumSize) {
      return "Username length must be between $userNameMinimumSize and $userNameMaximumSize characters.";
    }
    return null;
  }

  String? phoneNumberValidator(value) {
    if (value == null || value!.isEmpty) {
      return "Phone number can't be empty!";
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value == null || value!.isEmpty) {
      return "password can't be empty!";
    }
    if (value.length < passwordMinimumSize || value.length > passwordMaximumSize) {
      return "Password length must be between $passwordMinimumSize and $passwordMaximumSize characters.";
    }
    return null;
  }

  String? emailValidator(value) {
    if (value == null || value!.isEmpty) {
      return "Email can't be empty!";
    }
    return null;
  }

  String? repeatPasswordValidator(value) {
    if (value == null || value!.isEmpty) {
      return "Password can't be empty!";
    }
    if (value != getPassword) {
      return "Passwords don't match!";
    }
    return null;
  }

  Future<bool> submit(GlobalKey<FormState> formKey, BuildContext context) async {
    if (!formKey.currentState!.validate()) return false;

    SignUpStatus status = await AuthController.createUser(getEmail, getPassword);
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
