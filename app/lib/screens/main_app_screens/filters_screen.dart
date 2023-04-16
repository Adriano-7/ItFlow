import 'package:flutter/material.dart';
import '../../main.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool isPartTimeSelected = false;
  bool isFullTimeSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: InkWell(onTap: () {Navigator.pushReplacementNamed(context, Routes.home);},
            child: Image.asset('assets/images/logo.png', height: 30,),
          )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Text(
              'Filters',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Company name',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search company',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Type of Job',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isPartTimeSelected = true;
                            isFullTimeSelected = false;
                          });
                        },
                        child: Text('Part time'),
                        style: ElevatedButton.styleFrom(
                          primary: isPartTimeSelected
                              ? Colors.green
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isPartTimeSelected = false;
                            isFullTimeSelected = true;
                          });
                        },
                        child: Text('Full time'),
                        style: ElevatedButton.styleFrom(
                          primary: isFullTimeSelected
                              ? Colors.green
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                ],
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Discard'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Apply'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

