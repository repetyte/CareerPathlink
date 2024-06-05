import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_app/models/job_posting.dart';

class ApiService {
  final String apiUrl = "http://localhost/recruitment_and_placement/api";

  Future<List<JobPosting>> fetchJobPostings() async {
    final response = await http.get(Uri.parse('$apiUrl/read.php'));

    if (response.statusCode == 200) {
      print("Response Body: ${response.body}"); // Log response body
      List jsonResponse = json.decode(response.body)['records'];
      return jsonResponse.map((job) => JobPosting.fromJson(job)).toList();
    } else {
      print("Failed to load job postings: ${response.statusCode}");
      print("Response Body: ${response.body}");
      throw Exception('Failed to load job postings');
    }
  }

  Future<void> createJobPosting(JobPosting jobPosting) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create.php'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(jobPosting.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create job posting');
    }
  }

  Future<void> updateJobPosting(JobPosting jobPosting) async {
    final response = await http.put(
      Uri.parse('$apiUrl/update.php'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(jobPosting.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update job posting');
    }
  }

  Future<void> deleteJobPosting(int jobId) async {
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
