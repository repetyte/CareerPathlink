import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/career_center_director.dart';
import 'package:flutter_app/models/user_role/industry_partner.dart';
import 'package:flutter_app/models/work_integrated_learning/internship.dart';
import 'package:flutter_app/models/work_integrated_learning/internship_application.dart';
import 'package:flutter_app/pages/login_and_signup/login_view.dart';
import 'package:flutter_app/services/industry_partner_api_service.dart';
import 'package:flutter_app/services/internship_api_service.dart';
import 'package:flutter_app/services/internship_application_api_service.dart';
import 'package:flutter_app/widgets/appbar/director_header.dart';
import 'package:flutter_app/widgets/drawer/drawer_director.dart';
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
  late Future<List<InternshipApplicationComplete>> futureInternshipApplications;
  final TextEditingController _searchController = TextEditingController();
  List<InternshipWithPartner> _filteredInternships = [];

  @override
  void initState() {
    super.initState();
    futureInternships = InternshipApiService().fetchInternships();
    futureInternshipApplications =
        InternshipApplicationApiService().fetchInternshipApplications();
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

  // Function to show job application details in a dialog
  void _showJobApplicationDetails(
      BuildContext context, InternshipApplicationComplete application) {
    // Fetch the list of industry partners
    Future<List<IndustryPartner>> futureIndustryPartners =
        IndustryPartnerApiService().fetchIndustryPartners();

    futureIndustryPartners.then((partners) {
      // Find the matching industry partner
      IndustryPartner? matchedPartner = partners.firstWhere(
        (partner) => partner.partnerId == application.industryPartner,
        orElse: () => IndustryPartner(
          partnerId: null,
          partnerName: 'Unknown Employer',
          partnerLocation: '',
          contactNo: '',
          emailAdd: '',
        ),
      );

      // Show the dialog with the matched partner's name
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '${application.applicantFirstName} ${application.applicantLastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.perm_identity),
                      const SizedBox(width: 4.0),
                      Text(application.course),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.menu_book),
                      const SizedBox(width: 4.0),
                      Text(application.internshipTitle),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text('Employer Applied To: ${matchedPartner.partnerName}'),
                  Text('Application Status: ${application.applicationStatus}'),
                  Text('Engagement Date: ${application.dateApplied}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      // Handle errors if fetching industry partners fails
      debugPrint('Error fetching industry partners: $error');
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
                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Students WIL Engagement Data',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          constraints: const BoxConstraints(
                            minHeight: 300, // Set the minimum height to 300
                          ),
                          child: FutureBuilder<List<InternshipApplicationComplete>>(
                            future: futureInternshipApplications,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Text('No job applications found.');
                              } else {
                                final applications = snapshot.data!;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: applications.length,
                                  itemBuilder: (context, index) {
                                    final application = applications[index];
                                    return ListTile(
                                      title: Text(
                                          '${application.applicantFirstName} ${application.applicantLastName}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      subtitle: Row(
                                        children: [
                                          Icon(Icons.menu_book),
                                          const SizedBox(width: 4.0),
                                          Text(application.internshipTitle),
                                        ],
                                      ),
                                      trailing: Text(
                                          'Enagagement Date: ${application.dateApplied}'),
                                      onTap: () => _showJobApplicationDetails(
                                          context, application),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Reporting Metrics',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Employer Engagement Monitoring',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
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
