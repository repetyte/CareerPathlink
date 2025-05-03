import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/coach_model.dart';
import 'package:flutter_app/pages/login_and_signup/login_view.dart';
import 'package:flutter_app/widgets/appbar/coach_header.dart';
import 'package:flutter_app/widgets/drawer/drawer_wdt.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'in_process.dart'; // Import InProcessRequests
import 'pending_request.dart';
import 'completed.dart'; // Import Completed
import '../../../widgets/footer/footer.dart';

class CoachScreen extends StatelessWidget {
  final CoachAccount coachAccount;
  final double screenWidth;

  const CoachScreen({super.key, required this.screenWidth, required this.coachAccount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgramScheduleScreen(screenWidth: screenWidth, coachAccount: coachAccount,),
    );
  }
}

class ProgramScheduleScreen extends StatefulWidget {
  final CoachAccount coachAccount;
  final double screenWidth;
  const ProgramScheduleScreen({super.key, required this.screenWidth, required this.coachAccount});

  @override
  _ProgramScheduleScreenState createState() => _ProgramScheduleScreenState();
}

class _ProgramScheduleScreenState extends State<ProgramScheduleScreen> {
  int selectedIndex = 0;
  final List<String> buttonLabels = [
    'Pending',
    'In Process',
    'Completed', // Added Completed tab
  ];

  
  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var screenSize = MediaQuery.of(context).size;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600, // Set the maximum width for the dialog
            ),
            // height: screenSize.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      widget.coachAccount.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Workforce Development Trainer'),
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
                        const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                              'assets/images/image_12.png'), // Add the path to your profile image
                          radius: 24,
                        ),
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
      drawer: MyDrawerCoach(coachAccount: widget.coachAccount, screenWidth: widget.screenWidth,),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Material(
              elevation: 4.0,
              shadowColor: Colors.black.withOpacity(0.3),
              child: const HeaderCoach(),
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
                        'Career Coaching',
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
                                    'Manage Appointments',
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
                                  'The Career Center Office is staffed with dedicated counselors who assist students in identifying a suitable career path, regardless of whether they already have a specific occupation in mind or are unsure about their direction.',
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
                  Column(
                    children: [
                      // Adding more vertical space between the header and the buttons
                      const SizedBox(height: 20), // Increased space here
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(buttonLabels.length, (index) {
                            final isMobile = widget.screenWidth < 600;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedIndex == index
                                      ? const Color(0xFFEC1D25)
                                      : const Color.fromARGB(255, 90, 90, 90),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 8 : 16,
                                    vertical: isMobile ? 6 : 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  buttonLabels[index],
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobile ? 14 : 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 10),
                              
                      // Show relevant section based on selectedIndex
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 180,
                        child: selectedIndex == 0
                            ? PendingSection(screenWidth: widget.screenWidth)
                            : selectedIndex == 1
                                ? InProcessRequests(
                                    screenWidth: widget.screenWidth)
                                : Completed(), // Display the Completed section
                      ),
                    ],
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
