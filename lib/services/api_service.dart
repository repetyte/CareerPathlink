import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_app/models/job_posting.dart';

class ApiService {
  final String apiUrl = "http://localhost/recruitment_and_placement/api";

  // Create and Post new job posting
  Future<void> postJobPosting(JobPosting jobPosting) async {
    final url = '$apiUrl/create.php';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'jobTitle': jobPosting.jobTitle,
        'jobStatus': jobPosting.jobStatus,
        'fieldIndustry': jobPosting.fieldIndustry,
        'jobLevel': jobPosting.jobLevel,
        'yrsOfExperienceNeeded': jobPosting.yrsOfExperienceNeeded,
        'contractualStatus': jobPosting.contractualStatus,
        'salary': jobPosting.salary,
        'jobLocation': jobPosting.jobLocation,
        'jobDescription': jobPosting.jobDescription,
        'requirements': jobPosting.requirements,
        'jobResponsibilities': jobPosting.jobResponsibilities,
        'industryPartner': jobPosting.industryPartner,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to post job posting');
    }
  }

  // Read/Fetch new job posting
  Future<List<JobPosting>> fetchJobPostings() async {
    final response = await http.get(Uri.parse('$apiUrl/read.php'));

    if (response.statusCode == 200) {
      // print("Response Body: ${response.body}"); // Log response body
      List jsonResponse = json.decode(response.body)['records'];
      return jsonResponse.map((job) => JobPosting.fromJson(job)).toList();
    } else {
      // print("Failed to load job postings: ${response.statusCode}");
      // print("Response Body: ${response.body}");
      throw Exception('Failed to load job postings');
    }
  }

  // Update new job posting
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

  // Delete new job posting
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

  Future<void> createJobPosting(JobPosting jobPosting) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create.php'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(jobPosting.toJson()),
    );

    if (response.statusCode != 201) {
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      throw Exception('Failed to create job posting');
    }
  }
}
