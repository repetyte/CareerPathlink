import 'dart:convert';
import 'package:flutter_app/models/graduates_tracer_industry/graduates_lists.dart';
import 'package:http/http.dart' as http;

class GraduatesListApiService {
  final String apiUrl = "http://localhost/UNC-CareerPathlink/api";

  // Create a Graduate
  Future<void> createGraduate(GraduatesList graduate) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/graduates/create.php'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(graduate.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create graduate entry.');
      }
    } catch (e) {
      throw Exception('Error creating graduate: $e');
    }
  }

  // Fetch Graduates List
  Future<List<GraduatesList>> fetchGraduatesList() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/graduates/read.php'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => GraduatesList.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch graduates list.');
      }
    } catch (e) {
      throw Exception('Error fetching graduates list: $e');
    }
  }

  // Update a Graduate
  Future<void> updateGraduate(GraduatesList graduate) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/graduates/update.php'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(graduate.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update graduate entry.');
      }
    } catch (e) {
      throw Exception('Error updating graduate: $e');
    }
  }
}
