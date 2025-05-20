import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/industry_partner.dart';
import 'package:flutter_app/models/work_integrated_learning/internship.dart';
import 'package:flutter_app/pages/employer_partners_account/partner_profile.dart';
import 'package:flutter_app/pages/employer_partners_account/work_integrated_learning/add_internship.dart';
import 'package:flutter_app/pages/employer_partners_account/work_integrated_learning/internship_details_emp_partner.dart';
import 'package:flutter_app/pages/login_and_signup/login_view.dart';
import 'package:flutter_app/services/internship_api_service.dart';
import 'package:flutter_app/widgets/appbar/partner_header.dart';
import 'package:flutter_app/widgets/drawer/drawer_partner.dart';
import 'package:flutter_app/widgets/footer/footer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InternshipDashboardPartner extends StatefulWidget {
  final IndustryPartnerAccount employerPartnerAccount;
  const InternshipDashboardPartner(
      {super.key,required this.employerPartnerAccount});

  @override
  _InternshipDashboardPartnerState createState() =>
      _InternshipDashboardPartnerState();
}

class _InternshipDashboardPartnerState
    extends State<InternshipDashboardPartner> {
  late Future<List<InternshipWithPartner>> futureInternships;
  final TextEditingController _searchController = TextEditingController();
  List<InternshipWithPartner> _filteredInternships = [];

  @override
  void initState() {
    super.initState();
    futureInternships = InternshipApiService().fetchInternships();
    futureInternships.then((data) {
      setState(() {
        _filteredInternships = data.where((internship) =>
          internship.partnerId == widget.employerPartnerAccount.partnerId).toList();
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
                    leading: const Icon(Icons.person),
                    title: Text(
                      widget.employerPartnerAccount.partnerName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Employer Partner'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.account_box),
                    title: const Text('Profile'),
                    onTap: () {
                      // Handle profile view
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PartnerProfileScreen(partnerAccount: widget.employerPartnerAccount,),
                        ),
                      );
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
      // futureInternships.then((data) {
      //   setState(() {
      //     _filteredInternships = data.where((internship) =>
      //       internship.partnerId == widget.employerPartnerAccount.partnerId).toList();
      //   });
      // });
    });
  }

  void _filterInternships() {
    String query = _searchController.text.toLowerCase();
    futureInternships.then((data) {
      setState(() {
        _filteredInternships = data
          .where((internship) =>
            internship.partnerId == widget.employerPartnerAccount.partnerId &&
            (internship.internshipTitle.toLowerCase().contains(query) ||
            internship.description.toLowerCase().contains(query)))
          .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addInternship() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddInternship(onInternshipAdded: _refreshInternships, employerPartnerAccount: widget.employerPartnerAccount,),
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
                        image: AssetImage('assets/images/seal_of_university_of_nueva_caceres_2.png'),
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
                            backgroundImage: const NetworkImage(
                                'assets/images/employer_partner.jpg'), // Add the path to your profile image
                            radius: 24,
                          ),
                          // Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text('Jennica Mae Ortiz',
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
      drawer: MyDrawerPartner(
        employerPartnerAccount: widget.employerPartnerAccount,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Material(
              elevation: 4.0,
              shadowColor: Colors.black.withOpacity(0.3),
              child: const HeaderPartner(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 24, 16, 16),
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
                                    'Manage WIL Opportunities',
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
                  Container(
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF808080),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Search Bar
                            Container(
                              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              width: 500, // searchbar width
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      hintText: 'Search internships here...',
                                      prefixIcon: Icon(
                                        Icons.search,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        
                            // Internships
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FutureBuilder<List<InternshipWithPartner>>(
                                      future: futureInternships,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
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
                                          List<InternshipWithPartner> data = _filteredInternships;
                                          // Determine the number of columns based on screen width
                                          int crossAxisCount =
                                              (MediaQuery.of(context).size.width / 300).floor();
                                          // Return GridView
                                          return GridView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: crossAxisCount,
                                              mainAxisSpacing: 10.0,
                                              crossAxisSpacing: 10.0,
                                              childAspectRatio: 0.80,
                                            ),
                                            itemCount: data.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Card(
                                                elevation: 10.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(40.0),
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      'assets/images/${data[index].displayPhoto}',
                                                      width: double.infinity,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(16.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text(data[index].internshipTitle,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.bold)),
                                                          const SizedBox(height: 4),
                                                          Text(data[index].partnerName,
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                              )),
                                                          const SizedBox(height: 4),
                                                          Text(
                                                              data[index]
                                                                  .location,
                                                              style: const TextStyle(
                                                                fontSize: 14,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(16.0),
                                                        child: ElevatedButton.icon(
                                                          icon: const Icon(Icons.arrow_forward),
                                                          onPressed: () async {
                                                            final result = await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    InternshipDetailsPartner(
                                                                  internshipWithPartner: data[index],
                                                                  employerPartnerAccount: widget
                                                                      .employerPartnerAccount,
                                                                ),
                                                              ),
                                                            );
                                                            if (result == true) {
                                                              _refreshInternships();
                                                            }
                                                          },
                                                          label: const Text('View More'),
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
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addInternship(),
        icon: const Icon(Icons.add),
        label: const Text("Add WIL Opportunity",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
      ),
    );
  }
}
