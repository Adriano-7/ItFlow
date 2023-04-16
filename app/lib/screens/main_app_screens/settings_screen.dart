import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Settings'),
      ),
    );
  }
}
