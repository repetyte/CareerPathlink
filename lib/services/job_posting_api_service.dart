import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/models/recruitment_and_placement/job_posting.dart';

class JobPostingApiService {
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

  Future<void> updateJobPosting(JobPosting jobPosting) async {
    try{
      final response = await http.put(
        Uri.parse('$apiUrl/job_posting/update.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jobPosting.toJson()),
      );

      if (response.statusCode != 200) {
        if (kDebugMode) {
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
        throw Exception('Failed to update Job Posting.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> deleteJobPosting(int jobId) async {
    final response = await http.delete(
      // Uri.parse('$apiUrl/delete.php?job_id=$jobId'),
      Uri.parse('$apiUrl/job_posting/delete.php'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'job_id': jobId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete job posting');
    }
  }
}
