import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaulExecutiveSummary5 extends StatelessWidget {
  const PaulExecutiveSummary5({super.key});

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
          padding: const EdgeInsets.fromLTRB(128.2, 77.5, 105.7, 228.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 22.5, 18),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Executive Summary:',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 60,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 21),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'B. College Deans:',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 50,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 1139.5, 37),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'User Requirements:',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15.8, 0, 0, 29),
                child: Text(
                  '         a) College Deans require access to data on alumni engagement and success to evaluate the impact of academic programs.
                       b) Tools are needed for program improvement based on alumni outcomes to enhance the quality and relevance of education.',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: 40,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(42.7, 0, 42.7, 45),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'System Requirements:',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15.8, 0, 19.2, 0),Implementation of analytics tools to guide program improvement strategies by analyzing alumni data and feedback..',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: 40,
                    color: const Color(0xFF000000),
                  ),
                child: Text(
                  '       a) Development of a module for college deans to access alumni engagement and success data for informed decision-making.
                     b) 
                ),
              ),
            ],
          ),
        ),
      ),
    )
  }
}