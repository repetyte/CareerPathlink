import 'dart:convert';
import 'package:flutter_app/models/graduate.dart';
import 'package:flutter_app/models/industry_partner.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  final String baseUrl =
      'http://localhost/UNC-CareerPathlink/api/user_authentication';

  // Fetch graduate accounts
  Future<List<GraduateAccount>> fetchGraduateAccounts() async {
    final response = await http.get(Uri.parse('$baseUrl/graduates_acc/read.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => GraduateAccount.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch Graduate accounts');
    }
  }

  // Fetch industry partner accounts
  Future<List<IndustryPartnerAccount>> fetchIndustryPartners() async {
    final response =
        await http.get(Uri.parse('$baseUrl/employers_acc/read.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => IndustryPartnerAccount.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch Industry Partner accounts');
    }
  }
}