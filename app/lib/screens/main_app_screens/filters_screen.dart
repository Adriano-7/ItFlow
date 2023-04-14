import 'package:flutter/material.dart';
import 'package:itflowapp/constants/constants.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Apply filters here'),
      ),
    );
  }
}