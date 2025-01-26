import 'dart:convert';
import 'package:flutter_app/models/graduates_tracer_industry/UnemployedLists.dart';
import 'package:http/http.dart' as http;

class UnemployedListsApiService {
  final String apiUrl = "http://localhost/graduates_tracer/api";

  // Create an Unemployed Record
  Future<void> createUnemployedRecord(UnemployedLists unemployed) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/unemployed/create_unemployed.php'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(unemployed.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create unemployed record.');
      }
    } catch (e) {
      throw Exception('Error creating unemployed record: $e');
    }
  }

  // Fetch Unemployed Records List
  Future<List<UnemployedLists>> fetchUnemployedList() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/unemployed/read_unemployed.php'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => UnemployedLists.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch unemployed records list.');
      }
    } catch (e) {
      throw Exception('Error fetching unemployed records list: $e');
    }
  }

  // Update an Unemployed Record
  Future<void> updateUnemployedRecord(UnemployedLists unemployed) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/unemployed/update_unemployed.php'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(unemployed.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update unemployed record.');
      }
    } catch (e) {
      throw Exception('Error updating unemployed record: $e');
    }
  }

  // Delete an Unemployed Record
  Future<void> deleteUnemployedRecord(int studentNo) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/unemployed/delete_unemployed.php?student_no=$studentNo'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete unemployed record.');
      }
    } catch (e) {
      throw Exception('Error deleting unemployed record: $e');
    }
  }
}
