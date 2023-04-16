import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:itflowapp/models/job.dart';
import 'package:itflowapp/theme/app_theme.dart';
import 'package:itflowapp/widgets/icon_switch.dart';
import 'package:itflowapp/screens/main_app_screens/job_details_screen.dart';

class JobOfferDescription extends StatelessWidget {
  static const double _logoWidthPercentage = 0.15;
  static const double _logoHeightPercentage = 0.10;
  static const double _titlePercentage = 0.45;
  static const double _cardHeight = 250;
  final Job jobDetails;

  final String _companyName;
  final String _jobName;
  final String _description;
  final String _location;
  final String _type;
  late final Image _logo;

  JobOfferDescription({
    Key? key,
    Image? logo,
    String companyName = '',
    String jobName = '',
    String description = '',
    String location = '',
    String type = '',
    required this.jobDetails,
  })  : _companyName = companyName,
        _location = location,
        _description = description,
        _type = type,
        _jobName = jobName,
        super(key: key) {
         _logo = logo ??
        Image.network(
          'https://i.scdn.co/image/ab67616d0000b2734e57c459c44ad93020529594',
          scale: 10,
        );
  }

  factory JobOfferDescription.fromJob(Job job){
    return JobOfferDescription(
        logo: Image.network(job.company?.logoUrl ?? ''),
        companyName: job.company?.name ?? '',
        jobName: job.title,
        description: job.body,
        location: job.locations == null ? '' : job.locations![0].name,
        type: job.types == null ? '' : job.types![0].name,
        jobDetails: job,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => JobDetailsScreen(jobOffer: jobDetails),),);
      },
      child: Container(
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: AppColors.gray2,),
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
                      maxHeight: _cardHeight * 0.2,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_companyName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[500],
                              )),
                          Text(
                            _jobName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 15),
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
                    onChanged: (_) {},
                    iconEnabled: const Icon(Icons.bookmark),
                    iconDisabled: const Icon(Icons.bookmark_border),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 38),
                  height: _cardHeight * 0.55,
                  child: Html(
                    data: _description,
                    style: {
                      "html": Style(
                        fontFamily: "Arial",
                        fontSize: const FontSize(12.0),
                        lineHeight: const LineHeight(1.7),
                        textAlign: TextAlign.justify,
                        wordSpacing: 1.0,
                        letterSpacing: 0.5,
                      ),
                    },
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