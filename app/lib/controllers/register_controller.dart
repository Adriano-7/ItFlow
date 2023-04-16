import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:itflowapp/controllers/auth.dart';
import 'package:itflowapp/constants/constants.dart';

enum UserType {
  standard,
  enterprise,
}

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
    if (value == null || value!.isEmpty) {
      return "Phone number can't be empty!";
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value == null || value!.isEmpty) {
      return "Password can't be empty!";
    }
    if (value.length < kPasswordMinimumLength || value.length > kPasswordMaximumLength) {
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

  // ====================== //
  // Standard Register Form //
  // ====================== //

  final locationController = TextEditingController();
  final sDescriptionController = TextEditingController();

  String get location => locationController.text;
  String get sDescription => sDescriptionController.text;

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
    if (value!.length < kDescriptionMinimumLength || value!.length > kDescriptionMaximumLength) {
      return "Description must be between $kDescriptionMinimumLength and $kDescriptionMaximumLength characters.";
    }
    return null;
  }

  // ======================== //
  // Enterprise Register Form //
  // ======================== //

  final addressController = TextEditingController();
  final siteUrlController = TextEditingController();
  final eDescriptionController = TextEditingController();

  Image? logo;
  Image? logoSnapshot;
  String? logoName;

  String get address => addressController.text;
  String get siteUrl => siteUrlController.text;
  String get eDescription => eDescriptionController.text;

  set logoFile(PlatformFile file){
    logo = Image.memory(file.bytes!);
    logoSnapshot = Image.memory(file.bytes!, width: 100, height: 80, fit: BoxFit.contain);
    logoName = file.name;
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
    if (value!.length < kDescriptionMinimumLength || value!.length > kDescriptionMaximumLength) {
      return "Description must be between $kDescriptionMinimumLength and $kDescriptionMaximumLength characters.";
    }
    return null;
  }

  // Submit Function //
  Future<bool> submit() async {
    SignUpStatus status = await AuthController.createUser(email, password);
    if (status.errorOccurred) {
      _errorMessage = status.errorMessage;
      _errorCode = status.errorCode;
      return false;
    } else {
      // All Good
      // TODO: Save user info in data base
      // e.g. DatabaseController.saveInfo?
      switch (userType) {
        case UserType.standard:
          // Save standard user data
          break;
        case UserType.enterprise:
          // Save enterprise user data
          break;
        default:
          return false;
      }
      return true;
    }
  }
}
