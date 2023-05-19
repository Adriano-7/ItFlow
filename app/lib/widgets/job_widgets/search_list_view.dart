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
  final _scrollController = ScrollController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _page = 1;
    _isLastPage = false;
    _error = false;
    _loading = true;
    _offers = [];
    searchJobs();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {searchJobs();}
    });
  }

  void searchJobs() async {
    if(_isSearching) return;
    _isSearching = true;
    try {
      debugPrint('Query: ${widget.query}');
      debugPrint('Filters: ${widget.filters}');
      JobSearch results = await ItJobsApiController.searchJobs(widget.query, widget.filters, page: _page);
      if (mounted){
      setState(() {
        _offers.addAll(results.results.map((job) => JobOfferDescription.fromJob(job)));
        _page++;
        _isLastPage = results.length < 10;
        _error = false;
        _loading = false;
      });}
    } catch (e) {
      if (mounted){
      setState(() {
        debugPrint('Query: ${widget.query}');
        debugPrint('Filters: ${widget.filters}');
        _error = true;
        _loading = false;
      });}
    }
    finally {
      _isSearching = false;
    }
  }

  Widget _errorDialog({required double size}) {
    return SizedBox(
      height: 50,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Oops, nothing found.",
            style: TextStyle(
              fontSize: size,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return ListView.builder(
        controller: _scrollController,
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
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
          final Widget offer = _offers[index];
          return Padding (
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 25.0),
            child: offer,
          );
        },);
  }
}
