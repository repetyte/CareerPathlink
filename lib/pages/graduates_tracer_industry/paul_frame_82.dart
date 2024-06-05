import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaulFrame82 extends StatelessWidget {
  const PaulFrame82({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: const BoxDecoration(
        color: Color(0xFFD9D9D9),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 9, 5, 22),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 1.5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        text: 'ID number: ',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: const Color(0xFF000000),
                        ),
                        children: [
                          TextSpan(
                            text: '18-2929',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Date of Graduation: ',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: const Color(0xFF000000),
                      ),
                      children: [
                        TextSpan(
                          text: '25 July 2022',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Course: ',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: const Color(0xFF000000),
                      ),
                      children: [
                        TextSpan(
                          text: 'AB Political Science',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'UNC-mail: ',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: const Color(0xFF000000),
                    ),
                    children: [
                      TextSpan(
                        text: 'Choco.Martir@unc.edu.ph',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              bottom: -14,
              child: SizedBox(
                height: 15,
                child: RichText(
                  text: TextSpan(
                    text: 'Phone Number: ',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: const Color(0xFF000000),
                    ),
                    children: [
                      TextSpan(
                        text: '0922545421221',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.3,
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
    );
  }
}