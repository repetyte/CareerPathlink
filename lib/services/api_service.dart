import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/models/industry_partner.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/models/job_posting.dart';

class ApiService {
  final String apiUrl = "http://localhost/UNC-CareerPathlink/api";

  // Create Job Posting
  Future<void> createJobPosting(JobPosting jobPosting) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/job_posting/create.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jobPosting.toJson()),
      );

      if (response.statusCode != 201) {
        if (kDebugMode) {
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
        throw Exception('Failed to create Job Posting.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      throw Exception('Failed to connect to the server');
    }
  }

  // Read/Fetch job postings
  Future<List<JobPostingWithPartner>> fetchJobPostings() async {
    // Add your API call here to fetch job postings
    final response = await http.get(Uri.parse('$apiUrl/job_posting/read.php'));

    // Verifies if successfully fetched job postings
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => JobPostingWithPartner.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load job postings');
    }
  }

  // Read/Fetch Industry Partners
  Future<List<IndustryPartner>> fetchIndustryPartners() async {
    // Add your API call here to fetch industry partners
    final response = await http.get(Uri.parse('$apiUrl/industry_partner/read.php'));

    // Verifies if successfully fetched job postings
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => IndustryPartner.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load industry partners');
    }
  }

  Future<void> updateJobPosting(JobPostingWithPartner jobPostingWithPartner) async {
    final response = await http.put(
      Uri.parse('$apiUrl/update.php'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(jobPostingWithPartner.toJson()),
    );
    if (response.statusCode != 200) {
      if (kDebugMode) {
        print("Failed to update job");
      }
      throw Exception('Failed to update job posting');
    }
  }

  Future<void> deleteJobPosting(int? jobId) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/delete.php?job_id=$jobId'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode({'Job_ID': jobId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete job posting');
    }
  }
}
