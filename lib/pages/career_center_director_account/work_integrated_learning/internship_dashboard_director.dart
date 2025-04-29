import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/career_center_director.dart';
import 'package:flutter_app/models/user_role/student.dart';
import 'package:flutter_app/models/work_integrated_learning/internship.dart';
import 'package:flutter_app/pages/login_and_signup/login_view.dart';
import 'package:flutter_app/pages/students_account/work_integrated_learning/internship_details_stud.dart';
import 'package:flutter_app/services/internship_api_service.dart';
import 'package:flutter_app/widgets/appbar/director_header.dart';
import 'package:flutter_app/widgets/appbar/graduates_header.dart';
import 'package:flutter_app/widgets/drawer/drawer_director.dart';
import 'package:flutter_app/widgets/drawer/drawer_students.dart';
import 'package:flutter_app/widgets/footer/footer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InternshipDashboardDirector extends StatefulWidget {
  final CareerCenterDirectorAccount directorAccount;
  const InternshipDashboardDirector({super.key, required this.directorAccount,});

  @override
  _InternshipDashboardDirectorState createState() =>
      _InternshipDashboardDirectorState();
}

class _InternshipDashboardDirectorState extends State<InternshipDashboardDirector> {
  late Future<List<InternshipWithPartner>> futureInternships;
  final TextEditingController _searchController = TextEditingController();
  List<InternshipWithPartner> _filteredInternships = [];

  @override
  void initState() {
    super.initState();
    futureInternships = InternshipApiService().fetchInternships();
    futureInternships.then((data) {
      setState(() {
        _filteredInternships = data;
      });
    });
    _searchController.addListener(_filterInternships);
  }

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600, // Set the maximum width for the dialog
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      '${widget.directorAccount.firstName} ${widget.directorAccount.lastName}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Career Center Director'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.account_box),
                    title: const Text('Profile'),
                    onTap: () {
                      // Navigate to profile
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      // Handle logout
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginView(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _refreshInternships() async {
    setState(() {
      futureInternships = InternshipApiService().fetchInternships();
      futureInternships.then((data) {
        setState(() {
          _filteredInternships = data;
        });
      });
    });
  }

  void _filterInternships() {
    String query = _searchController.text.toLowerCase();
    futureInternships.then((data) {
      setState(() {
        _filteredInternships = data
            .where((internship) =>
                internship.internshipTitle.toLowerCase().contains(query) ||
                internship.description.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/images/seal_of_university_of_nueva_caceres_2.png'),
                      ),
                    ),
                    child: const SizedBox(
                      width: 48,
                      height: 48,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'UNC ',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      Text(
                        'Career',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: const Color(0xFF9E9E9E),
                        ),
                      ),
                      Text(
                        'Pathlink',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _showProfileDialog(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: SizedBox(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 4, 14, 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: const AssetImage(
                                'assets/images/image_12.png'), // Add the path to your profile image
                            radius: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 20.6, 0, 20),
                            width: 12,
                            height: 7.4,
                            child: SizedBox(
                              width: 12,
                              height: 7.4,
                              child: SvgPicture.asset(
                                'assets/vectors/vector_331_x2.svg',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        toolbarHeight: 92,
      ),
      drawer: MyDrawerDirector(
        directorAccount: widget.directorAccount,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Material(
              elevation: 4.0,
              shadowColor: Colors.black.withOpacity(0.3),
              child: const HeaderDirector(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Work Integrated Learning',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/rectangle_223.jpeg',
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0x80000000),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Analyze Student Work Integrated Learning Metrics',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28,
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                    'Oversight of students work integrated learning engagement activities.',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
