// import 'package:flutter/material.dart';
// import 'package:flutter_app/models/career_coaching/in_process_appointment_model.dart';
// import 'package:flutter_app/pages/students_account/career_coaching/calendar_ver2.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class InProcessRequests extends StatelessWidget {
//   final double screenWidth;

//   const InProcessRequests({super.key, required this.screenWidth});

//   // Function to get the program name based on the program ID
//   String getProgramName(String programId) {
//     switch (programId) {
//       case '1':
//         return 'Career Coaching';
//       case '2':
//         return 'Mock Interview';
//       case '3':
//         return 'CV Review';
//       case '4':
//         return 'Mentoring';
//       default:
//         return 'Unknown Program';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<InProcessAppointment>>(
//       future:
//           ApiService.fetchInProcessAppointments(), // Call the API service here
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//               child: CircularProgressIndicator()); // Loading indicator
//         } else if (snapshot.hasError) {
//           return Center(
//               child: Text('Error: ${snapshot.error}')); // Error message
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(
//               child: Text('No data available')); // No data available message
//         } else {
//           List<InProcessAppointment> inProcessRequests = snapshot.data!;

//           return screenWidth < 600 // If it's mobile, use ListView
//               ? ListView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   itemCount: inProcessRequests.length,
//                   itemBuilder: (context, index) {
//                     final request = inProcessRequests[index];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Card(
//                         elevation: 2,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 request.name,
//                                 style: GoogleFonts.inter(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               // Displaying the program name based on the programId
//                               Text(
//                                 "Program: ${getProgramName(request.program)}",
//                                 style: GoogleFonts.inter(fontSize: 14),
//                               ),
//                               // Format Date and Time
//                               Text(
//                                 "Date: ${DateFormat('yyyy/MM/dd').format(DateTime.parse(request.date))}",
//                                 style: GoogleFonts.inter(fontSize: 14),
//                               ),
//                               Text(
//                                 "Time: ${DateFormat('hh:mm a').format(DateTime.parse("2000-01-01T${request.time}"))}",
//                                 style: GoogleFonts.inter(fontSize: 14),
//                               ),
//                               const SizedBox(height: 12),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       // Handle the action for the request
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Color(0xFF2C6F39),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       "Done",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 )
//               : GridView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 5,
//                     mainAxisSpacing: 5,
//                     childAspectRatio: 3.9,
//                   ),
//                   itemCount: inProcessRequests.length,
//                   itemBuilder: (context, index) {
//                     final request = inProcessRequests[index];
//                     return Card(
//                       elevation: 1,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               request.name,
//                               style: GoogleFonts.inter(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             // Displaying the program name based on the programId
//                             Text(
//                               "Program: ${getProgramName(request.program)}",
//                               style: GoogleFonts.inter(fontSize: 14),
//                             ),
//                             // Format Date and Time
//                             Text(
//                               "Date: ${DateFormat('yyyy/MM/dd').format(DateTime.parse(request.date))}",
//                               style: GoogleFonts.inter(fontSize: 14),
//                             ),
//                             Text(
//                               "Time: ${DateFormat('hh:mm a').format(DateTime.parse("2000-01-01T${request.time}"))}",
//                               style: GoogleFonts.inter(fontSize: 14),
//                             ),
//                             const SizedBox(height: 12),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     // Handle the action for the request
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Color(0xFF2C6F39),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                   child: const Text(
//                                     "In Process",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//         }
//       },
//     );
//   }
// }
