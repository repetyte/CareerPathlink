import 'package:flutter/material.dart';
import 'package:flutter_app/pages/students_account/career_coaching/calendar.dart';
import 'package:flutter_app/services/career_coaching_api_services.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentInsight extends StatefulWidget {
  final double screenWidth;

  const StudentInsight({super.key, required this.screenWidth});

  @override
  _StudentInsightState createState() => _StudentInsightState();
}

class _StudentInsightState extends State<StudentInsight> {
  late Future<List<Map<String, dynamic>>> _genderDistributionFuture;

  @override
  void initState() {
    super.initState();
    _genderDistributionFuture = ApiService
        .fetchGenderDistribution(); // Fetch data once during widget initialization
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.screenWidth > 600 ? 50 : 20,
        vertical: 10,
      ),
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _genderDistributionFuture, // Use the stored future
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            // Extract gender distribution data
            var data = snapshot.data!;
            double malePercentageSum = 0.0;
            double femalePercentageSum = 0.0;
            int maleCount = 0;
            int femaleCount = 0;

            // Loop through the data to sum the percentages for each gender
            for (var item in data) {
              double totalPercentage =
                  double.tryParse(item['total_percentage'].toString()) ?? 0.0;

              if (item['gender'] == 'Male') {
                malePercentageSum += totalPercentage;
                maleCount++;
              } else if (item['gender'] == 'Female') {
                femalePercentageSum += totalPercentage;
                femaleCount++;
              }
            }

            // Calculate averages
            var malePercentage =
                maleCount > 0 ? malePercentageSum / maleCount : 0.0;
            var femalePercentage =
                femaleCount > 0 ? femalePercentageSum / femaleCount : 0.0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Male Circle with Text and Percentage Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color(0xFFEC1D25), // Male circle color (red)
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Male',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${malePercentage.toStringAsFixed(2)}%', // Show male percentage
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: widget.screenWidth * 0.7,
                      height: 1,
                      color: Colors.black87,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Female Circle with Text and Percentage Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color(
                            0xFFFFBFBF), // Female circle color (light pink)
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Female',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${femalePercentage.toStringAsFixed(2)}%', // Show female percentage
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
