import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:itflowapp/controllers/firebase/auth.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/controllers/firebase/database.dart';
import 'package:itflowapp/models/user.dart';

enum RegisterScreenType {
  main,
  standard,
  enterprise,
}

class RegisterScreenController extends ValueNotifier<RegisterScreenType> {
  RegisterScreenController({RegisterScreenType? value})
      : super(value ?? RegisterScreenType.main);
}

class RegisterFormController {
  bool rememberLogin = false;

  // Screen Controller //
  final registerFormScreenController = RegisterScreenController();
  RegisterScreenType get screen => registerFormScreenController.value;
  set screen(RegisterScreenType newValue) {
    registerFormScreenController.value = newValue;
  }

  // Error Variables //
  String? _errorMessage;
  String? _errorCode;
  String? get errorMessage => _errorMessage;
  String? get errorCode => _errorCode;

  // ================== //
  // Main Register Form //
  // ================== //
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  UserType userType = UserType.standard;

  String get email => emailController.text;
  String get password => passwordController.text;
  String get repeatPassword => repeatPasswordController.text;
  String get name => nameController.text;
  String get phone => phoneController.text;
  // Main Form Validator Functions //
  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Username can't be empty!";
    }
    if (value.length < kUserNameMinimumLength ||
        value.length > kUserNameMaximumLength) {
      return "Username length must be between $kUserNameMinimumLength and $kUserNameMaximumLength characters.";
    }
    return null;
  }

  String? phoneNumberValidator(value) {
    /* NOTHING FOR NOW
    if (value == null || value!.isEmpty) {
      return "Phone number can't be empty!";
    }
    */
    return null;
  }

  String? passwordValidator(value) {
    if (value == null || value!.isEmpty) {
      return "Password can't be empty!";
    }
    if (value.length < kPasswordMinimumLength ||
        value.length > kPasswordMaximumLength) {
      return "Password length must be between $kPasswordMinimumLength and $kPasswordMaximumLength characters.";
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
    if (value != password) {
      return "Passwords don't match!";
    }
    return null;
  }

  PlatformFile? logo;
  Image? logoSnapshot;
  String? logoName;
  String? logoURL;

  // ====================== //
  // Standard Register Form //
  // ====================== //

  final locationController = TextEditingController();
  final sDescriptionController = TextEditingController();

  String get location => locationController.text;
  String get sDescription => sDescriptionController.text;

  PlatformFile? cv;

  // Standard Form Validator Functions //

  String? locationValidator(value) {
    if (value == null || value!.isEmpty) {
      return "Location can't be empty!";
    }
    return null;
  }

  String? sDescriptionValidator(value) {
    if (value == null || value!.isEmpty) {
      return "Description can't be empty!";
    }
    if (value!.length < kDescriptionMinimumLength ||
        value!.length > kDescriptionMaximumLength) {
      return "Description must be between $kDescriptionMinimumLength and $kDescriptionMaximumLength characters.";
    }
    return null;
  }

  set cvFile(PlatformFile file) {
    cv = file;
  }

  // ======================== //
  // Enterprise Register Form //
  // ======================== //

  final addressController = TextEditingController();
  final siteUrlController = TextEditingController();
  final eDescriptionController = TextEditingController();

  String get address => addressController.text;
  String get siteUrl => siteUrlController.text;
  String get eDescription => eDescriptionController.text;

  set logoFile(PlatformFile file) {
    logo = file;
    logoSnapshot =
        Image.memory(file.bytes!, width: 100, height: 80, fit: BoxFit.contain);
    logoName = file.name;
  }

  Future<void> uploadProfilePicture() async {
    if (logo != null && AuthController.currentUser != null) {
      logoURL = await DataBaseController.uploadProfilePicture(
          logo!, AuthController.currentUser!.uid);
    }
  }

  // Enterprise Form Validator Functions //

  String? addressValidator(value) {
    /* NOTHING FOR NOW
    if (value == null || value!.isEmpty) {
      return "Address can't be empty!";
    }
    */
    return null;
  }

  String? siteUrlValidator(value) {
    /* NOTHING FOR NOW
    if (value == null || value!.isEmpty) {
      return "Url can't be empty!";
    }
    */
    return null;
  }

  String? eDescriptionValidator(value) {
    if (value == null || value!.isEmpty) {
      return "Description can't be empty!";
    }
    if (value!.length < kDescriptionMinimumLength ||
        value!.length > kDescriptionMaximumLength) {
      return "Description must be between $kDescriptionMinimumLength and $kDescriptionMaximumLength characters.";
    }
    return null;
  }

  // =============== //
  // Submit Function //
  // =============== //
  Future<bool> submit() async {
    AuthController.rememberMe = rememberLogin;
    SignUpStatus status = await AuthController.createUser(email, password);
    await uploadProfilePicture();
    if (status.errorOccurred) {
      _errorMessage = status.errorMessage;
      _errorCode = status.errorCode;
      return false;
    } else {
      // All Good
      UserModel user;
      switch (userType) {
        case UserType.standard:
          // Save standard user data
          user = UserModel(
              name: name,
              phone: phone,
              userType: userType,
              description: sDescription,
              location: location,
              profilePicUrl: logoURL);
          break;
        case UserType.enterprise:
          // Save enterprise user data
          user = UserModel(
              name: name,
              phone: phone,
              userType: userType,
              description: eDescription,
              address: address,
              siteUrl: siteUrl,
              profilePicUrl: logoURL);
          break;
        default:
          return false;
      }
      final info = user.toFirestore();
      if (info == null) {
        AuthController.currentUser?.delete();
        return false;
      }
      DataBaseController.setUser(AuthController.currentUser!.uid, info);
      AuthController.currentUserModel = user;
      return true;
    }
  }
}
