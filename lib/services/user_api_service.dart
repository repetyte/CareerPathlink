import 'dart:convert';
import 'package:flutter_app/models/career_center_director.dart';
import 'package:flutter_app/models/graduate.dart';
import 'package:flutter_app/models/industry_partner.dart';
import 'package:flutter_app/models/student.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  final String apiUrl =
      'http://localhost/UNC-CareerPathlink/api/user_authentication';

  // Fetch student accounts and match user
  Future<StudentAccount?> fetchStudentAccount(
      String username, String password) async {
    final response = await http.get(Uri.parse('$apiUrl/student_acc/read.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      final students =
          data.map((json) => StudentAccount.fromJson(json)).toList();

      // Find the matching student account
      try {
        return students.firstWhere((student) =>
            student.username == username && student.password == password);
      } catch (e) {
        return null; // Return null if no match is found
      }
    } else {
      throw Exception('Failed to load student accounts');
    }
  }

  // Fetch graduate accounts and match user
  Future<GraduateAccount?> fetchGraduateAccount(
      String username, String password) async {
    final response = await http.get(Uri.parse('$apiUrl/graduate_acc/read.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      final graduates =
          data.map((json) => GraduateAccount.fromJson(json)).toList();

      // Find the matching graduate account
      try {
        return graduates.firstWhere(
            (grad) => grad.username == username && grad.password == password);
      } catch (e) {
        return null; // Return null if no match is found
      }
    } else {
      throw Exception('Failed to load graduate accounts');
    }
  }

// Fetch industry partner accounts and match user
  Future<IndustryPartnerAccount?> fetchIndustryPartnerAccount(
      String username, String password) async {
    final response =
        await http.get(Uri.parse('$apiUrl/emp_partner_acc/read.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      final partners =
          data.map((json) => IndustryPartnerAccount.fromJson(json)).toList();

      // Find the matching industry partner account
      try {
        return partners.firstWhere((partner) =>
            partner.username == username && partner.password == password);
      } catch (e) {
        return null; // Return null if no match is found
      }
    } else {
      throw Exception('Failed to load industry partner accounts');
    }
  }

  // Fetch director accounts and match user
  Future<CareerCenterDirectorAccount?> fetchDirectorAccount(
      String username, String password) async {
    final response = await http.get(Uri.parse('$apiUrl/ccd_acc/read.php'));

    if (response.statusCode == 200) {
      // Check if the request was successful
      List<dynamic> data = jsonDecode(response.body);
      final directors = data
          .map((json) => CareerCenterDirectorAccount.fromJson(json))
          .toList();

      // Find the matching director account
      try {
        return directors.firstWhere((director) =>
            director.username == username && director.password == password);
      } catch (e) {
        return null; // Return null if no match is found
      }
    } else {
      throw Exception('Failed to load director accounts');
    }
  }

  Future<void> logout() async {
    final response = await http.get(Uri.parse('$apiUrl/logout.php'));
    if (response.statusCode != 200) {
      throw Exception('Failed to logout');
    }
  }
}
