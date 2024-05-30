import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HendrixonUploadResumeUser extends StatelessWidget {
  const HendrixonUploadResumeUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 24),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 5.5, 0, 4.5),
                        // child: Container(
                        //   decoration: const BoxDecoration(
                        //     image: DecorationImage(
                        //       fit: BoxFit.contain,
                        //       image: AssetImage(
                        //         'assets/images/menu.png',
                        //       ),
                        //     ),
                        //   ),
                        //   child: const SizedBox(
                        //     width: 24,
                        //     height: 30,
                        //   ),
                        // ),
                      ),
                      Container(
                        child: Text(
                          'Recruitment and Placement',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(31, 0, 31, 24),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 2, 16.2, 2),
                      width: 11.8,
                      height: 20,
                      child: SizedBox(
                        width: 11.8,
                        height: 20,
                        child: SvgPicture.asset(
                          'assets/vectors/vector_430_x2.svg',
                        ),
                      ),
                    ),
                    Text(
                      'Upload Resume',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 0, 33.7, 24),
              child: Text(
                'The critical juncture lies in assessing whether applicants meet the minimum qualifications. If they do, they proceed to an interview. For those falling short of the criteria, there is an opportunity to reapply for other positions.',
                style: GoogleFonts.getFont(
                  'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: const Color(0xFF000000),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 0, 25, 24),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF000000)),
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFFFFFFF),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(90, 91.5, 90, 91.5),
                child: Text(
                  'click to upload a file...',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: const Color(0xFF808080),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF0000),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
