import 'package:flutter/material.dart';
import 'package:itflowapp/constants.dart';
import 'package:itflowapp/main.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        centerTitle: true,
      ),
      body: Column(children: [
        const Expanded(
          flex: 9,
          child: Center(
            child: Text(
              'Register',
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                // Remove Every Screen and Leave Only the New One
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.home, ModalRoute.withName('/'));
              },
              child: const Text('Submit'),
            ),
          ),
        )
      ]),
    );
  }
}
