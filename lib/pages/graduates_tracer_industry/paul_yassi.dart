import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaulYassi extends StatelessWidget {
  const PaulYassi({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: const BoxDecoration(
        color: Color(0xFFD9D9D9),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 9, 15.2, 22),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
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
                              text: '18-2999',
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
                            text: 'BS Information Technology',
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
                          text: 'Yassi.Pressman@unc.edu.ph',
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
                        text: '092258734983',
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