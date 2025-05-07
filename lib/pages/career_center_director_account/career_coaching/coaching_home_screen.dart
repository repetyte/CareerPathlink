// import 'package:flutter/material.dart';
// import 'package:flutter_app/models/user_role/career_center_director.dart';
// import 'package:flutter_app/pages/login_and_signup/login_view.dart';
// import 'package:flutter_app/widgets/appbar/director_header.dart';
// import 'package:flutter_app/widgets/drawer/drawer_director.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'department.dart';
// import 'student_insight.dart';
// import 'year_level.dart';
// import '../../../widgets/footer/footer.dart';
// import 'service.dart'; // Import your service widget

// class EngagementDashboard extends StatefulWidget {
//   final CareerCenterDirectorAccount directorAccount;
//   const EngagementDashboard(
//       {super.key, required this.directorAccount});

//   @override
//   EngagementDashboardState createState() => EngagementDashboardState();
// }

// class EngagementDashboardState extends State<EngagementDashboard> {
//   final PageController _pageController = PageController(initialPage: 1);

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void _showProfileDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         var screenSize = MediaQuery.of(context).size;
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(50),
//           ),
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               maxWidth: 600, // Set the maximum width for the dialog
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ListTile(
//                     leading: Icon(Icons.person),
//                     title: Text(
//                       '${widget.directorAccount.firstName} ${widget.directorAccount.lastName}',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text('Career Center Director'),
//                   ),
//                   const Divider(),
//                   ListTile(
//                     leading: const Icon(Icons.account_box),
//                     title: const Text('Profile'),
//                     onTap: () {
//                       // Navigate to profile
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.logout),
//                     title: const Text('Logout'),
//                     onTap: () {
//                       // Handle logout
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => LoginView(),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     double fontSizeTitle = screenWidth > 600 ? 24 : 20;
//     double fontSizeSubTitle = screenWidth > 600 ? 16 : 10;
//     double fontSizeServiceText = screenWidth > 600 ? 18 : 16;
//     double fontSizeServiceManagement =
//         screenWidth > 600 ? 18 : 16; // Reduced size

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage(
//                             'assets/images/seal_of_university_of_nueva_caceres_2.png'),
//                       ),
//                     ),
//                     child: const SizedBox(
//                       width: 48,
//                       height: 48,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         'UNC ',
//                         style: GoogleFonts.getFont(
//                           'Montserrat',
//                           fontWeight: FontWeight.w700,
//                           fontSize: 24,
//                           color: const Color(0xFF000000),
//                         ),
//                       ),
//                       Text(
//                         'Career',
//                         style: GoogleFonts.getFont(
//                           'Montserrat',
//                           fontWeight: FontWeight.w700,
//                           fontSize: 24,
//                           color: const Color(0xFF9E9E9E),
//                         ),
//                       ),
//                       Text(
//                         'Pathlink',
//                         style: GoogleFonts.getFont(
//                           'Montserrat',
//                           fontWeight: FontWeight.w700,
//                           fontSize: 24,
//                           color: const Color.fromARGB(255, 255, 0, 0),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             MouseRegion(
//               cursor: SystemMouseCursors.click,
//               child: GestureDetector(
//                 onTap: () => _showProfileDialog(context),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFD9D9D9),
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: SizedBox(
//                     child: Container(
//                       padding: const EdgeInsets.fromLTRB(8, 4, 14, 4),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: Colors.transparent,
//                             backgroundImage: const AssetImage(
//                                 'assets/images/image_12.png'), // Add the path to your profile image
//                             radius: 24,
//                           ),
//                           SizedBox(
//                             width: 4,
//                           ),
//                           Container(
//                             margin: const EdgeInsets.fromLTRB(0, 20.6, 0, 20),
//                             width: 12,
//                             height: 7.4,
//                             child: SizedBox(
//                               width: 12,
//                               height: 7.4,
//                               child: SvgPicture.asset(
//                                 'assets/vectors/vector_331_x2.svg',
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         toolbarHeight: 92,
//       ),
//       drawer: MyDrawerDirector(
//         directorAccount: widget.directorAccount,
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: Material(
//               elevation: 4.0,
//               shadowColor: Colors.black.withOpacity(0.3),
//               child: const HeaderDirector(),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.fromLTRB(16, 24, 16, 24),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Text(
//                         'Career Coaching',
//                         style: GoogleFonts.getFont(
//                           'Montserrat',
//                           fontWeight: FontWeight.w700,
//                           fontSize: 32,
//                           color: const Color(0xFF000000),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
//                     height: 300,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       image: const DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage(
//                           'assets/images/rectangle_223.jpeg',
//                         ),
//                       ),
//                     ),
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           left: 0,
//                           right: 0,
//                           top: 0,
//                           bottom: 0,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: const Color(0x80000000),
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             child: const SizedBox(
//                               width: 380,
//                               height: 200,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
//                                 child: Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text(
//                                     'Enagagement Dashboard',
//                                     style: GoogleFonts.getFont(
//                                       'Montserrat',
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 28,
//                                       color: const Color(0xFFFFFFFF),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   'The Career Center Office also organize events and workshops on topics such as career exploration, resume building, job interview techniques, and other activities designed to enhance students.',
//                                   style: GoogleFonts.getFont(
//                                     'Montserrat',
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14,
//                                     color: const Color(0xFFFFFFFF),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth > 600 ? 50 : 20,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth > 600 ? 50 : 20,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Service Details', // Add the text here
//                           style: GoogleFonts.montserrat(
//                             fontWeight: FontWeight.bold,
//                             fontSize: fontSizeServiceManagement, // Reduced size
//                             color: Color.fromARGB(255, 0, 0, 0),
//                           ),
//                         ),
//                         SizedBox(width: 10), // Space between text and icon
//                         Icon(
//                           Icons.info_outline,
//                           color: Colors.black87,
//                           size: 24,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth > 600 ? 50 : 20,
//                     ),
//                     child:
//                         Service(screenWidth: screenWidth), // Service widget here
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth > 600 ? 50 : 20,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Student Insight', // Add the text here
//                           style: GoogleFonts.montserrat(
//                             fontWeight: FontWeight.bold,
//                             fontSize: fontSizeServiceManagement, // Reduced size
//                             color: Color.fromARGB(255, 0, 0, 0),
//                           ),
//                         ),
//                         SizedBox(width: 10), // Space between text and icon
//                         Icon(
//                           Icons.info_outline,
//                           color: Colors.black87,
//                           size: 24,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth > 600 ? 50 : 20,
//                     ),
//                     child: StudentInsight(
//                         screenWidth: screenWidth), // Service widget here
//                   ),
//                   SizedBox(height: 20),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth > 600 ? 50 : 20,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Year Level', // Add the text here
//                           style: GoogleFonts.montserrat(
//                             fontWeight: FontWeight.bold,
//                             fontSize: fontSizeServiceManagement, // Reduced size
//                             color: Color.fromARGB(255, 0, 0, 0),
//                           ),
//                         ),
//                         SizedBox(width: 10), // Space between text and icon
//                         Icon(
//                           Icons.info_outline,
//                           color: Colors.black87,
//                           size: 24,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth > 600 ? 50 : 20,
//                     ),
//                     child: YearLevel(
//                         screenWidth: screenWidth), // Service widget here
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth > 600 ? 50 : 20,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Department', // Add the text here
//                           style: GoogleFonts.montserrat(
//                             fontWeight: FontWeight.bold,
//                             fontSize: fontSizeServiceManagement, // Reduced size
//                             color: Color.fromARGB(255, 0, 0, 0),
//                           ),
//                         ),
//                         SizedBox(width: 10), // Space between text and icon
//                         Icon(
//                           Icons.info_outline,
//                           color: Colors.black87,
//                           size: 24,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth > 600 ? 50 : 20,
//                     ),
//                     child: Department(
//                         screenWidth: screenWidth), // Service widget here
//                   ),
//                   Footer(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
