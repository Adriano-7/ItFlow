import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/widgets/custom_widgets/navigation_bar.dart';
import 'package:itflowapp/widgets/job_widgets/offers_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          tag: kLogoHeroTag,
          child: Image.asset(kLogoImageAssetPath, height: 30),
        ),
        ),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 40.0, left: 0, bottom: 40.0),
            child: Text(
              'Recommended',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: OffersListView(),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(
        currentIndex: 0,
      ),
    );
  }
}
