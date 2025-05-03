import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Service extends StatefulWidget {
  final double screenWidth;

  const Service({super.key, required this.screenWidth});

  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  late Future<Map<String, double>> _programPercentages;

  @override
  void initState() {
    super.initState();
    _programPercentages = fetchProgramPercentages();
  }

  Future<Map<String, double>> fetchProgramPercentages() async {
    final response = await http.get(
      Uri.parse('http://localhost/CareerPathlink/api/career_coaching/read_service_details.php'),
    );

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);

      if (decodedResponse is Map && decodedResponse.containsKey('data')) {
        List<Map<String, dynamic>> serviceDetails =
            List<Map<String, dynamic>>.from(decodedResponse['data']);

        // Group the data by program_name and calculate the sum of the percentages
        Map<String, double> programPercentages = {};

        for (var service in serviceDetails) {
          String programName = service['program_name'];
          double percentage = 0.0;

          try {
            var percentageValue = service['percentage'];
            if (percentageValue != null) {
              // Safely handle the percentage field to ensure it's a number
              if (percentageValue is String) {
                percentage = double.tryParse(percentageValue) ?? 0.0;
              } else if (percentageValue is num) {
                percentage = percentageValue.toDouble();
              }
            }
          } catch (e) {
            debugPrint('Error parsing percentage: ${service['percentage']}');
          }

          // Add the percentage to the program's total (or initialize if it's the first time)
          if (programPercentages.containsKey(programName)) {
            programPercentages[programName] =
                programPercentages[programName]! + percentage;
          } else {
            programPercentages[programName] = percentage;
          }
        }

        return programPercentages;
      } else {
        throw Exception('Unexpected response format: Missing data key');
      }
    } else {
      throw Exception(
          'Failed to load service details. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: _programPercentages,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final programPercentages = snapshot.data!;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.screenWidth > 600 ? 50 : 20,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: programPercentages.entries.map((entry) {
                String programName = entry.key;
                double totalPercentage = entry.value;

                return _buildProgressBar(
                  title: programName,
                  progress: (totalPercentage /
                      100.0), // Convert to percentage progress
                  screenWidth: widget.screenWidth,
                );
              }).toList(),
            ),
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
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
          // Title Text
          Text(
            title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),

          // Horizontal Bar Chart with Progress
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              // Bar chart
              Container(
                width: screenWidth * 0.7, // Adjust width based on screen size
                height: 10, // Height of the bar
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Background color of the bar
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress, // Represents the progress value
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEC1D25), // Color of the bar
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              // Space between bar and percentage text
              const SizedBox(width: 8),

              // Percentage Text at the upper right of the bar
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
