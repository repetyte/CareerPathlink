import 'package:flutter/material.dart';
import 'package:flutter_app/models/internship.dart';
import 'package:flutter_app/pages/students_account/work_integrated_learning/internship_details_stud.dart';
import 'package:flutter_app/widgets/drawer/drawer_graduates.dart';
import 'package:flutter_app/services/internship_api_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InternshipDashboardStud extends StatefulWidget {
  const InternshipDashboardStud({super.key});

  @override
  _InternshipDashboardStudState createState() => _InternshipDashboardStudState();
}

class _InternshipDashboardStudState extends State<InternshipDashboardStud> {
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Jennica Mae Ortiz',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      'Graduate | Bachelor of Science in Information Technology'),
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
                internship.internshipTitle.toLowerCase().contains(query)  || 
                internship.description.toLowerCase().contains(query)
                )
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
                        image: AssetImage('assets/logo/UNC_CareerPathlink.png'),
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
            GestureDetector(
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
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Jennica Mae Ortiz',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: const Color(0xFF000000),
                                  )),
                              Text('Graduate',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    color: const Color(0xFF000000),
                                  )),
                            ]),
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
          ],
        ),
        toolbarHeight: 92,
      ),
      drawer: const MyDrawerGraduates(),
      body: SingleChildScrollView(
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
                              'Available Opportunities',
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
                              'Industry Partners regularly submit new learning opportunities. These opportunities are processed and matched with intern profiles based on their skills and interest. Intern can view and apply for matched opportunities.',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                // Container(
                //   margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                //   width: 500, // searchbar width
                //   child: Column(
                //     children: [
                //       const SizedBox(height: 16),
                //       TextField(
                //         controller: _searchController,
                //         decoration: InputDecoration(
                //           hintText: 'Search jobs here...',
                //           prefixIcon: Icon(Icons.search,),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: FutureBuilder<List<InternshipWithPartner>>(
                    future: futureInternships,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      } else if (!snapshot.hasData ||
                          _filteredInternships.isEmpty) {
                        return const Center(
                          child: Text(
                            'No internship found. Try different keyword/s',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      } else {
                        List<InternshipWithPartner> data =
                            _filteredInternships;
                        // Determine the number of columns based on screen width
                        int crossAxisCount =
                            (MediaQuery.of(context).size.width /
                                    400)
                                .floor();
                        // Return GridView
                        return GridView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 2.5,
                          ),
                          itemCount: data.length,
                          itemBuilder:
                              (BuildContext context, int index) {
                            return Card(
                              color: const Color(0xFFD9D9D9),
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(50.0),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Image.asset(
                                  //   data[index].coverPhoto,
                                  //   width: double.infinity,
                                  //   height: 100,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data[index].internshipTitle,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight:
                                                    FontWeight
                                                        .bold)),
                                        const SizedBox(height: 4),
                                        // Text(data[index].salary,
                                        //     style: const TextStyle(
                                        //       fontSize: 16,
                                        //     )),
                                        // const SizedBox(height: 4),
                                        // Text(
                                        //     data[index]
                                        //         .fieldIndustry,
                                        //     style: const TextStyle(
                                        //       fontSize: 14,
                                        //     )),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          16.0),
                                      child: ElevatedButton.icon(
                                        icon: const Icon(Icons
                                            .arrow_forward),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  InternshipDetailsStud(
                                                      internship:
                                                          data[
                                                              index]),
                                            ),
                                          );
                                        },
                                        label:
                                            const Text('View More'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
