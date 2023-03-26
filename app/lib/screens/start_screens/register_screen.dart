import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/widgets/forms/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        centerTitle: true,
      ),
      body: RegisterForm(),
    );
  }
}
