import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/models/industry_partner.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/models/job_posting.dart';

class ApiService {
  final String apiUrl = "http://localhost/final/api";

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
        throw Exception('Failed to create Job Posting');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      throw Exception('Failed to connect to the server');
    }
  }

  // Read/Fetch job postings
  Future<List<JobPosting>> fetchJobPostings() async {
    // final response = await http.get(Uri.parse('$apiUrl/job_posting/read.php'));
    final response = await http.get(
        Uri.parse('http://localhost/recruitment_and_placement/api/read.php'));

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
      }
      // print("Response Body: ${response.body}"); // Log response body
      List jsonResponse = json.decode(response.body)['records'];
      return jsonResponse.map((job) => JobPosting.fromJson(job)).toList();
    } else {
      if (kDebugMode) {
        print("Failed to load job postings: ${response.statusCode}");
      }
      // print("Response Body: ${response.body}");
      throw Exception('Failed to load job postings');
    }
  }

  Future<List<IndustryPartner>> fetchIndustryPartners() async {
    // Add your API call here to fetch industry partners
    // For example:
    final response =
        await http.get(Uri.parse('$apiUrl/industry_partner/read.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => IndustryPartner.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load industry partners');
    }
  }

  Future<void> updateJobPosting(JobPosting jobPosting) async {
    final response = await http.put(
      Uri.parse('$apiUrl/update.php'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(jobPosting.toJson()),
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
