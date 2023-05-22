import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:itflowapp/controllers/itjobs/it_jobs_api.dart';

class CompanySearchWidget extends StatefulWidget {
  final void Function(String)? onSearch;
  final void Function(int)? onCompanySelected;

  const CompanySearchWidget({Key? key, this.onSearch, this.onCompanySelected}) : super(key: key);

  @override
  _CompanySearchWidgetState createState() => _CompanySearchWidgetState();
}

class _CompanySearchWidgetState extends State<CompanySearchWidget> {
  late TextEditingController _searchController;
  int? _selectedCompanyId;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selectedCompanyId = null;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for a company',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
      ),
      suggestionsCallback: (pattern) async {
        final companySearch = await ItJobsApiController.searchCompanies(pattern);
        if (companySearch.results.isEmpty) {return const []; }
        return companySearch.results;
      },
      itemBuilder: (context, suggestion) {
        if (suggestion == null || suggestion.name == null) {return const Text('No results found');}
        return ListTile(title: Text(suggestion.name),);
        },
      onSuggestionSelected: (suggestion) {
        if (suggestion != null && suggestion.id != null) {
          _searchController.text = suggestion.name!;
          _selectedCompanyId = suggestion.id;
          widget.onSearch!(_searchController.text);
          widget.onCompanySelected!(_selectedCompanyId!);
        }
      },
    );
  }
}
