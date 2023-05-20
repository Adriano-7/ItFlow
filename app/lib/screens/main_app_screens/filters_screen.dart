import 'package:flutter/material.dart';

import 'package:itflowapp/constants/constants.dart';
import 'package:itflowapp/main.dart';
import 'package:itflowapp/widgets/custom_widgets/double_button.dart';
import 'package:itflowapp/constants/it_jobs_constants.dart';
import 'package:itflowapp/widgets/job_widgets/company_search.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key, required Map<String, dynamic> filters})
      : super(key: key);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int jobTypeSelected = 0;
  int locationSelected = 0;
  int contractTypeSelected = 0;
  int? _selectedCompanyId = 0;

  final List<String> _jobTypeOptions = jobTypeToInt.keys.toList();
  final List<String> _locationOptions = locationToInt.keys.toList();
  final List<String> _contractTypeOptions = jobContractToInt.keys.toList();

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
            child: Hero(
              tag: kLogoHeroTag,
              child: Image.asset(kLogoImageAssetPath, height: 30),
            ),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
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
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Filter by Company',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                CompanySearchWidget(
                  onSearch: (String companyName) {
                    _companyNameController.text = companyName;
                  },
                  onCompanySelected: (int companyId) {
                    _selectedCompanyId = companyId;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 8),
                  child: Text(
                    'Filter by type of Job',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                DropdownButton<String>(
                  value: _jobTypeOptions[jobTypeSelected],
                  menuMaxHeight: 300,
                  items: _jobTypeOptions
                      .map((String option) => DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    if (mounted) {
                      setState(() {
                        jobTypeSelected = _jobTypeOptions.indexOf(value!);
                      });
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 8),
                  child: Text(
                    'Filter by location',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                DropdownButton<String>(
                  value: _locationOptions[locationSelected],
                  menuMaxHeight: 300,
                  items: _locationOptions
                      .map((String option) => DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    if (mounted) {
                      setState(() {
                        locationSelected = _locationOptions.indexOf(value!);
                      });
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 8),
                  child: Text(
                    'Filter by type of contract',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                DropdownButton<String>(
                  value: _contractTypeOptions[contractTypeSelected],
                  menuMaxHeight: 300,
                  items: _contractTypeOptions
                      .map((String option) => DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    if (mounted) {
                      setState(() {
                        contractTypeSelected =
                            _contractTypeOptions.indexOf(value!);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: DoubleButton(
          onPressedFirst: () {
            Navigator.pushReplacementNamed(context, Routes.search);
          },
          childFirst: const Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 0),
            child: Text('Discard',
                style: TextStyle(
                  fontSize: 15,
                )),
          ),
          onPressedSecond: () {
            Navigator.pushReplacementNamed(
              context,
              Routes.search,
              arguments: {
                if (_selectedCompanyId != 0 && _selectedCompanyId != null) 'company': _selectedCompanyId,
                if (jobTypeSelected != 0) 'type': jobTypeSelected,
                if (locationSelected != 0) 'location': locationSelected,
                if (contractTypeSelected != 0) 'contract': contractTypeSelected,
              },
            );
          },
          childSecond: const Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 0),
            child: Text(
              'Apply',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
