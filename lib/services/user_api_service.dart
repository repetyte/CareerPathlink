import 'dart:convert';
import 'package:flutter_app/models/graduate.dart';
import 'package:flutter_app/models/industry_partner.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  final String apiUrl =
      'http://localhost/UNC-CareerPathlink/api/user_authentication';

  // Fetch graduate accounts and match user
  Future<GraduateAccount?> fetchGraduateAccount(
      String username, String password) async {
    final response =
        await http.get(Uri.parse('$apiUrl/graduate_acc/read.php'));

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
}
