import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Apply filters here'),
      ),
    );
  }
}