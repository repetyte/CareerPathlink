import 'package:flutter/material.dart';
import 'package:flutter_app/drawer.dart';
import 'package:flutter_app/models/job_posting.dart';
import 'package:flutter_app/pages/admin/add_job_posting_screen.dart';
import 'package:flutter_app/pages/user/rr_job_detail_screen.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RrJobDashboardUser extends StatefulWidget {
  const RrJobDashboardUser({super.key});

  @override
  _RrJobDashboardUserState createState() => _RrJobDashboardUserState();
}

class _RrJobDashboardUserState extends State<RrJobDashboardUser> {
  late Future<List<JobPosting>> futureJobPostings;

  @override
  void initState() {
    super.initState();
    futureJobPostings = ApiService().fetchJobPostings();
  }

  void _refreshJobPostings() async {
    setState(() {
      futureJobPostings = ApiService().fetchJobPostings();
    });
  }

  void _showAddJobPostingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddJobPostingDialog(onJobPosted: _refreshJobPostings);
      },
    );
  }

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile Name'),
                  subtitle: Text('Graduate'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    // Navigate to settings
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    // Handle logout
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                            'assets/images/seal_of_university_of_nueva_caceres_2.png',
                          ),
                        ),
                      ),
                      child: const SizedBox(
                        width: 48,
                        height: 48,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 6.5, 0, 6.5),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: const Color(0xFF000000),
                          ),
                          children: [
                            TextSpan(
                              text: 'UNIVERSITY\n',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                height: 1.3,
                              ),
                            ),
                            TextSpan(
                              text: 'CAREER CENTER',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                height: 1.3,
                              ),
                            ),
                            TextSpan(
                              text: '\n' 'MANAGEMENT SYSTEM',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.3,
                                color: const Color(0xFF000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _showProfileDialog(context),
                child: const CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/profile_icon.png'), // Add the path to your profile image
                  radius: 24,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 100,
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 24, 0, 24),
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
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
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
                      child: const SizedBox(
                        width: 380,
                        height: 200,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(24, 64, 24, 63),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Seek Job Opportunities',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search jobs here...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<List<JobPosting>>(
                future: futureJobPostings,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<JobPosting> data = snapshot.data!;
                    return CustomScrollView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      slivers: <Widget>[
                        SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 0.6,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/gettyimages_1406724005_dsc_018073.jpeg',
                                      width: double.infinity,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data[index].jobTitle,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 10),
                                          Text(data[index].salary,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              )),
                                          const SizedBox(height: 10),
                                          Text(data[index].fieldIndustry,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              )),
                                          const SizedBox(height: 10),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RrJobDetailScreen(
                                                          jobPosting:
                                                              data[index]),
                                                ),
                                              );
                                            },
                                            child: const Text('View More'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            childCount: data.length,
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
