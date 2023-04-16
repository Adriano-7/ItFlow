import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';

import '../../main.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: InkWell(onTap: () {Navigator.pushReplacementNamed(context, Routes.home);},
            child: Image.asset('assets/images/logo.png', height: 30,),
          )
      ),
      body: Center(
        child: Text('Apply filters here'),
      ),
    );
  }
}