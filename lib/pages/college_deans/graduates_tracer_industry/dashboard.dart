import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'graduates_lists_dashboard.dart';
import 'employed_lists_dashboard.dart';
import 'unemployed_lists_dashboard.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 92),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Career Counseling Guidance Banner
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 22),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(25, 88, 25, 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 5, 0, 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 9.5, 8, 8.5),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                              'assets/images/menu.png',
                                            ),
                                          ),
                                        ),
                                        child: const SizedBox(
                                          width: 24,
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 2.8, 0),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/images/seal_of_university_of_nueva_caceres_2.png',
                                          ),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x40000000),
                                            offset: Offset(0, 4),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: const SizedBox(
                                        width: 48,
                                        height: 48,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 6.5, 0, 6.5),
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
                                              text: 'CAREER CENTER',
                                              style: GoogleFonts.getFont(
                                                'Montserrat',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                height: 1.3,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '\n',
                                              style: GoogleFonts.getFont(
                                                'Montserrat',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                height: 1.3,
                                                color: const Color(0xFF000000),
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'MANAGEMENT SYSTEM',
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
                              // Container for Image and Navigation
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GraduatesListsDashboard(),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD9D9D9),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: SizedBox(
                                    width: 88,
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(8, 4, 14, 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.fromLTRB(0, 0, 6, 0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                    'assets/images/image_11.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 48,
                                                height: 48,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 20.6, 0, 20),
                                            width: 12,
                                            height: 7.4,
                                            child: SizedBox(
                                              width: 12,
                                              height: 7.4,
                                              child: SvgPicture.asset(
                                                'assets/vectors/vector_2_x2.svg',
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
                        ),
                      ),
                    ),
                    // Title for Career Counseling Guidance
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Graduates Tracer Industry',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Career Counseling Guidance Banner
              Container(
                margin: const EdgeInsets.fromLTRB(25, 0, 25, 46),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF808080),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Stack(
                    children: [
                      // Background Image
                      Positioned(
                        left: 0,
                        right: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/rectangle_223.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                        ),
                      ),
                      // Content
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 63, 0, 64),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Career Counseling Guidance',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                            // Description
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Discover your true potential and navigate your career path with confidence through our Career Counseling web application.',
                                style: GoogleFonts.getFont(
                                  'Montserrat',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
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
              ),
              // Graduates Lists
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GraduatesListsDashboard(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 46),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(21, 21.5, 0, 122.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/rectangle_151.png',
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Graduates Lists:',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 21,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        // Number of Graduates
                        Container(
                          margin: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '1500',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w800,
                                fontSize: 40,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Employed Lists
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployedListsDashboard(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 46),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(18, 30.5, 0, 111.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/rectangle_152.png',
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 17),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Employed Lists:',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        // Number of Employed
                        Container(
                          margin: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '500',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w800,
                                fontSize: 40,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Unemployed Lists
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UnemployedListsDashboard(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(21, 35.5, 0, 115.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/rectangle_153.png',
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Unemployed Lists',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        // Number of Unemployed
                        Container(
                          margin: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '1000',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w800,
                                fontSize: 40,
                                color: const Color(0xFFFFFFFF),
                              ),
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
      ),
    );
  }
}
