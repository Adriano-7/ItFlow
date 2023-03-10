import 'package:flutter/material.dart';
import 'package:itflowapp/main.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  const NavBar({Key? key, required this.currentIndex}) : super(key: key);

  // Routes
  static const String home = '/home';
  static const String search = '/search';
  static const String notification = '/notification';
  static const String profile = '/profile';

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 28,
      fixedColor: ThemeData.dark().colorScheme.secondary,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      items: _buildNavBarItems(),
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
          case 3:
            Navigator.pushReplacement(
                context, NoPageTransitionToMyApp(Routes.profile));
            break;
        }
      },
    );
  }

  BottomNavigationBarItem _buildNavBarItem(
      {required IconData icon, required String label}) {
    return BottomNavigationBarItem(
        icon: Icon(icon),
        label: label,
        activeIcon: Container(
          decoration: BoxDecoration(
            color: ThemeData.dark().colorScheme.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(20),
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ));
  }

  List<BottomNavigationBarItem> _buildNavBarItems() {
    return [
      _buildNavBarItem(icon: Icons.home, label: home),
      _buildNavBarItem(icon: Icons.search, label: search),
      _buildNavBarItem(icon: Icons.notifications, label: notification),
      _buildNavBarItem(icon: Icons.person, label: profile),
    ];
  }
}
