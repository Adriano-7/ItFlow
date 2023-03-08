import 'package:flutter/material.dart';
import 'package:itflowapp/constants.dart';
import 'package:itflowapp/main.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(appName),
      ),
      body: const Center(
        child: Text('Search'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: ''),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                  context, NoPageTransitionToMyApp(Routes.home));
              break;
            case 1: // The current one
              // Maybe update page?
              break;
            case 2:
              Navigator.pushReplacement(
                  context, NoPageTransitionToMyApp(Routes.notification));
              break;
            case 3:
              Navigator.pushReplacement(
                  context, NoPageTransitionToMyApp(Routes.profile));
              break;
          }
        },
      ),
    );
  }
}
