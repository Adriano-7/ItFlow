import 'package:flutter/material.dart';
import 'package:itflowapp/constants.dart';
import 'package:itflowapp/main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(appName),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.settings);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const Center(
        child: Text('Profile'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 3,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                  context, NoPageTransitionToMyApp(Routes.home));
              break;
            case 1:
              Navigator.pushReplacement(
                  context, NoPageTransitionToMyApp(Routes.search));
              break;
            case 2:
              Navigator.pushReplacement(
                  context, NoPageTransitionToMyApp(Routes.notification));
              break;
            case 3: // The current one
              // Maybe update page?
              break;
          }
        },
      ),
    );
  }
}
