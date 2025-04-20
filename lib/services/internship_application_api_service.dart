import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/models/work_integrated_learning/internship_application.dart';
import 'package:http/http.dart' as http;

class InternshipApplicationApiService {
  final String apiUrl = "http://localhost/UNC-CareerPathlink/api";

  // Create WIL Opportunity Application
  Future<void> createInternshipApplication(InternshipApplication internshipApplication) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/internship_application/create.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(internshipApplication.toJson()),
      );

      if (response.statusCode != 201) {
        if (kDebugMode) {
          debugPrint('Response status: ${response.statusCode}');
          debugPrint('Response body: ${response.body}');
        }
        throw Exception('Failed to create WIL Opportunity Application.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Exception: $e');
      }
      throw Exception('Failed to connect to the server');
    }
  }

  // Read/Fetch internship applications
  Future<List<InternshipApplicationComplete>> fetchInternshipApplications() async {
    // Add your API call here to fetch internship postings
    final response = await http.get(Uri.parse('$apiUrl/internship_application/read.php'));

    // Verifies if successfully fetched internship postings
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => InternshipApplicationComplete.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load internship postings');
    }
  }

  Future<void> updateInternshipApplication(InternshipApplication internshipApplication) async {
    // try{
    //   final response = await http.put(
    //     Uri.parse('$apiUrl/internship_application/update.php'),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(internshipApplication.toJson()),
    //   );

    //   if (response.statusCode != 200) {
    //     if (kDebugMode) {
    //       debugPrint('Response status: ${response.statusCode}');
    //       debugPrint('Response body: ${response.body}');
    //     }
    //     throw Exception('Failed to update WIL Opportunity Posting.');
    //   }
    // } catch (e) {
    //   if (kDebugMode) {
    //     debugPrint('Exception: $e');
    //   }
    //   throw Exception('Failed to connect to the server');
    // }
  }

  Future<void> deleteInternshipApplication(int internshipId) async {
    // final response = await http.delete(
    //   // Uri.parse('$apiUrl/delete.php?internship_id=$internshipId'),
    //   Uri.parse('$apiUrl/internship_application/delete.php'),
    //   headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
    //   body: jsonEncode({'internship_id': internshipId}),
    // );
    // if (response.statusCode != 200) {
    //   throw Exception('Failed to delete internship posting');
    // }
  }
}
