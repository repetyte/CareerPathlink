import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaulExecutiveSummary2 extends StatelessWidget {
  const PaulExecutiveSummary2({super.key});

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
          padding: const EdgeInsets.fromLTRB(44, 63.5, 78.2, 602),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(33.2, 0, 0, 25.5),
                child: Text(
                  'Technical Approach',
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 60,
                    color: const Color(0xFF000000),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(7, 0, 0.7, 76),
                child: RichText(
                  text: TextSpan(
                    text: 'Methodology:',
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                      color: const Color(0xFF000000),
                    ),
                    children: [
                      TextSpan(
                        text: ' I use scrum methodology for this module
              ',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 40,
                          height: 1.3,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                          height: 1.3,
                          color: const Color(0xFF0000FF),
                        ),
                      ),
                      TextSpan(
                        text: 'https://docs.google.com/document/d/1hI0rCBT9UpjXkIFBh8jsq7ZkB71ClgbcfnJw41dQE-s/edit',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 40,
                          height: 1.3,
                          color: const Color(0xFF0000FF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Tools:',
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                    color: const Color(0xFF000000),
                  ),
                  children: [
                    TextSpan(
                      text: ' 
              ',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 40,
                        height: 1.3,
                      ),
                    ),
                    TextSpan(
                      text: ' ',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                        height: 1.3,
                        color: const Color(0xFF0000FF),
                      ),
                    ),
                    TextSpan(
                      text: 'https://docs.google.com/document/d/1We5njaz9smwst2QspzVJubZusrdiZNR8tSQHDbw5J8w/edit',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 40,
                        height: 1.3,
                        color: const Color(0xFF0000FF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}