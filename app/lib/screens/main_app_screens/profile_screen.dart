import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/main.dart';
import 'package:itflowapp/widgets/job_offer.dart';
import 'package:itflowapp/widgets/navigation_bar.dart';
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
          Row(
            children: [
              Expanded(
                child: Column(
                  //profile picture and edit profile
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:const [
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:const [
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
          
            //bookmarks
            
          JobOffer(hirer: "II SECTOR inc", location: "Porto,Portugal",type: "Full time", job: "REACT JS DEVELOPER",),
          
        ],
      ),
      bottomNavigationBar: const NavBar(
        currentIndex: 3,
      ),
    );
  }
}
