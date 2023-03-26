import 'dart:core';

import 'package:itflowapp/constants/it_jobs_constants.dart';
import 'package:itflowapp/models/company.dart';

class JobType {
  final String id;
  final String name;

  const JobType(this.id, this.name);

  factory JobType.fromJson(Map<String, dynamic> jsonMap) {
    return JobType(
      jsonMap['id'],
      jsonMap['name'],
    );
  }

  static List<JobType> fromJsonList(List<dynamic> list) {
    List<JobType> jobTypes = List<JobType>.empty(growable: true);
    for (var e in list) {
      Map<String, dynamic> jsonMap = e as Map<String, dynamic>;
      jobTypes.add(JobType.fromJson(jsonMap));
    }
    return jobTypes;
  }
}

class JobContract {
  final String id;
  final String name;

  const JobContract(this.id, this.name);

  factory JobContract.fromJson(Map<String, dynamic> jsonMap) {
    return JobContract(
      jsonMap['id'],
      jsonMap['name'],
    );
  }

  static List<JobContract> fromJsonList(List<dynamic> list) {
    List<JobContract> jobContracts = List<JobContract>.empty(growable: true);
    for (var e in list) {
      Map<String, dynamic> jsonMap = e as Map<String, dynamic>;
      jobContracts.add(JobContract.fromJson(jsonMap));
    }
    return jobContracts;
  }
}

class JobLocation {
  final String id;
  final String name;

  const JobLocation(this.id, this.name);

  factory JobLocation.fromJson(Map<String, dynamic> jsonMap) {
    return JobLocation(
      jsonMap['id'],
      jsonMap['name'],
    );
  }

  static List<JobLocation> fromJsonList(List<dynamic> list) {
    List<JobLocation> jobLocations = List<JobLocation>.empty(growable: true);
    for (var e in list) {
      Map<String, dynamic> jsonMap = e as Map<String, dynamic>;
      jobLocations.add(JobLocation.fromJson(jsonMap));
    }
    return jobLocations;
  }
}

class Job {
  final int id;
  final Company company;
  final int companyId;
  final String title;
  final String body;
  final String? ref;
  final int? wage;
  final List<JobType>? types;
  final List<JobContract>? contracts;
  final List<JobLocation>? locations;
  final bool allowsRemote;
  final DateTime publishedAt;
  final DateTime updatedAt;
  final String slug;

  const Job(
    this.id,
    this.company,
    this.companyId,
    this.title,
    this.body,
    this.ref,
    this.wage,
    this.types,
    this.contracts,
    this.locations,
    this.allowsRemote,
    this.publishedAt,
    this.updatedAt,
    this.slug,
  );

  factory Job.fromJson(Map<String, dynamic> jsonMap) {
    return Job(
      jsonMap['id'],
      Company.fromJson(jsonMap['company']),
      jsonMap['companyId'],
      jsonMap['title'],
      jsonMap['body'],
      jsonMap['ref']?.toString(),
      jsonMap['wage'],
      jsonMap.containsKey('types')
          ? JobType.fromJsonList(jsonMap['types'])
          : null,
      jsonMap.containsKey('contracts')
          ? JobContract.fromJsonList(jsonMap['contracts'])
          : null,
      jsonMap.containsKey('locations') ?
      JobLocation.fromJsonList(jsonMap['locations']) : null,
      jsonMap.containsKey('allowRemote') ? jsonMap['allowRemote'] : false,
      DateTime.parse(jsonMap['publishedAt']),
      DateTime.parse(jsonMap['updatedAt']),
      jsonMap['slug'],
    );
  }

  static List<Job> fromJsonList(List<dynamic> list) {
    List<Job> jobs = List<Job>.empty(growable: true);
    for (var e in list) {
      Map<String, dynamic> jsonMap = e as Map<String, dynamic>;
      jobs.add(Job.fromJson(jsonMap));
    }
    return jobs;
  }
}
