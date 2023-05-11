import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/controllers/firebase/auth.dart';
import 'package:itflowapp/controllers/firebase/database.dart';
import 'package:itflowapp/main.dart';
import 'package:itflowapp/widgets/job_widgets/job_offer.dart';
import 'package:itflowapp/widgets/custom_widgets/navigation_bar.dart';
import 'package:itflowapp/models/job.dart';
import 'package:itflowapp/controllers/itjobs/it_jobs_api.dart';

 
class ProfileScreen extends StatelessWidget {

  Future<List<dynamic>> getJobs() async{
    String uid =AuthController.currentUser!.uid;
    List<dynamic> ids =  await DataBaseController.getBookmarks(uid);
    List<Job> jobs=[];
    for(var i=0; i<ids.length; i++){
      JobGet job = await ItJobsApiController.getJob(ids[i]);
      Job? temp = job.job;
      if(temp!=null){
        jobs.add(temp);
      } 
    }
    return jobs;
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
          const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 40.0, 220.0, 10.0),
            child: Text(
              'Bookmarks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          //bookmarks
          
          Expanded(
            child: FutureBuilder <dynamic>( 
              future: getJobs(),
              builder:
                (context,snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Job job = snapshot.data[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: JobOffer.fromJob(job),
                        );
                      },
                    );
                  } 
                  else if (snapshot.hasError) {
                    return Container();
                  } 
                  else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(
        currentIndex: 3,
      ),
    );
  }
}
