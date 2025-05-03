import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/models/work_integrated_learning/internship.dart';

class InternshipApiService {
  final String apiUrl = "http://localhost/CareerPathlink/api";

  // Read all internships
  Future<List<InternshipWithPartner>> fetchInternships() async {
    try {
      // Await the http get response, then decode the json-formatted response.
      final response = await http.get(Uri.parse('$apiUrl/internship/read.php'));

      // If the server returns a 200 OK response,
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body
            .map((json) => InternshipWithPartner.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load internships');
      }
    } catch (e) {
      // If the server returns an error.
      if (kDebugMode) {
        debugPrint('Exception: $e');
      }
      throw Exception('There is a problem from the server. Failed to connect.');
    }
  }

  // Create internship
  Future<void> createInternship(Internship internship) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/internship/create.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(internship.toJson()),
      );

      if (response.statusCode != 201) {
        if (kDebugMode) {
          debugPrint('Response status: ${response.statusCode}');
          debugPrint('Response body: ${response.body}');
        }
        throw Exception('Failed to create internship.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Exception: $e');
      }
      throw Exception('There is a problem from the server. Failed to connect.');
    }
  }

  // Update internship
  Future<void> updateInternship(Internship internship) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/internship/update.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(internship.toJson()),
      );

      if (response.statusCode != 200) {
        if (kDebugMode) {
          debugPrint('Response status: ${response.statusCode}');
          debugPrint('Response body: ${response.body}');
        }
        throw Exception('Failed to update intrership.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Exception: $e');
      }
      throw Exception('There is a problem from the server. Failed to connect.');
    }
  }

  // Delete internship
  Future<void> deleteInternship(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/internship/delete.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'internship_id': id}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete internship.');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Exception: $e');
      }
      throw Exception('There is a problem from the server. Failed to connect.');
    }
  }
}
