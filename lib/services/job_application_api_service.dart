import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_application.dart';
import 'package:http/http.dart' as http;

class JobApplicationApiService {
  final String apiUrl = "http://localhost/CareerPathlink/api";

  // Create Job Application
  Future<void> createJobApplication(JobApplication jobApplication) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/job_application/create.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jobApplication.toJson()),
      );

      if (response.statusCode != 201) {
        if (kDebugMode) {
          debugPrint('Response status: ${response.statusCode}');
          debugPrint('Response body: ${response.body}');
        }
        throw Exception('Failed to create Job Application.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Exception: $e');
      }
      throw Exception('Failed to connect to the server');
    }
  }

  // Read/Fetch job applications
  Future<List<JobApplicationComplete>> fetchJobApplications() async {
    // Add your API call here to fetch job postings
    final response = await http.get(Uri.parse('$apiUrl/job_application/read.php'));

    // Verifies if successfully fetched job postings
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => JobApplicationComplete.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load job postings');
    }
  }

  Future<void> updateJobApplication(JobApplicationComplete jobApplicationComplete) async {
    try{
      final response = await http.put(
        Uri.parse('$apiUrl/job_application/update.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jobApplicationComplete.toJson()),
      );

      if (response.statusCode != 200) {
        if (kDebugMode) {
          debugPrint('Response status: ${response.statusCode}');
          debugPrint('Response body: ${response.body}');
        }
        throw Exception('Failed to update Job Application.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Exception: $e');
      }
      throw Exception('Failed to connect to the server');
    }
  }
}
