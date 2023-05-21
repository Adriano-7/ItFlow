import 'package:flutter/material.dart';
import 'package:itflowapp/controllers/firebase/auth.dart';
import 'package:itflowapp/theme/app_theme.dart';
import 'package:itflowapp/main.dart';

class NavBar extends StatelessWidget {
  final int _currentIndex;
  const NavBar({Key? key, required int currentIndex}) :
        _currentIndex = currentIndex, super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 28,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      backgroundColor: AppColors.black,
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
            if (AuthController.currentUser == null) {
              Navigator.pushNamed(context, Routes.login);
              break;
            }
            Navigator.pushReplacement(
                context, NoPageTransitionToMyApp(Routes.profile));
            break;
        }
      },
    );
  }

  BottomNavigationBarItem _buildNavBarItem(
      {required IconData icon, String label = ''}) {
    return BottomNavigationBarItem(
        icon: Icon(icon),
        label: label,
        activeIcon: Container(
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(18),
          child: Icon(
            icon,
            color: AppColors.black,
          ),
        ));
  }

  List<BottomNavigationBarItem> _buildNavBarItems() {
    return [
      _buildNavBarItem(icon: Icons.home),
      _buildNavBarItem(icon: Icons.search),
      _buildNavBarItem(icon: Icons.person),
    ];
  }
}
