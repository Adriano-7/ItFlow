import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itflowapp/models/company.dart';
import 'package:itflowapp/models/job.dart';

class ItJobsApiController {
  static const _apiKey = "1965a7ffa1c0d3e880f6aaf4e2d41dbd";
  static const _jobRootUrl = "https://api.itjobs.pt/job/";
  static const _compRootUrl = "https://api.itjobs.pt/company/";

  static Future<Map<String, dynamic>> _apiCall(Uri uri) async {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // All good!
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get Job.');
    }
  }

  static Future<JobGet> getJob(int id) async {
    final uri = Uri.parse("${_jobRootUrl}get.json?api_key=$_apiKey&id=$id");
    final jsonMap = await _apiCall(uri);
    return JobGet.fromJson(jsonMap);
  }

  static Future<JobList> listJobs(
      {int limit = 10, int page = 1, int? company, int? type}) async {
    String optional = '';
    if (company != null) optional += '&company=$company';
    if (type != null) optional += '&type=$type';
    final uri = Uri.parse(
        "${_jobRootUrl}list.json?api_key=$_apiKey&limit=$limit&page=$page$optional");
    final jsonMap = await _apiCall(uri);
    return JobList.fromJson(jsonMap);
  }

  static Future<JobSearch> searchJobs(String query, Map<String, dynamic> filters, {int page = 1}) async {
    String optional = '';
    int limit = 200;

    if (filters['company'] != null) {optional += '&company=${filters['company']}';}
    if (filters['type'] != null) optional += '&type=${filters['type']}';
    if (filters['location'] != null) optional += '&location=${filters['location']}';
    if (filters['contract'] != null) optional += '&contract=${filters['contract']}';

    final uri = Uri.parse("${_jobRootUrl}search.json?api_key=$_apiKey&q=$query&limit=$limit&page=$page$optional");
    final jsonMap = await _apiCall(uri);
    final JobSearch results = JobSearch.fromJson(jsonMap);

    
    if (filters['language'] != null) {
      List<Job> filteredResults = [];
      for (Job job in results.results) {
        String title = job.title.toLowerCase();
        String body = job.body.toLowerCase();
        String languageLower = filters['language'].toLowerCase();

        if (title.contains(languageLower) || body.contains(languageLower)) {
          filteredResults.add(job);
        }
      }
      results.results = filteredResults;
    }    

    return results;
  }

  static Future<Company> getCompany(String slug) async {
    final uri = Uri.parse("${_compRootUrl}get.json?api_key=$_apiKey&slug=$slug");
    final jsonMap = await _apiCall(uri);
    return Company.fromJson(jsonMap);
  }

  static Future<CompanySearch> searchCompanies(String query, {int limit = 10, int page = 1}) async {
    final uri = Uri.parse("${_compRootUrl}search.json?api_key=$_apiKey&q=$query&limit=$limit&page=$page");
    final jsonMap = await _apiCall(uri);
    return CompanySearch.fromJson(jsonMap);
  }
}

// === Return Classes === //

// Jobs

class JobGet {
  final Job? job;
  final bool _status;
  // false - it's well formed.
  // true - an error occurred.
  final String? errorMessage;

  bool get errorOccurred => _status;

  JobGet(
    this.job,
  )   : _status = false,
        errorMessage = null;

  JobGet.error(
    this.errorMessage,
  )   : _status = true,
        job = null;

  factory JobGet.fromJson(Map<String, dynamic> jsonMap) {
    if (jsonMap.containsKey('error')) {
      return JobGet.error(jsonMap['error']['message']);
    }
    return JobGet(Job.fromJson(jsonMap));
  }
}

class JobList {
  final int total;
  final int page;
  final int limit;
  final List<Job>? results;

  JobList(
    this.total,
    this.page,
    this.limit,
    this.results,
  );

  factory JobList.fromJson(Map<String, dynamic> jsonMap) {
    return JobList(
      jsonMap['total'],
      jsonMap['page'],
      jsonMap['limit'],
      jsonMap.containsKey('results')
          ? Job.fromJsonList(jsonMap['results'])
          : null,
    );
  }
}

class JobSearch {
  final int total;
  final int page;
  final int limit;
  final String query;
  List<Job> results;

  JobSearch(
    this.total,
    this.page,
    this.limit,
    this.query,
    this.results,
  );

  factory JobSearch.fromJson(Map<String, dynamic> jsonMap) {
    if(jsonMap['query'] == null) jsonMap['query'] = '';
    return JobSearch(
      jsonMap['total'],
      jsonMap['page'],
      jsonMap['limit'],
      jsonMap['query'],
      Job.fromJsonList(jsonMap['results']),
    );
  }

  List<Job> get jobs => results;
  int get length => results.length;
}

// Companies

class CompanySearch {
  final int total;
  final int page;
  final int limit;
  final String query;
  final List<Company> results;

  CompanySearch(
    this.total,
    this.page,
    this.limit,
    this.query,
    this.results,
  );

  factory CompanySearch.fromJson(Map<String, dynamic> jsonMap) {
    if(jsonMap['query'] == null) return CompanySearch(0, 0, 0, '', []);
    if(jsonMap['results'] == null) jsonMap['results'] = [];

    return CompanySearch(
      jsonMap['total'],
      jsonMap['page'],
      jsonMap['limit'],
      jsonMap['query'],
      Company.fromJsonList(jsonMap['results']),
    );
  }
}
