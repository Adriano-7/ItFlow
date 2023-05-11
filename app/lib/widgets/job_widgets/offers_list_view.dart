import 'package:flutter/material.dart';
import 'package:itflowapp/controllers/itjobs/it_jobs_api.dart';
import 'package:itflowapp/widgets/job_widgets/job_offer.dart';

class OffersListView extends StatefulWidget {
  const OffersListView({Key? key}) : super(key: key);

  @override
  State<OffersListView> createState() => _OffersListViewState();
}

class _OffersListViewState extends State<OffersListView> {
  final int _limitPerRequest = 10;
  final int _nextPageTrigger = 4;

  late int _page;
  late bool _isLastPage;
  late bool _error;
  late bool _loading;
  late List<Widget> _offers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _page = 1;
    _offers = [];
    _isLastPage = false;
    _loading = true;
    _error = false;
    _getMoreOffers();
  }

  void _getMoreOffers() async {
    try {
      JobList jobList = await ItJobsApiController.listJobs(
        limit: _limitPerRequest,
        page: _page,
      );
      if (jobList.results == null) return;
      setState(() {
        _isLastPage = jobList.results!.length < _limitPerRequest;
        _loading = false;
        _page++;
        _offers.addAll(jobList.results!.map((job) => JobOffer.fromJob(job)));
      });
    }
    catch (e) {
      print("Error: $e");
      setState(() {
        _loading = false;
        _error = true;
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
                _getMoreOffers();
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
        itemBuilder: (context, index){
          if (index == _offers.length - _nextPageTrigger){
            _getMoreOffers();
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
