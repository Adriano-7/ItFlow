import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/main.dart';
import 'package:itflowapp/widgets/navigation_bar.dart';

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
      bottomNavigationBar: const NavBar(
        currentIndex: 1,
      ),
    );
  }
}
