import 'package:flutter/material.dart';
import 'package:itflowapp/constants.dart';
import 'package:itflowapp/main.dart';
import 'package:itflowapp/theme/navigation_bar.dart';

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
      body: Column(
        children: [
          Expanded(
            //profile
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    //profile picture and edit profile
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.person, size: 100),
                      ElevatedButton(
                          onPressed: null, child: Text("Edit Profile")),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    // name and profession
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: const [
                          Text(
                            "Faísca Raimundo",
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Analytical Counselor"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            //bookmarks
            flex: 2,
            child: Text("Bookmarks"),
          )
        ],
      ),
      bottomNavigationBar: const NavBar(
        currentIndex: 3,
      ),
    );
  }
}
