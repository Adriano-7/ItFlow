import 'package:flutter/material.dart';
import 'package:itflowapp/controllers/itjobs/it_jobs_api.dart';
import 'package:itflowapp/widgets/job_widgets/job_offer_description.dart';

class SearchListView extends StatefulWidget {
  final String query;
  final Map<String, dynamic> filters;
  const SearchListView({Key? key, required this.query, required this.filters}) : super(key: key);

  @override
  _SearchListViewState createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  late int _page;
  late bool _isLastPage;
  late bool _error;
  late bool _loading;
  final int _nextPageTrigger = 4;
  late List<JobOfferDescription> _offers;

  @override
  void initState() {
    super.initState();
    _page = 1;
    _isLastPage = false;
    _error = false;
    _loading = true;
    _offers = [];
    searchJobs();
  }

  void searchJobs() async {
    try {
      debugPrint('Query: ${widget.query}');
      debugPrint('Filters: ${widget.filters}');
      JobSearch results = await ItJobsApiController.searchJobs(widget.query, widget.filters, page: _page);
      setState(() {
        _offers.addAll(results.results.map((job) => JobOfferDescription.fromJob(job)));
        _page++;
        _isLastPage = results.length < 10;
        _error = false;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        debugPrint('Query: ${widget.query}');
        debugPrint('Filters: ${widget.filters}');
        _error = true;
        _loading = false;
      });
    }
  }

  Widget _errorDialog({required double size}) {
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An error occurred when fetching the posts.',
            style: TextStyle(
              fontSize: size,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _loading = true;
                _error = false;
                searchJobs();
              });
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return ListView.builder(
        itemCount: _offers.length + (_isLastPage ? 0 : 1),
        itemBuilder: (BuildContext context, int index) {
          if (index == _offers.length - _nextPageTrigger) {
            searchJobs();
          }
          if (index == _offers.length) {
            if (_error) {
              return Center(
                child: _errorDialog(size: 15),
              );
            } else { // LOADING
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
          // All good
          final Widget offer = _offers[index];
          return Padding (
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 25.0),
            child: offer,
          );
        },);
  }
}
