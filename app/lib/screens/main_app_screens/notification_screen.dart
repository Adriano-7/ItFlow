import 'package:flutter/material.dart';
import 'package:itflowapp/constants.dart';
import 'package:itflowapp/main.dart';
import 'package:itflowapp/widgets/navigation_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(appName),
      ),
      body: const Center(
        child: Text('Notifications'),
      ),
      bottomNavigationBar: const NavBar(
        currentIndex: 2,
      ),
    );
  }
}
