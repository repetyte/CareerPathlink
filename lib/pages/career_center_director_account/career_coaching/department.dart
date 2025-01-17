import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Department extends StatefulWidget {
  final double screenWidth;

  const Department({super.key, required this.screenWidth});

  @override
  _DepartmentState createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  late Future<List<Map<String, dynamic>>> _departmentsFuture;

  @override
  void initState() {
    super.initState();
    _departmentsFuture = fetchDepartmentData();
  }

  Future<List<Map<String, dynamic>>> fetchDepartmentData() async {
    try {
      final response = await http.get(
          Uri.parse('http://localhost/UNC-CareerPathlink/api/career_coaching/read_department.php'));

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);

        if (decodedResponse is Map && decodedResponse.containsKey('data')) {
          List<dynamic> data = decodedResponse['data'];
          return data.map((json) => Map<String, dynamic>.from(json)).toList();
        } else {
          throw Exception('Unexpected response format: Missing data key');
        }
      } else {
        throw Exception(
            'Failed to load department data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching department data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.screenWidth > 600 ? 50 : 20,
        vertical: 10,
      ),
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _departmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            final departments = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: departments.map((department) {
                String title =
                    department['department_name'] ?? 'Unknown Department';
                double progress = (department['overall_percentage'] ?? 0.0)
                    .toDouble(); // Ensure it's a double

                return _buildProgressBar(
                  title: title,
                  progress: progress / 100, // Convert percentage to fraction
                  screenWidth: widget.screenWidth,
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }

  Widget _buildProgressBar({
    required String title,
    required double progress,
    required double screenWidth,
  }) {
    String percentageText = "${(progress * 100).toInt()}%";

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: screenWidth * 0.7,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFEC1D25),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                percentageText,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
