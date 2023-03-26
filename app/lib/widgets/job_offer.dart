import 'dart:math';

import 'package:flutter/material.dart';
import 'package:itflowapp/models/job.dart';
import 'package:itflowapp/theme/app_theme.dart';
import 'package:itflowapp/widgets/icon_switch.dart';

class JobOffer extends StatelessWidget {
  static const double _logoWidthPercentage = 0.15;
  static const double _logoHeightPercentage = 0.10;
  static const double _titlePercentage = 0.50;
  static const double _cardHeight = 100;

  final String _hirer; //hirer name
  final String _location; //city and country
  final String _type; // part-time or full-time
  final String _job; // ex: React-developer or engineer
  late final Image _logo; // hirer logo

  JobOffer({
    Key? key,
    String hirer = '',
    String location = '',
    String type = '',
    String job = '',
    Image? logo,
  })  : _hirer = hirer,
        _location = location,
        _type = type,
        _job = job,
        super(key: key) {
    _logo = logo ??
        Image.network(
          'https://i.scdn.co/image/ab67616d0000b2734e57c459c44ad93020529594',
          scale: 10,
        );
  }

  factory JobOffer.fromJob(Job job) {
    return JobOffer(
      hirer: job.company.name,
      location: job.locations == null ? '' : job.locations![0].name,
      type: job.types == null ? '' : job.types![0].name,
      job: job.title,
      logo: Image.network(job.company.logoUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: AppColors.black,
      ),
      width: screenWidth * 0.9,
      height: _cardHeight,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Align(
              // LOGO
              alignment: Alignment.topLeft,
              child: Container(
                height: screenWidth * _logoHeightPercentage,
                width: screenWidth * _logoWidthPercentage,
                decoration:  BoxDecoration(
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
                  maxHeight: _cardHeight * 0.5,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        _hirer,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _job,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 18),
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
              child: Text(_type),
            ),
          ],
        ),
      ),
    );
  }
}
