import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/appbar/cc_coach_header.dart';
import 'department.dart';
import 'student_insight.dart';
import 'year_level.dart';
import '../../students_account/career_coaching/footer.dart';
import 'service.dart'; // Import your service widget

class CC_HomeScreen extends StatefulWidget {
  const CC_HomeScreen({Key? key}) : super(key: key);

  @override
  _CC_HomeScreenState createState() => _CC_HomeScreenState();
}

class _CC_HomeScreenState extends State<CC_HomeScreen> {
  final PageController _pageController = PageController(initialPage: 1);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double fontSizeTitle = screenWidth > 600 ? 24 : 20;
    double fontSizeSubTitle = screenWidth > 600 ? 16 : 10;
    double fontSizeServiceText = screenWidth > 600 ? 18 : 16;
    double fontSizeServiceManagement =
        screenWidth > 600 ? 18 : 16; // Reduced size

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 150),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 600 ? 50 : 20,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 600 ? 50 : 20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Service Details', // Add the text here
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeServiceManagement, // Reduced size
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(width: 10), // Space between text and icon
                      Icon(
                        Icons.info_outline,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 600 ? 50 : 20,
                  ),
                  child:
                      Service(screenWidth: screenWidth), // Service widget here
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 600 ? 50 : 20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Student Insight', // Add the text here
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeServiceManagement, // Reduced size
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(width: 10), // Space between text and icon
                      Icon(
                        Icons.info_outline,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 600 ? 50 : 20,
                  ),
                  child: StudentInsight(
                      screenWidth: screenWidth), // Service widget here
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 600 ? 50 : 20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Year Level', // Add the text here
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeServiceManagement, // Reduced size
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(width: 10), // Space between text and icon
                      Icon(
                        Icons.info_outline,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 600 ? 50 : 20,
                  ),
                  child: YearLevel(
                      screenWidth: screenWidth), // Service widget here
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 600 ? 50 : 20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Department', // Add the text here
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeServiceManagement, // Reduced size
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(width: 10), // Space between text and icon
                      Icon(
                        Icons.info_outline,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 600 ? 50 : 20,
                  ),
                  child: Department(
                      screenWidth: screenWidth), // Service widget here
                ),
                Footer(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              elevation: 4.0,
              color: Colors.white,
              child: const Header(),
            ),
          ),
        ],
      ),
    );
  }
}
