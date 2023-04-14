import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/widgets/navigation_bar.dart';
import 'package:itflowapp/controllers/it_jobs_api.dart';
import 'package:itflowapp/models/job.dart';
import 'package:itflowapp/widgets/job_offer.dart';
import 'package:itflowapp/screens/main_app_screens/filters_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(appName),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search jobs',
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterScreen(),
                      ),
                    );
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),
          Text(
            'Search Results',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: FutureBuilder<JobSearch>(
              future: ItJobsApiController.searchJobs(_searchText),
              builder: (BuildContext context, AsyncSnapshot<JobSearch> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      Job job = snapshot.data!.results[index];
                      return JobOffer.fromJob(job);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(
        currentIndex: 1,
      ),
    );
  }
}