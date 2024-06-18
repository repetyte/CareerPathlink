// import 'package:flutter/material.dart';
// import 'package:flutter_app/drawer.dart';
// import 'package:flutter_app/models/job_posting.dart';
// import 'package:flutter_app/pages/admin/add_job_posting_screen.dart';
// import 'package:flutter_app/pages/user/rr_job_details.dart';
// import 'package:flutter_app/services/api_service.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// class RrJobDashboardAdmin extends StatefulWidget {
//   const RrJobDashboardAdmin({super.key});

//   @override
//   _RrJobDashboardAdminState createState() => _RrJobDashboardAdminState();
// }

// class _RrJobDashboardAdminState extends State<RrJobDashboardAdmin> {
//   late Future<List<JobPosting>> futureJobPostings;

//   // final int _selectedDestination = 0;

//   @override
//   void initState() {
//     super.initState();
//     futureJobPostings = ApiService().fetchJobPostings();
//   }

//   void _refreshJobPostings() async {
//     setState(() {
//       futureJobPostings = ApiService().fetchJobPostings();
//     });
//   }

//   void _showAddJobPostingDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AddJobPostingDialog(onJobPosted: _refreshJobPostings);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         leading: Container(),
//       ),
//       drawer: const MyDrawer(),
//       body: Column(children: [
//         Container(
//           margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 margin: const EdgeInsets.fromLTRB(0, 5, 0, 3),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
//                           decoration: const BoxDecoration(
//                             image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image: AssetImage(
//                                 'assets/images/seal_of_university_of_nueva_caceres_2.png',
//                               ),
//                             ),
//                           ),
//                           child: const SizedBox(
//                             width: 48,
//                             height: 48,
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(0, 6.5, 0, 6.5),
//                           child: RichText(
//                             textAlign: TextAlign.center,
//                             text: TextSpan(
//                               style: GoogleFonts.getFont(
//                                 'Montserrat',
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 20,
//                                 color: const Color(0xFF000000),
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: 'UNIVERSITY\n',
//                                   style: GoogleFonts.getFont(
//                                     'Montserrat',
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12,
//                                     height: 1.3,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: 'CAREER CENTER',
//                                   style: GoogleFonts.getFont(
//                                     'Montserrat',
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 16,
//                                     height: 1.3,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: '\n' 'MANAGEMENT SYSTEM',
//                                   style: GoogleFonts.getFont(
//                                     'Montserrat',
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 12,
//                                     height: 1.3,
//                                     color: const Color(0xFF000000),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFD9D9D9),
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 child: SizedBox(
//                   width: 88,
//                   child: Container(
//                     padding: const EdgeInsets.fromLTRB(8, 4, 14, 4),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: AssetImage(
//                                   'assets/images/image_12.png',
//                                 ),
//                               ),
//                             ),
//                             child: const SizedBox(
//                               width: 48,
//                               height: 48,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(0, 20.6, 0, 20),
//                           width: 12,
//                           height: 7.4,
//                           child: SizedBox(
//                             width: 12,
//                             height: 7.4,
//                             child: SvgPicture.asset(
//                               'assets/vectors/vector_331_x2.svg',
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.fromLTRB(16, 24, 0, 24),
//           child: Align(
//             alignment: Alignment.topLeft,
//             child: Text(
//               'Recruitment and Placement',
//               style: GoogleFonts.getFont(
//                 'Montserrat',
//                 fontWeight: FontWeight.w700,
//                 fontSize: 32,
//                 color: const Color(0xFF000000),
//               ),
//             ),
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               image: const DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage(
//                   'assets/images/rectangle_223.jpeg',
//                 ),
//               ),
//             ),
//             child: Stack(
//               children: [
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   top: 0,
//                   bottom: 0,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0x80000000),
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     child: const SizedBox(
//                       width: 380,
//                       height: 200,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(24, 64, 24, 63),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Seek Job Opportunities',
//                             style: GoogleFonts.getFont(
//                               'Montserrat',
//                               fontWeight: FontWeight.w700,
//                               fontSize: 24,
//                               color: const Color(0xFFFFFFFF),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: Text(
//                           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
//                           style: GoogleFonts.getFont(
//                             'Montserrat',
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                             color: const Color(0xFFFFFFFF),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//             margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search jobs here...',
//                     prefixIcon: const Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: FutureBuilder<List<JobPosting>>(
//               future: futureJobPostings,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   List<JobPosting> data = snapshot.data!;
//                   return CustomScrollView(
//                     slivers: <Widget>[
//                       SliverGrid(
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 10.0,
//                           crossAxisSpacing: 10.0,
//                           childAspectRatio: 0.5,
//                         ),
//                         delegate: SliverChildBuilderDelegate(
//                           (BuildContext context, int index) {
//                             return Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25.0),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 // Adjust the padding as needed
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(data[index].jobTitle,
//                                         style: const TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold)),
//                                     const SizedBox(height: 10),
//                                     Text(data[index].salary,
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                         )),
//                                     const SizedBox(height: 10),
//                                     Text(data[index].fieldIndustry,
//                                         style: const TextStyle(
//                                           fontSize: 14,
//                                         )),
//                                     const SizedBox(height: 10),
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 RrJobDetails(
//                                                     jobPosting: data[index]),
//                                           ),
//                                         );
//                                       },
//                                       child: const Text('View More'),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                           childCount: data.length,
//                         ),
//                       ),
//                     ],
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text("${snapshot.error}"));
//                 }
//                 return const Center(child: CircularProgressIndicator());
//               },
//             ),
//           ),
//         ),
//       ]),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showAddJobPostingDialog,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
