import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaulExecutiveSummary1 extends StatelessWidget {
  const PaulExecutiveSummary1({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: const BoxDecoration(
        color: Color(0xFF5CF659),
      ),
      child: SizedBox(
        width: 1920,
        child: Container(
          padding: const EdgeInsets.fromLTRB(28, 65.5, 42.1, 90),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(13.1, 0, 0, 18.5),
                child: Text(
                  'Project Background',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 60,
                    color: const Color(0xFF000000),
                  ),
                ),
              ),
              Text(
                'The project aims to address the needs of the Career Center Office and College Deans in tracking graduates' employability and alumni engagement.
              The Career Center Office requires the ability to assess graduates' career success and access data on workforce development.
              College Deans need insights on alumni engagement for program improvement.
              System requirements include integrating systems for tracking graduates' employability and alumni success.
              Implementation of data analysis tools is essential to evaluate workforce development initiatives and guide program enhancements.
              The project emphasizes aligning academic programs with industry demands, leveraging analytics for informed decision-making, and enhancing career outcomes and educational quality in the higher education sector.',
                style: GoogleFonts.getFont(
                  'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 40,
                  color: Color(0xFF000000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}