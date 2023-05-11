import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/models/job.dart';
import 'package:itflowapp/theme/app_theme.dart';
import 'package:itflowapp/widgets/custom_widgets/double_button.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:itflowapp/controllers/net_utils.dart';
import 'package:itflowapp/widgets/custom_widgets/icon_switch.dart';
import 'package:itflowapp/widgets/job_widgets/job_offer.dart';

import '../../main.dart';

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
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 9, right: 9),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: showMoreInfo,
                        child: Row(
                          children: const [
                            SizedBox(width: 20),
                            Icon(
                              Icons.info_outline,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'More Info',
                              style: TextStyle(
                                color: AppColors.green,
                                fontFamily: 'Arial',
                              ),
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder<bool>(
                        future: JobOffer.checkBookmark(widget.jobOffer.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return IconSwitch(
                              onChanged: (value) {
                                JobOffer.bookmark(widget.jobOffer.id, value);
                              },
                              iconEnabled: Icon(Icons.bookmark),
                              iconDisabled: Icon(Icons.bookmark_border),
                              isEnabled: snapshot.data!,
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
                    ]),
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
                  ),
                ),
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
                      widget.jobOffer.locations?[0].name ?? "Unknown Location",
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
                          widget.jobOffer.types?[0].name ?? "Unknown Type",
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
                        child: Row(children: [
                          const Icon(Icons.access_time, size: 13),
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
                    child: Column(
                      children: buildInfoWidget(),
                    )),
              ])),
        ));
  }

  List<Widget> buildInfoWidget() {
    if (showDescription) {
      return [
        Html(
            data: widget.jobOffer.body,
            onLinkTap: (url, _, __, ___) {
              launchURL(url!);
            },
            style: {
              "html": Style(
                fontFamily: "Arial",
                fontSize: const FontSize(15.0),
                lineHeight: const LineHeight(1.7),
                textAlign: TextAlign.justify,
                wordSpacing: 1.0,
                letterSpacing: 0.5,
              ),
            })
      ];
    } else {
      List<Widget> buttons = [];
      if (widget.jobOffer.company?.url != null) {
        buttons.add(
          IconButton(
            onPressed: () {
              launchURL(widget.jobOffer.company!.url!);
            },
            icon: const Icon(
              Icons.language,
              color: AppColors.green,
            ),
          ),
        );
      }
      if (widget.jobOffer.company?.email != null) {
        buttons.add(
          IconButton(
            onPressed: () {
              launchURL('mailto:${widget.jobOffer.company!.email}');
            },
            icon: const Icon(
              Icons.email,
              color: AppColors.green,
            ),
          ),
        );
      }
      if (widget.jobOffer.company?.phoneNumber != null) {
        buttons.add(
          IconButton(
            onPressed: () {
              launchURL('tel:${widget.jobOffer.company!.phoneNumber}');
            },
            icon: const Icon(Icons.phone, color: AppColors.green),
          ),
        );
      }
      return [
        if (buttons.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttons,
          ),
        Html(
          data: widget.jobOffer.company?.description ?? '',
          onLinkTap: (url, _, __, ___) {
            launchURL(url!);
          },
          style: {
            "html": Style(
              fontFamily: "Arial",
              fontSize: const FontSize(15.0),
              lineHeight: const LineHeight(1.7),
              textAlign: TextAlign.justify,
              wordSpacing: 1.0,
              letterSpacing: 0.5,
            ),
          },
        ),
      ];
    }
  }

  void showMoreInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Details',
            style: TextStyle(
              color: AppColors.green,
              fontFamily: 'Arial',
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                buildAttributeText(
                    'Company', widget.jobOffer.company?.name ?? ''),
                const SizedBox(height: 8),
                buildAttributeText('Title', widget.jobOffer.title),
                const SizedBox(height: 8),
                buildAttributeText(
                    'Locations',
                    widget.jobOffer.locations
                        ?.map((location) => location.name)
                        .toList()
                        .join(', ')),
                const SizedBox(height: 8),
                buildAttributeText(
                    'Types',
                    widget.jobOffer.types
                        ?.map((type) => type.name)
                        .toList()
                        .join(', ')),
                const SizedBox(height: 8),
                // map
                buildAttributeText(
                    'Contracts',
                    widget.jobOffer.contracts
                        ?.map((type) => type.name)
                        .toList()
                        .join(', ')),
                const SizedBox(height: 8),
                buildAttributeText(
                    'Wage',
                    widget.jobOffer.wage != null
                        ? '${widget.jobOffer.wage.toString()} €/year'
                        : null),
                const SizedBox(height: 8),
                buildAttributeText(
                    'Allows Remote', widget.jobOffer.allowsRemote)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildAttributeText(String attribute, dynamic value) {
    return RichText(
      text: TextSpan(
        text: '$attribute: ',
        style: const TextStyle(
          color: AppColors.green,
          fontFamily: 'Arial',
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: (value != null || value == '')
                ? value.toString()
                : 'Not specified',
            style: const TextStyle(
              color: AppColors.white,
              fontFamily: 'Arial',
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
