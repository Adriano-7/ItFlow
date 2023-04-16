import 'package:flutter/material.dart';
import '../../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: InkWell(onTap: () {Navigator.pushReplacementNamed(context, Routes.home);},
            child: Image.asset('assets/images/logo.png', height: 30,),
          )
      ),
      body: const Center(
        child: Text('Settings'),
      ),
    );
  }
}
