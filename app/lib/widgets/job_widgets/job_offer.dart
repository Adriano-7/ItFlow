import 'package:flutter/material.dart';
import 'package:itflowapp/controllers/firebase/auth.dart';
import 'package:itflowapp/controllers/firebase/database.dart';
import 'package:itflowapp/models/job.dart';
import 'package:itflowapp/theme/app_theme.dart';
import 'package:itflowapp/widgets/custom_widgets/icon_switch.dart';
import 'package:itflowapp/screens/main_app_screens/job_details_screen.dart';

class JobOffer extends StatelessWidget {
  bool bookmarkActive = false;
  static const double _logoWidthPercentage = 0.15;
  static const double _logoHeightPercentage = 0.10;
  static const double _titlePercentage = 0.45;
  static const double _cardHeight = 125;
  final Job jobDetails;
  final int _id; //job id
  final String _hirer; //hirer name
  final String _location; //city and country
  final String _type; // part-time or full-time
  final String _job; // ex: React-developer or engineer
  late final Image _logo; // hirer logo

  void bookmark(bool x){ // if this isnt here it doesnt work (idk why)
    if(!bookmarkActive){ // if you bookmark this offer
      bookmarkActive=true;
      String? temp = AuthController.currentUser?.uid;
      if(temp!=null){
        DataBaseController.addBookmark(temp, _id);
      }
  
    }
    else{ //if you remove bookmark
      bookmarkActive = false;
      String? temp = AuthController.currentUser?.uid;
      if(temp!=null){
        DataBaseController.removeBookmark(temp, _id);
      }
    }
  }
  JobOffer({
    Key? key,
    String hirer = '',
    String location = '',
    String type = '',
    String job = '',
    int id = -1,
    Image? logo,
    required this.jobDetails,
  })  : _hirer = hirer,
        _location = location,
        _type = type,
        _job = job,
        _id = id,
        super(key: key) {
    _logo = logo ??
        Image.network(
          'https://i.scdn.co/image/ab67616d0000b2734e57c459c44ad93020529594',
          scale: 10,
        );
  }

  factory JobOffer.fromJob(Job job) {
    return JobOffer(
      hirer: job.company?.name ?? '',
      location: job.locations == null ? '' : job.locations![0].name,
      type: job.types == null ? '' : job.types![0].name,
      job: job.title,
      logo: Image.network(job.company?.logoUrl ?? ''),
      id: job.id,
      jobDetails: job,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              // we want the Job object of the jobOffer
              builder: (context) => JobDetailsScreen(jobOffer: jobDetails),
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: AppColors.gray2,
          ),
          width: screenWidth * 0.90,
          height: _cardHeight,
          alignment: Alignment.center,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 17.0, vertical: 20.0),
            child: Stack(
              children: [
                Align(
                  // LOGO
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: screenWidth * _logoHeightPercentage,
                    width: screenWidth * _logoWidthPercentage,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(child: _logo),
                    ),
                  ),
                ),
                Align(
                  // TITLE
                  alignment: Alignment.topCenter,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: screenWidth * _titlePercentage,
                      maxHeight: _cardHeight * 0.4,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_hirer,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[500],
                              )),
                          Text(
                            _job,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  // BOOKMARK
                  alignment: Alignment.topRight,
                  child: IconSwitch(
                    onChanged:bookmark,
                    iconEnabled: Icon(Icons.bookmark),
                    iconDisabled: Icon(Icons.bookmark_border),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      // LOCATION
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(width: 10),
                          Text(_location),
                        ],
                      ),
                    ),
                    Align(
                      // TIME TYPE
                      alignment: Alignment.bottomRight,
                      child:
                          Text(_type, style: const TextStyle(fontSize: 12.0)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
