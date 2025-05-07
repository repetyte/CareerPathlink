// import 'package:flutter/material.dart';
// import 'package:flutter_app/services/career_coaching_api_services.dart';
// import 'package:google_fonts/google_fonts.dart';

// class YearLevel extends StatefulWidget {
//   final double screenWidth;

//   const YearLevel({super.key, required this.screenWidth});

//   @override
//   _YearLevelState createState() => _YearLevelState();
// }

// class _YearLevelState extends State<YearLevel> {
//   late Future<List<Map<String, dynamic>>> _yearLevelFuture;

//   @override
//   void initState() {
//     super.initState();
//     _yearLevelFuture = ApiService.fetchYearLevelInsights();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: widget.screenWidth > 600 ? 50 : 20,
//         vertical: 10,
//       ),
//       child: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _yearLevelFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 'Error: ${snapshot.error}',
//                 style: GoogleFonts.inter(
//                   fontSize: 16,
//                   color: Colors.red,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             );
//           } else if (snapshot.hasData) {
//             final yearLevels = snapshot.data!;

//             // Sort data based on the year level to ensure the correct order
//             yearLevels.sort((a, b) {
//               return _getYearFromString(a['year_level'])
//                   .compareTo(_getYearFromString(b['year_level']));
//             });

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: yearLevels.map((yearLevel) {
//                 return _buildProgressBar(
//                   title:
//                       yearLevel['year_level'], // Year level (e.g., "1st Year")
//                   progress:
//                       yearLevel['percentage'] / 100.0, // Normalize percentage
//                   screenWidth: widget.screenWidth,
//                 );
//               }).toList(),
//             );
//           } else {
//             return const Center(
//               child: Text('No data available.'),
//             );
//           }
//         },
//       ),
//     );
//   }

//   // Helper function to convert year level string (e.g., "1st Year") to an integer
//   int _getYearFromString(String yearLevel) {
//     switch (yearLevel) {
//       case '1st Year':
//         return 1;
//       case '2nd Year':
//         return 2;
//       case '3rd Year':
//         return 3;
//       case '4th Year':
//         return 4;
//       case '5th Year':
//         return 5;
//       default:
//         return 0;
//     }
//   }

//   // Widget to build a progress bar for each year level
//   Widget _buildProgressBar({
//     required String title,
//     required double progress,
//     required double screenWidth,
//   }) {
//     // Calculate the percentage text based on progress
//     String percentageText = "${(progress * 100).toInt()}%";

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20), // Add space between sections
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Title Text
//           Text(
//             title,
//             style: GoogleFonts.inter(
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//               color: Colors.black,
//             ),
//           ),

//           // Horizontal Bar Chart with Progress
//           const SizedBox(
//               height: 10), // Reduced space between text and bar chart
//           Row(
//             children: [
//               // Bar chart
//               Container(
//                 width: screenWidth * 0.7, // Adjust width based on screen size
//                 height: 10, // Height of the bar
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300], // Background color of the bar
//                   borderRadius: BorderRadius.circular(8), // Rounded corners
//                 ),
//                 child: FractionallySizedBox(
//                   alignment: Alignment.centerLeft,
//                   widthFactor: progress, // Represents the progress value
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFEC1D25), // Color of the bar
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),

//               // Space between bar and percentage text
//               const SizedBox(width: 8),

//               // Percentage Text
//               Text(
//                 percentageText,
//                 style: GoogleFonts.inter(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
