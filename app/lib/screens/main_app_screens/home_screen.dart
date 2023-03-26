import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/main.dart';
import 'package:itflowapp/widgets/navigation_bar.dart';
import 'package:itflowapp/widgets/job_offer.dart';
import 'package:itflowapp/controllers/it_jobs_api.dart';
import 'package:itflowapp/models/job.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget>? _offers;
  final _controller = ScrollController();
  int _page = 1;
  int _lastJobListId = -1;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (!isTop) {
          _getMoreOffers();
        }
      }
    });
  }

  void _getMoreOffers() {
    setState(() {
      _page++;
    });
  }

  void _addOffers(JobList jobList) {
    if (_lastJobListId != jobList.id) {
      print("ADDED PAGE ${jobList.page}");
      if (jobList.results == null) return;
      _offers ??= List<Widget>.empty(growable: true);
      for (Job job in jobList.results!) {
        _offers!.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: JobOffer.fromJob(job),
          ),
        );
      }
      _lastJobListId = jobList.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(appName),
      ),
      body: FutureBuilder<JobList>(
          future: ItJobsApiController.listJobs(page: _page),
          builder: (context, AsyncSnapshot<JobList> snapshot) {
            print("BUILD");
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              _addOffers(snapshot.data!);
              return SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                controller: _controller,
                child: Column(
                  children: _offers!,
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      bottomNavigationBar: const NavBar(
        currentIndex: 0,
      ),
    );
  }
}
