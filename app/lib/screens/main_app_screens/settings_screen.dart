import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/controllers/firebase/auth.dart';
import 'package:itflowapp/main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.home);
            },
            child: Hero(
              tag: kLogoHeroTag,
              child: Image.asset(kLogoImageAssetPath, height: 30),
            ),
          )),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AuthController.logout();
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.start, ModalRoute.withName('/'));
          },
          child: const Text("Log Out"),
        ),
      ),
    );
  }
}
