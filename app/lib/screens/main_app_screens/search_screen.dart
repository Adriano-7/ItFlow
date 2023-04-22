import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/widgets/job_widgets/job_offer_description.dart';
import 'package:itflowapp/widgets/custom_widgets/navigation_bar.dart';
import 'package:itflowapp/controllers/itjobs/it_jobs_api.dart';
import 'package:itflowapp/models/job.dart';
import 'package:itflowapp/screens/main_app_screens/filters_screen.dart';
import 'package:itflowapp/main.dart';
import 'package:itflowapp/widgets/custom_widgets/filters_applied.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';
  Map<String, dynamic> _filters = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      _filters = args as Map<String, dynamic>;
    }
  }

  void _handleFilterRemove(Map<String, dynamic> updatedFilters) {
    setState(() {
      _filters = updatedFilters;
    });
  }

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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterScreen(filters: _filters),
                      ),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _filters = value;
                        });
                      }
                    });
                  },
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),
          FiltersApplied(
              filters: _filters, onFilterRemoved: _handleFilterRemove),
          const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 40.0, 190.0, 20.0),
            child: Text(
              'Search Results',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<JobSearch>(
              future: ItJobsApiController.searchJobs(_searchText, _filters),
              builder:
                  (BuildContext context, AsyncSnapshot<JobSearch> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      Job job = snapshot.data!.results[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: JobOfferDescription.fromJob(job),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Container();
                } else {
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
        currentIndex: 1,
      ),
    );
  }
}
