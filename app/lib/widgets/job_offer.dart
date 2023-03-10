import 'package:flutter/material.dart';
import 'package:itflowapp/theme/app_theme.dart';

class JobOffer extends StatelessWidget {
  final String _hirer; //hirer name
  final String _location; //city and country
  final String _type; // part-time or full-time
  final String _job; // ex: React-developer or engineer
  final Icon _logo; // hirer logo
  const JobOffer({
    Key? key,
    String hirer='',
    String location='',
    String type='',
    String job='',
    Icon logo= const Icon(size:50,Icons.assignment_late_rounded),

  }): _hirer=hirer,
      _location=location,
      _type=type,
      _job=job,
      _logo=logo,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),color: AppColors.black),
      width:screenWidth*0.9 ,
      height:screenHeight*0.15,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Row( //upper section
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Row( //logo and texts row
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _logo,
                      SizedBox(width:5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:[
                          Text(_hirer),
                          Text(_job,style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.bookmark),
                ], 
              ),
            ),
            Expanded(
              child: Row( //lower section
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Align(
                    alignment:Alignment.centerLeft ,
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 10,),
                        Text(_location),
                      ],
                    )
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(_type)
                  ),
                ], 
              ),
            ),
          ],
        ),
      ),
    );
  }
}