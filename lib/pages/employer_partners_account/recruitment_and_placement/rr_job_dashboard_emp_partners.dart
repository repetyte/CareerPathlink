import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_app/models/user_role/industry_partner.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_posting.dart';
import 'package:flutter_app/pages/employer_partners_account/recruitment_and_placement/rr_add_job_posting.dart';
import 'package:flutter_app/pages/employer_partners_account/recruitment_and_placement/rr_job_details_emp_partners.dart';
import 'package:flutter_app/pages/login_and_signup/login_view.dart';
import 'package:flutter_app/services/job_posting_api_service.dart';
import 'package:flutter_app/widgets/appbar/partner_header.dart';
import 'package:flutter_app/widgets/drawer/drawer_partner.dart';
import 'package:flutter_app/widgets/footer/footer.dart';
=======
import 'package:flutter_app/pages/employer_partners_account/recruitment_and_placement/rr_job_details_ccd.dart';
import 'package:flutter_app/widgets/drawer/drawer_cco.dart';
import 'package:flutter_app/models/job_posting.dart';
import 'package:flutter_app/pages/employer_partners_account/recruitment_and_placement/rr_add_job_posting.dart';
import 'package:flutter_app/services/api_service.dart';
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RrJobDashboardEmpPartners extends StatefulWidget {
<<<<<<< HEAD
  final IndustryPartnerAccount employerPartnerAccount;

  const RrJobDashboardEmpPartners({super.key, required this.employerPartnerAccount});
=======
  // final JobPostingWithPartner jobPostingWithPartner;

  const RrJobDashboardEmpPartners({super.key});
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65

  @override
  _RrJobDashboardEmpPartnersState createState() =>
      _RrJobDashboardEmpPartnersState();
}

class _RrJobDashboardEmpPartnersState extends State<RrJobDashboardEmpPartners> {
  late Future<List<JobPostingWithPartner>> futureJobPostings;
  final TextEditingController _searchController = TextEditingController();
  List<JobPostingWithPartner> _filteredJobPostings = [];

  @override
  void initState() {
<<<<<<< HEAD
    debugPrint(
        'Employer Partner ID: ${widget.employerPartnerAccount.partnerName}');
    debugPrint('Employer Partner Location: ${widget.employerPartnerAccount.partnerLocation}\n');
    super.initState();
    futureJobPostings = JobPostingApiService().fetchJobPostings();
    futureJobPostings.then((data) {
      setState(() {
        _filteredJobPostings = data.where((job) => job.partnerId == widget.employerPartnerAccount.partnerId).toList();
=======
    super.initState();
    futureJobPostings = ApiService().fetchJobPostings();
    futureJobPostings.then((data) {
      setState(() {
        _filteredJobPostings = data;
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
      });
    });
    _searchController.addListener(_filterJobPostings);
  }

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var screenSize = MediaQuery.of(context).size;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
<<<<<<< HEAD
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600, // Set the maximum width for the dialog
            ),
=======
          child: SizedBox(
            width: screenSize.width * 0.8,
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
            // height: screenSize.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
<<<<<<< HEAD
                   ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      widget.employerPartnerAccount.partnerName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
=======
                  const ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      'Partner Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
                    ),
                    subtitle: Text('Employer Partner'),
                  ),
                  const Divider(),
                  ListTile(
<<<<<<< HEAD
                    leading: const Icon(Icons.account_box),
                    title: const Text('Profile'),
                    onTap: () {
                      // Navigate to profile
=======
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      // Navigate to settings
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      // Handle logout
<<<<<<< HEAD
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginView(),
                        ),
                      );
=======
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
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
<<<<<<< HEAD
      futureJobPostings = JobPostingApiService().fetchJobPostings();
      futureJobPostings.then((data) {
        setState(() {
          _filteredJobPostings = data.where((job) => job.partnerId == widget.employerPartnerAccount.partnerId).toList();
=======
      futureJobPostings = ApiService().fetchJobPostings();
      futureJobPostings.then((data) {
        setState(() {
          _filteredJobPostings = data;
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
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
<<<<<<< HEAD
                job.partnerId == widget.employerPartnerAccount.partnerId &&
                (job.jobTitle.toLowerCase().contains(query) ||
                 job.fieldIndustry.toLowerCase().contains(query)))
=======
                job.jobTitle.toLowerCase().contains(query) ||
                job.fieldIndustry.toLowerCase().contains(query))
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

<<<<<<< HEAD
  void _addJobPosting() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RrAddJobPosting(onJobPostingAdded: _refreshJobPostings, employerPartnerAccount: widget.employerPartnerAccount,),
      ),
    );
  }
=======
  // void _addJobPosting() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => RrJobDetailsCCD(
  //         jobPostingWithPartner: widget.jobPostingWithPartner,
  //       ),
  //     ),
  //   ).then((updated) {
  //     if (updated == true) {
  //       setState(() {}); // Refresh the job details screen
  //     }
  //   });
  // }
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
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
<<<<<<< HEAD
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _showProfileDialog(context),
                child: Container(
=======
            GestureDetector(
              onTap: () => _showProfileDialog(context),
              child: Container(
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
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
                        const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                              'assets/images/image_12.png'), // Add the path to your profile image
                          radius: 24,
                        ),
<<<<<<< HEAD
                        // Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text('Partner Name',
                        //           style: GoogleFonts.getFont(
                        //             'Montserrat',
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 14,
                        //             color: const Color(0xFF000000),
                        //           )),
                        //       Text('Employer Partner',
                        //           style: GoogleFonts.getFont(
                        //             'Montserrat',
                        //             fontWeight: FontWeight.normal,
                        //             fontSize: 12,
                        //             color: const Color(0xFF000000),
                        //           )),
                        //     ]),
=======
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Partner Name',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: const Color(0xFF000000),
                                  )),
                              Text('Employer Partner',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    color: const Color(0xFF000000),
                                  )),
                            ]),
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 20.6, 0, 20),
                          width: 12,
                          height: 7.4,
                          child: SizedBox(
<<<<<<< HEAD
                              width: 12,
                              height: 7.4,
                              child: SvgPicture.asset(
                                'assets/vectors/vector_331_x2.svg',
                              ),
                            ),
                          ),
                        ],
                      ),
