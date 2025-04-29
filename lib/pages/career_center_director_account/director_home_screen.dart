import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/career_center_director.dart';
import 'package:flutter_app/pages/login_and_signup/login_view.dart';
import 'package:flutter_app/widgets/drawer/drawer_director.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/footer/footer.dart';
import '../../widgets/appbar/student_header.dart';

class HomeScreenDirector extends StatefulWidget {
  final CareerCenterDirectorAccount directorAccount;
  const HomeScreenDirector({super.key, required this.directorAccount,});

  @override
  State<HomeScreenDirector> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenDirector> {
  int? _expandedIndex; // Track which card is expanded

  void _toggleExpand(int index) {
    setState(() {
      // If the clicked card is already expanded, collapse it; otherwise, expand it
      _expandedIndex = (_expandedIndex == index) ? null : index;
    });
  }

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var screenSize = MediaQuery.of(context).size;
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
              child: const HeaderStudent(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                    margin: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Home',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Image.asset(
                            'assets/career_coaching/homepage.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          'CAREER CENTER SERVICES',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Text(
                        'STAY CONNECTED BEYOND GRADUATION',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEC1D25),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Text(
                        'Since 2014, the Career Services and Placement Office has been committed to supporting UNC students in shaping and achieving their career aspirations. Beyond academic courses, our programs are designed to equip students with the essential skills and competencies needed for a fulfilling and successful career.\n\n'
                        'Our office is staffed with dedicated counselors who assist students in identifying a suitable career path, regardless of whether they already have a specific occupation in mind or are unsure about their direction. By utilizing self-assessment tools and various career exploration methods, we evaluate students\' values, skills, interests, and personalities. Based on these insights, our counselors either recommend potential career options or work closely with students to determine if their desired career choices align with their strengths and aspirations. Additionally, our counselors help students select majors and courses that align with their professional objectives.\n\n'
                        'We also organize events and workshops on topics such as career exploration, resume building, job interview techniques, and other activities designed to enhance students\' skills and refine their career strategies. These opportunities provide practical experience and guidance, empowering students to confidently navigate their professional journeys.\n\n'
                        'The Career Center offers a range of flagship programs and services aimed at enhancing graduate employability. These include the Government-Industry Academe Programs, initiatives focused on Student Employment Readiness, Research and Development projects, and many others. For more details about these programs and how they can benefit you, feel free to contact us using the information provided below.',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(40),
                      // ),
                      width: double.infinity,
                      color: Color(0xFFEC1D25),
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 60,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Student Success: Experience the "Alagang UNC"!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isMobile = constraints.maxWidth < 700;
                          final cardWidth =
                              (isMobile ? constraints.maxWidth : 300)
                                  .toDouble();

                          return isMobile
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: _buildImageCards(cardWidth),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: _buildImageCards(cardWidth),
                                );
                        },
                      ),
                    ),
                    const Footer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildImageCards(double cardWidth) {
    return [
      _buildImageCard(
        0,
        'assets/career_coaching/career_coaching.png',
        'Career Coaching',
        'Career Coaching pairs you with experienced alumni who will guide you through career planning and goal-setting. Get the clarity and confidence you need to succeed in your dream career.',
        cardWidth,
      ),
      _buildImageCard(
        1,
        'assets/career_coaching/mock_interview.webp',
        'Work Intergrated Learning',
        'Practice with professionals who provide real-time feedback and tips. Gain the confidence to handle any interview and stand out to employers.',
        cardWidth,
      ),
      _buildImageCard(
        2,
        'assets/career_coaching/cv_review.png',
        'Recruitment and Placement',
        'Submit your resume for expert review and get personalized advice on how to make it impactful. A great CV opens doors—let us help you perfect yours!',
        cardWidth,
      ),
      _buildImageCard(
        3,
        'assets/career_coaching/mentoring_.png',
        'Graduates Tracer Industry',
        'Mentoring connects you with alumni who’ve been where you are. Get career advice and support to make your professional journey a success.',
        cardWidth,
      ),
    ];
  }

  Widget _buildImageCard(
    int index,
    String imagePath,
    String title,
    String description,
    double cardWidth,
  ) {
    final isExpanded = _expandedIndex == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15, right: 10),
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                imagePath,
                width: cardWidth,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      size: 24,
                    ),
                    onPressed: () => _toggleExpand(index),
                  ),
                ],
              ),
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          if (index == 2) {
                            // Navigate to Upload CV screen when "Submit CV" is clicked
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => UploadCVScreen(),
                            //   ),
                            // );
                          } else {
                            // Navigate to Select Coach
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => SelectCoachScreen(),
                            //   ),
                            // );
                          }
                        },
                        child: Text(
                          index == 2 ? "Submit CV" : "Book Now",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
