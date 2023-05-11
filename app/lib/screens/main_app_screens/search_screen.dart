import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/widgets/job_widgets/job_offer_description.dart';
import 'package:itflowapp/widgets/custom_widgets/navigation_bar.dart';
import 'package:itflowapp/controllers/itjobs/it_jobs_api.dart';
import 'package:itflowapp/models/job.dart';
import 'package:itflowapp/screens/main_app_screens/filters_screen.dart';
import 'package:itflowapp/main.dart';
import 'package:itflowapp/widgets/custom_widgets/filters_applied.dart';
import 'package:itflowapp/widgets/job_widgets/search_list_view.dart';

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
    debugPrint('SearchScreen: didChangeDependencies');
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      _filters = args as Map<String, dynamic>;
    }
  }

  void _handleFilterRemove(Map<String, dynamic> updatedFilters) {
    debugPrint('Updated filters: $updatedFilters');
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
              onChanged: (value) {
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
            child: SearchListView(
              query: _searchText,
              filters: _filters,
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