=======
                            width: 12,
                            height: 7.4,
                            child: SvgPicture.asset(
                              'assets/vectors/vector_331_x2.svg',
                            ),
                          ),
                        ),
                      ],
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        toolbarHeight: 92,
      ),
<<<<<<< HEAD
      drawer: MyDrawerPartner(employerPartnerAccount: widget.employerPartnerAccount,),
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
=======
      drawer: const MyDrawerCco(),
      body: SingleChildScrollView(
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
                      child: const SizedBox(
                        width: 380,
                        height: 200,
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
                      ),
                    ),
                  ),
                  Container(
<<<<<<< HEAD
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
                            child: const SizedBox(
                              width: 380,
                              height: 200,
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
                                    'Manage Job Opportunities',
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
                                  'Explore a world of possibilities and take the next step in your career your gateway to finding the perfect job match',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ],
=======
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
                              'Manage Job Opportunities',
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
                            'Explore a world of possibilities and take the next step in your career your gateway to finding the perfect job match',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: const Color(0xFFFFFFFF),
                            ),
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
                          ),
                        ),
                      ],
                    ),
                  ),
<<<<<<< HEAD
                  
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
                            // Search bar
                            Container(
                              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              width: 500, // searchbar width
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      hintText: 'Search jobs here...',
                                      prefixIcon: Icon(
                                        Icons.search,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
            
                            // Job postings
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
                                    FutureBuilder<List<JobPostingWithPartner>>(
                                      future: futureJobPostings,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          // return const Center(
                                          //   child: CircularProgressIndicator(),
                                          // );
                                          return const Center(
                                            child: Text(
                                              'No job found. Try again later',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(
                                            child: Text("${snapshot.error}"),
                                          );
                                        } else if (!snapshot.hasData ||
                                            _filteredJobPostings.isEmpty) {
                                          return const Center(
                                            child: Text(
                                              'No job found. Try different keyword/s',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          );
                                        } else {
                                          List<JobPostingWithPartner> data =
                                              _filteredJobPostings;
                                          // Determine the number of columns based on screen width
                                          int crossAxisCount =
                                              (MediaQuery.of(context).size.width /
                                                      300)
                                                  .floor();
            
                                          return GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: crossAxisCount,
                                              mainAxisSpacing: 10.0,
                                              crossAxisSpacing: 10.0,
                                              childAspectRatio: 0.80,
                                            ),
                                            itemCount: data.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return Card(
                                                elevation: 10.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(40.0),
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      // data[index].coverPhoto,
                                                        'assets/images/${data[index].coverPhoto}',
                                                      width: double.infinity,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(16.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text(data[index].jobTitle,
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          const SizedBox(height: 4),
                                                          Text(data[index].partnerName,
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                              )),
                                                          const SizedBox(height: 4),
                                                          Text(
                                                              data[index]
                                                                  .salary,
                                                              style: const TextStyle(
                                                                fontSize: 14,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(
                                                            16.0),
                                                        child: ElevatedButton.icon(
                                                          icon: const Icon(Icons
                                                              .arrow_forward),
                                                          onPressed: () async {
                                                            final result = await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    RrJobDetailsCCD(
                                                                        jobPostingWithPartner:
                                                                            data[
                                                                                index], employerPartnerAccount: widget.employerPartnerAccount,),
                                                              ),
                                                            );
                                                            if (result == true) {
                                                              _refreshJobPostings();
                                                            }
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
                                  ],
=======
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
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        width: 500, // searchbar width
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search jobs here...',
                                prefixIcon: Icon(
                                  Icons.search,
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
<<<<<<< HEAD
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
        onPressed: _addJobPosting,
=======
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
                              FutureBuilder<List<JobPostingWithPartner>>(
                                future: futureJobPostings,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // return const Center(
                                    //   child: CircularProgressIndicator(),
                                    // );
                                    return const Center(
                                      child: Text(
                                        'No job found. Try again later',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text("${snapshot.error}"),
                                    );
                                  } else if (!snapshot.hasData ||
                                      _filteredJobPostings.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        'No job found. Try different keyword/s',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  } else {
                                    List<JobPostingWithPartner> data =
                                        _filteredJobPostings;
                                    // Determine the number of columns based on screen width
                                    int crossAxisCount =
                                        (MediaQuery.of(context).size.width /
                                                300)
                                            .floor();

                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        mainAxisSpacing: 10.0,
                                        crossAxisSpacing: 10.0,
                                        childAspectRatio: 0.80,
                                      ),
                                      itemCount: data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Card(
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/gettyimages_1406724005_dsc_018073.jpeg',
                                                width: double.infinity,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(data[index].jobTitle,
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    const SizedBox(height: 4),
                                                    Text(data[index].salary,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                        )),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                        data[index]
                                                            .fieldIndustry,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              RrJobDetailsCCD(
                                                                  jobPostingWithPartner:
                                                                      data[
                                                                          index]),
                                                        ),
                                                      );
                                                    },
                                                    child:
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RrAddJobPosting()),
          );
        },
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
        icon: const Icon(Icons.add),
        label: const Text("Add Job Posting",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
      ),
    );
  }
}
