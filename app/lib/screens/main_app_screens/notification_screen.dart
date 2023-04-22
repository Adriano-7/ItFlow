import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/widgets/custom_widgets/navigation_bar.dart';
import 'package:itflowapp/main.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

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
        ),
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
