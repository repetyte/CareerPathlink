import 'dart:convert';
import 'package:flutter_app/models/user_role/career_center_director.dart';
import 'package:flutter_app/models/user_role/coach_model.dart';
import 'package:flutter_app/models/user_role/college_deans.dart';
import 'package:flutter_app/models/user_role/graduate.dart';
import 'package:flutter_app/models/user_role/industry_partner.dart';
import 'package:flutter_app/models/user_role/student.dart';
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

   // Read/Fetch total student accounts
  Future<List<StudentAccount>> fetchTotalStudentAccounts() async {
    // Add your API call here to fetch total student accounts
    final response = await http.get(Uri.parse('$apiUrl/student_acc/read.php'));

    // Verifies if successfully fetched total student accounts
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => StudentAccount.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load job postings');
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

  // Read/Fetch total graduate accounts
  Future<List<GraduateAccount>> fetchTotalGraduateAccounts() async {
    // Add your API call here to fetch total graduate accounts
    final response = await http.get(Uri.parse('$apiUrl/graduate_acc/read.php'));

    // Verifies if successfully fetched total graduate accounts
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => GraduateAccount.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load job postings');
    }
  }

  // Fetch coach accounts and match user
  Future<CoachAccount?> fetchCoachAccount(
      String username, String password) async {
    final response = await http.get(Uri.parse('$apiUrl/coach_acc/read.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      final coaches = data.map((json) => CoachAccount.fromJson(json)).toList();

      // Find the matching coach account
      try {
        return coaches.firstWhere((coach) =>
            coach.username == username && coach.password == password);
      } catch (e) {
        return null; // Return null if no match is found
      }
    } else {
      throw Exception('Failed to load coach accounts');
    }
  }

  // Fetch dean accounts and match user
  Future<CollegeDeanAccount?> fetchDeanAccount(
      String username, String password) async {
    final response = await http.get(Uri.parse('$apiUrl/dean_acc/read.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      final deans =
          data.map((json) => CollegeDeanAccount.fromJson(json)).toList();

      // Find the matching dean account
      try {
        return deans.firstWhere(
            (dean) => dean.username == username && dean.password == password);
      } catch (e) {
        return null; // Return null if no match is found
      }
    } else {
      throw Exception('Failed to load dean accounts');
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
