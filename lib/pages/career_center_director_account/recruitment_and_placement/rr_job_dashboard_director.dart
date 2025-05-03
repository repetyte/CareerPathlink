import 'package:flutter/material.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_application.dart';
import 'package:flutter_app/models/user_role/career_center_director.dart';
import 'package:flutter_app/models/user_role/graduate.dart';
import 'package:flutter_app/models/user_role/industry_partner.dart';
import 'package:flutter_app/pages/login_and_signup/login_view.dart';
import 'package:flutter_app/services/industry_partner_api_service.dart';
import 'package:flutter_app/services/job_application_api_service.dart';
import 'package:flutter_app/services/user_api_service.dart';
import 'package:flutter_app/widgets/appbar/director_header.dart';
import 'package:flutter_app/widgets/drawer/drawer_director.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_posting.dart';
import 'package:flutter_app/services/job_posting_api_service.dart';
import 'package:flutter_app/widgets/footer/footer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

class RrJobDashboardDirector extends StatefulWidget {
  final CareerCenterDirectorAccount directorAccount;
  const RrJobDashboardDirector({super.key, required this.directorAccount});

  @override
  _RrJobDashboardDirectorState createState() => _RrJobDashboardDirectorState();
}

class _RrJobDashboardDirectorState extends State<RrJobDashboardDirector> {
  late Future<List<JobApplicationComplete>> futureJobApplications;
  late Future<List<JobPostingWithPartner>> futureJobPostings;
  final TextEditingController _searchController = TextEditingController();
  List<JobPostingWithPartner> _filteredJobPostings = [];

  @override
  void initState() {
    super.initState();
    // Print graduate details for testing
    debugPrint('Graduatesssss ID: ${widget.directorAccount.directorId}');
    debugPrint('Email: ${widget.directorAccount.uncEmail}');
    futureJobApplications = JobApplicationApiService().fetchJobApplications();
    futureJobPostings = JobPostingApiService().fetchJobPostings();
    futureJobPostings.then((data) {
      setState(() {
        _filteredJobPostings = data;
      });
    });
    _searchController.addListener(_filterJobPostings);
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
                    leading: const Icon(Icons.person),
                    title: Text(
                      '${widget.directorAccount.firstName} ${widget.directorAccount.lastName}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
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

  void _refreshJobPostings() async {
    setState(() {
      futureJobPostings = JobPostingApiService().fetchJobPostings();
      futureJobPostings.then((data) {
        setState(() {
          _filteredJobPostings = data;
        });
      });
    });
  }

  void _filterJobPostings() {
    String query = _searchController.text.toLowerCase();
    futureJobPostings.then((data) {
      setState(() {
        _filteredJobPostings = data
            .where((job) =>
                job.jobTitle.toLowerCase().contains(query) ||
                job.fieldIndustry.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  // Function to show job application details in a dialog
  void _showJobApplicationDetails(
      BuildContext context, JobApplicationComplete application) {
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
                      Icon(Icons.school),
                      const SizedBox(width: 4.0),
                      Text(application.degree),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      const SizedBox(width: 4.0),
                      Text(application.jobTitle),
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

  Widget _buildReportingMetrics() {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: FutureBuilder<List<GraduateAccount>>(
                  future: UserApiService().fetchTotalGraduateAccounts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Text('Error fetching graduates');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No graduates found.');
                    } else {
                      final totalGraduates = snapshot.data!.length;
                      return Card(
                        elevation: 4,
                        color: const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Graduates Engaged',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$totalGraduates',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FutureBuilder<List<JobApplicationComplete>>(
                  future: JobApplicationApiService().fetchJobApplications(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Text('Error fetching job applications');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No job applications found.');
                    } else {
                      final totalApplications = snapshot.data!.length;
                      return Card(
                        elevation: 4,
                        color: const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Applications Submitted',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$totalApplications',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        FutureBuilder<List<JobApplicationComplete>>(
          future: JobApplicationApiService().fetchJobApplications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Error fetching job applications');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No job applications found.');
            } else {
              final applications = snapshot.data!;
              final pendingCount = applications
                  .where((a) => a.applicationStatus == 'Pending')
                  .length;
              final validatedCount = applications
                  .where((a) => a.applicationStatus == 'Validated')
                  .length;
              return Card(
                elevation: 4,
                color: const Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Job Applications Status',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: PieChart(
                          dataMap: {
                            "Pending ($pendingCount)": pendingCount.toDouble(),
                            "Validated ($validatedCount)":
                                validatedCount.toDouble(),
                          },
                          chartType: ChartType.disc,
                          colorList: [Colors.orange, Colors.green],
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildEmployerEngagementCard() {
    return SizedBox(
      width: double.infinity,
      child: FutureBuilder<List<JobPostingWithPartner>>(
        future: JobPostingApiService().fetchJobPostings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Text('Error fetching job postings');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No job postings found.');
          } else {
            final totalJobPostings = snapshot.data!.length;
            return Card(
              elevation: 4,
              color: const Color(0xFFD9D9D9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Jobs Posted',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$totalJobPostings',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildGraduatesEngagementList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(40),
      ),
      constraints: const BoxConstraints(minHeight: 300),
      child: FutureBuilder<List<JobApplicationComplete>>(
        future: futureJobApplications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No job applications found.');
          } else {
            final applications = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: applications.length,
              itemBuilder: (context, index) {
                final application = applications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListTile(
                    title: Text(
                      '${application.applicantFirstName} ${application.applicantLastName}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        Icon(Icons.work),
                        const SizedBox(width: 4.0),
                        Text(application.jobTitle),
                      ],
                    ),
                    trailing: Text(application.dateApplied),
                    onTap: () =>
                        _showJobApplicationDetails(context, application),
                  ),
                );
              },
            );
          }
        },
      ),
    );
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
                          // Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text('Hendrixon Moldes',
                          //           style: GoogleFonts.getFont(
                          //             'Montserrat',
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 14,
                          //             color: const Color(0xFF000000),
                          //           )),
                          //       Text('Graduate',
                          //           style: GoogleFonts.getFont(
                          //             'Montserrat',
                          //             fontWeight: FontWeight.normal,
                          //             fontSize: 12,
                          //             color: const Color(0xFF000000),
                          //           )),
                          //     ]),
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
      drawer: MyDrawerDirector(directorAccount: widget.directorAccount),
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
                        'Recruitment and Placement',
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
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
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
                                    'Monitor Graduates Job Metrics',
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
                                    'Oversight graduates job engagement activities.',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        bool isDesktop = constraints.maxWidth >= 800;

                        if (isDesktop) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Reporting Metrics',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildReportingMetrics(),
                                    const SizedBox(height: 32),
                                    const Text(
                                      'Employer Engagement Monitoring',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildEmployerEngagementCard(),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Graduates Job Engagement Data',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildGraduatesEngagementList(),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Reporting Metrics',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              _buildReportingMetrics(),
                              const SizedBox(height: 32),
                              const Text(
                                'Employer Engagement Monitoring',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              _buildEmployerEngagementCard(),
                              const SizedBox(height: 32),
                              const Text(
                                'Graduates Job Engagement Data',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              _buildGraduatesEngagementList(),
                            ],
                          );
                        }
                      },
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
