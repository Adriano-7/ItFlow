import 'package:flutter/material.dart';
import 'package:itflowapp/widgets/navigation_bar.dart';
import 'package:itflowapp/widgets/offers_list_view.dart';

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
        title: Image.asset('assets/images/logo.png', height: 30,),
        ),
      body: const OffersListView(),
      bottomNavigationBar: const NavBar(
        currentIndex: 0,
      ),
    );
  }
}
