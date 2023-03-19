import 'package:flutter/material.dart';
import 'package:itflowapp/constants.dart';
import 'package:itflowapp/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        centerTitle: true,
      ),
      body: LoginForm(),
    );
  }
}
