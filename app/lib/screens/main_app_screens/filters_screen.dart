import 'package:flutter/material.dart';
import 'package:itflowapp/theme/app_theme.dart';
import '../../main.dart';
import '../../widgets/double_button.dart';


class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key, required Map<String, dynamic> filters}) : super(key: key);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool isPartTimeSelected = false;
  bool isFullTimeSelected = false;

  //Text controller
  final TextEditingController _companyNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.home);
            },
            child: Image.asset(
              'assets/images/logo.png',
              height: 30,
            ),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Text('Filters', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Company name',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search company',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  controller: _companyNameController,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Type of Job',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                DoubleButton(
                  onPressedFirst: () { setState(() {isPartTimeSelected = true; isFullTimeSelected = false;});},
                  childFirst: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 0),
                    child: Text('Part Time', style: TextStyle(fontSize: 15,)),),
                  onPressedSecond: () {setState(() {isFullTimeSelected = true;isPartTimeSelected = false;});
                  },
                  childSecond: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 0),
                    child: Text('Full Time', style: TextStyle(fontSize: 15,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: ElevatedButton(
          onPressed: () {
            print('isFullTimeSelected: $isFullTimeSelected');
            print('isPartTimeSelected: $isPartTimeSelected');
            print('company name: ${_companyNameController.text}');

            Navigator.pushReplacementNamed(context, Routes.search,
              arguments: {
                'type': isFullTimeSelected ? 1 : isPartTimeSelected ? 0 : null,
                //'company': To be implemented
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.green,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Submit'),
        ),
      ),
    );
  }
}
