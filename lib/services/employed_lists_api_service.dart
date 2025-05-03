import 'dart:convert';
import 'package:flutter_app/models/graduates_tracer_industry/employed_lists.dart';
import 'package:http/http.dart' as http;

class EmployedListsApiService {
  final String apiUrl = "http://localhost/CareerPathlink/api";

  // Create an Employed Record
  Future<void> createEmployedRecord(EmployedLists employed) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/employed/create_employed.php'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(employed.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create employed record.');
      }
    } catch (e) {
      throw Exception('Error creating employed record: $e');
    }
  }

  // Fetch Employed Records List
  Future<List<EmployedLists>> fetchEmployedList() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/employed/read_employed.php'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => EmployedLists.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch employed records list.');
      }
    } catch (e) {
      throw Exception('Error fetching employed records list: $e');
    }
  }

  // Update an Employed Record
  Future<void> updateEmployedRecord(EmployedLists employed) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/employed/update_employed.php'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(employed.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update employed record.');
      }
    } catch (e) {
      throw Exception('Error updating employed record: $e');
    }
  }

  // Delete an Employed Record
  Future<void> deleteEmployedRecord(int studentNo) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/employed/delete_employed.php?student_no=$studentNo'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete employed record.');
      }
    } catch (e) {
      throw Exception('Error deleting employed record: $e');
    }
  }
}
