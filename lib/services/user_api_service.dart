import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApiService {
  final String baseUrl = 'http://your-api-url.com'; // Replace with your API base URL

  // Authenticate user
  Future<bool> authenticateUser({
    required String username,
    required String password,
    required String userType,
  }) async {
    final endpoint = userType == 'Graduate'
        ? '/auth/graduates' // Replace with your actual API endpoint for graduates
        : '/auth/partners'; // Replace with your actual API endpoint for industry partners

    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Check if authentication was successful
      return data['success'];
    } else {
      throw Exception('Failed to authenticate user');
    }
  }
}
