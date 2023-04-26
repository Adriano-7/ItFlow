import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/controllers/firebase/auth.dart';
import 'package:itflowapp/main.dart';
import 'package:itflowapp/widgets/job_widgets/job_offer.dart';
import 'package:itflowapp/widgets/custom_widgets/navigation_bar.dart';
import 'package:itflowapp/models/job.dart';
import 'package:itflowapp/controllers/itjobs/it_jobs_api.dart';
class ProfileScreen extends StatelessWidget {
  Future <Job?> getjob(int id) async{
    JobGet job =  await ItJobsApiController.getJob(id);
    return job.job;
  }

  const ProfileScreen({Key? key}) : super(key: key);

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
                  // profile picture and edit profile
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
                  // Name and Location
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AuthController.currentUserModel!.name,
                          style: const TextStyle(fontSize: 25),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          AuthController.currentUserModel!.location ?? "",
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          //bookmarks
          
          FutureBuilder(
            future: getjob(459536),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              }
              if(snapshot.hasError){
                return Text("Error");
              }
              else{
                var temp =snapshot.data;
                if(temp== null){
                  return Text("Error");
                }
                else{
                  Job job = temp;
                  return JobOffer.fromJob(job);
                }
              }
            }
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(
        currentIndex: 3,
      ),
    );
  }
}
