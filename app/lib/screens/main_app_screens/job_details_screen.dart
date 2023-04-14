import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/models/job.dart';
import 'package:itflowapp/theme/app_theme.dart';
import 'package:itflowapp/widgets/double_button.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:itflowapp/widgets/icon_switch.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job jobOffer;

  const JobDetailsScreen({Key? key, required this.jobOffer}) : super(key: key);

  @override
  JobDetailsScreenState createState() => JobDetailsScreenState();

  String getTimeAgo() {
    if (jobOffer.publishedAt == null) {
      return 'a long time ago';
    }

    final timeDifference = DateTime.now().difference(jobOffer.publishedAt!);

    if (timeDifference.inDays > 365) {
      return 'a long time ago';
    }

    if (timeDifference.inDays > 30) {
      return '${timeDifference.inDays ~/ 30} months ago';
    }

    if (timeDifference.inDays > 7) {
      return '${timeDifference.inDays ~/ 7} weeks ago';
    }

    if (timeDifference.inDays > 0) {
      return '${timeDifference.inDays} days ago';
    }

    if (timeDifference.inHours > 0) {
      return '${timeDifference.inHours} ${timeDifference.inHours == 1 ? 'hour' : 'hours'} ago';
    }

    return '${timeDifference.inMinutes} ${timeDifference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
  }
}

class JobDetailsScreenState extends State<JobDetailsScreen> {
  bool showDescription = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(appName),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 9, right: 9),
              child: Column(children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconSwitch(
                    onChanged: (_) {},
                    iconSize: 30.0,
                    iconEnabled: const Icon(Icons.bookmark),
                    iconDisabled: const Icon(Icons.bookmark_border),
                  ),
                ),
                Align(
                    child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.height * 0.10,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: widget.jobOffer.company?.logoUrl != null
                        ? Image.network(widget.jobOffer.company!.logoUrl)
                        : Container(),
                  ),
                )),
                const SizedBox(height: 20),
                Text(widget.jobOffer.company?.name ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    )),
                const SizedBox(height: 13),
                Text(widget.jobOffer.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on),
                    Text(
                      widget.jobOffer.locations?[0].name ?? "unknow Location",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                          width: 1.3,
                          color: Colors.grey[850]!,
                        ),
                        color: Colors.grey[900],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 9.0, bottom: 9.0, left: 22.0, right: 22.0),
                        child: Text(
                          widget.jobOffer.types?[0].name ?? "unknow Type",
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.green,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                          width: 1.3,
                          color: Colors.grey[850]!,
                        ),
                        color: Colors.grey[900],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 9.0, bottom: 9.0, left: 22.0, right: 22.0),
                        //put clock icon
                        child: Row(children: [
                          const Icon(Icons.access_time, size: 17),
                          const SizedBox(width: 6),
                          Text(
                            widget.getTimeAgo(),
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.green,
                            ),
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: DoubleButton(
                    onPressedFirst: () {
                      setState(() {
                        showDescription = true;
                      });
                    },
                    childFirst: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 0),
                      child: Text(
                        'DESCRIPTION',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: showDescription
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    onPressedSecond: () {
                      setState(() {
                        showDescription = false;
                      });
                    },
                    childSecond: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 0),
                      child: Text(
                        'COMPANY',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: !showDescription
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: showDescription
                      ? Html(data: widget.jobOffer.body, style: {
                          "html": Style(
                            fontFamily: "Arial",
                            fontSize: const FontSize(15.0),
                            lineHeight: const LineHeight(1.7),
                            textAlign: TextAlign.justify,
                            wordSpacing: 1.0,
                            letterSpacing: 0.5,
                          ),
                        })
                      : Html(
                          data: widget.jobOffer.company?.description ?? '',
                          style: {
                              "html": Style(
                                fontFamily: "Arial",
                                fontSize: const FontSize(15.0),
                                lineHeight: const LineHeight(1.7),
                                textAlign: TextAlign.justify,
                                wordSpacing: 1.0,
                                letterSpacing: 0.5,
                              ),
                            }),
                ),
              ])),
        ));
  }
}
