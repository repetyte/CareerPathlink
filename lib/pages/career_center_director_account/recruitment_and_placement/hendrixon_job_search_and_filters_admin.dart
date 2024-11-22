import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HendrixonJobSearchAndFiltersAdmin extends StatelessWidget {
  const HendrixonJobSearchAndFiltersAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 19),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(19, 11, 0, 11.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 17.5,
                        height: 17.5,
                        child: SizedBox(
                          width: 17.5,
                          height: 17.5,
                          child: SvgPicture.asset(
                            'assets/vectors/vector_124_x2.svg',
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 3, 0, 2.5),
                        child: Text(
                          'Search jobs here...',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: const Color(0xFF808080),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(6, 0, 6, 19),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Filters',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: const Color(0xFF000000),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(6, 0, 6, 25),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 13),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Field/Industry',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(11, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                                    width: 18,
                                    height: 18,
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: SvgPicture.asset(
                                        'assets/vectors/vector_286_x2.svg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                    child: Text(
                                      'Engineering',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 13.1, 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                                  width: 18,
                                  height: 18,
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_432_x2.svg',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                  child: Text(
                                    'Business and Finance',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                                  width: 18,
                                  height: 18,
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_208_x2.svg',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                  child: Text(
                                    'Information Technology',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                                    width: 18,
                                    height: 18,
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: SvgPicture.asset(
                                        'assets/vectors/vector_215_x2.svg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                    child: Text(
                                      'Education',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                                    width: 18,
                                    height: 18,
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: SvgPicture.asset(
                                        'assets/vectors/vector_161_x2.svg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                    child: Text(
                                      'Healthcare',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                                    width: 18,
                                    height: 18,
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: SvgPicture.asset(
                                        'assets/vectors/vector_304_x2.svg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                    child: Text(
                                      'Law Enforcement',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                                  width: 18,
                                  height: 18,
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_454_x2.svg',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                  child: Text(
                                    'Architecture',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(6, 0, 6, 25),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 13),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Job Level',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(11, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 5.9, 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 9.2, 0),
                                  width: 18,
                                  height: 18,
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_234_x2.svg',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                  child: Text(
                                    'Entry Level',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 17.9, 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 9.2, 0),
                                  width: 18,
                                  height: 18,
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_160_x2.svg',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                  child: Text(
                                    'Mid-level',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 9.3, 0),
                                width: 18,
                                height: 18,
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: SvgPicture.asset(
                                    'assets/vectors/vector_39_x2.svg',
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                child: Text(
                                  'Senior Level',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(6, 0, 6, 25),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                      child: Text(
                        'Years of Experience Needed',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(11, 0, 11, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 9.4, 0),
                                    width: 18,
                                    height: 18,
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: SvgPicture.asset(
                                        'assets/vectors/vector_244_x2.svg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                    child: Text(
                                      'Fresh Graduate',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 9.2, 0),
                                      width: 18,
                                      height: 18,
                                      child: SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: SvgPicture.asset(
                                          'assets/vectors/vector_146_x2.svg',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                      child: Text(
                                        '<1 year',
                                        style: GoogleFonts.getFont(
                                          'Montserrat',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: const Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 9.1, 0),
                                      width: 18,
                                      height: 18,
                                      child: SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: SvgPicture.asset(
                                          'assets/vectors/vector_518_x2.svg',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                      child: Text(
                                        '1-3 years',
                                        style: GoogleFonts.getFont(
                                          'Montserrat',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: const Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 9.3, 0),
                                      width: 18,
                                      height: 18,
                                      child: SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: SvgPicture.asset(
                                          'assets/vectors/vector_434_x2.svg',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                      child: Text(
                                        '3-5 years',
                                        style: GoogleFonts.getFont(
                                          'Montserrat',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: const Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                                    width: 18,
                                    height: 18,
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: SvgPicture.asset(
                                        'assets/vectors/vector_173_x2.svg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                    child: Text(
                                      '5+ years',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: const Color(0xFF000000),
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
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(6, 0, 6, 25),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 13),
                      child: Text(
                        'Contractual Status',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(11, 0, 11, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 15.8, 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 13.2, 0),
                                    width: 18,
                                    height: 18,
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: SvgPicture.asset(
                                        'assets/vectors/vector_95_x2.svg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                    child: Text(
                                      'Full-time',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 12.1, 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 13.5, 0),
                                    width: 18,
                                    height: 18,
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: SvgPicture.asset(
                                        'assets/vectors/vector_126_x2.svg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                    child: Text(
                                      'Part-time',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 13.4, 0),
                                  width: 18,
                                  height: 18,
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_110_x2.svg',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                  child: Text(
                                    'Contractual',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(6, 0, 6, 25),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 13),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Salary Range',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                                    width: 18,
                                    height: 18,
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: SvgPicture.asset(
                                        'assets/vectors/vector_167_x2.svg',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                    child: Text(
                                      'Below PHP 10,000',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 11, 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 9.4, 0),
                                  width: 18,
                                  height: 18,
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_284_x2.svg',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                  child: Text(
                                    'PHP 10,000 - PHP 50,000',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 9.4, 0),
                                  width: 18,
                                  height: 18,
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_529_x2.svg',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                  child: Text(
                                    'PHP 50,000  - PHP 100,000',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 9.4, 0),
                                  width: 18,
                                  height: 18,
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_502_x2.svg',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                  child: Text(
                                    'Above PHP 100,000',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(6, 0, 6, 3),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 23),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Location',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(9.9, 0, 0, 0),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.5),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 0, 9.2, 0),
                                          width: 18,
                                          height: 18,
                                          child: SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: SvgPicture.asset(
                                              'assets/vectors/vector_452_x2.svg',
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                          child: Text(
                                            'Around Naga City',
                                            style: GoogleFonts.getFont(
                                              'Montserrat',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: const Color(0xFF000000),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 5.3, 6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0, 0, 9.4, 0),
                                        width: 18,
                                        height: 18,
                                        child: SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: SvgPicture.asset(
                                            'assets/vectors/vector_164_x2.svg',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                        child: Text(
                                          'Around Camarines Sur',
                                          style: GoogleFonts.getFont(
                                            'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: const Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 0, 9.2, 0),
                                          width: 18,
                                          height: 18,
                                          child: SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: SvgPicture.asset(
                                              'assets/vectors/vector_369_x2.svg',
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                                          child: Text(
                                            'Around Bicol Rrgion',
                                            style: GoogleFonts.getFont(
                                              'Montserrat',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: const Color(0xFF000000),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 168.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 13.5),
                                        width: 18,
                                        height: 18,
                                        child: SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: SvgPicture.asset(
                                            'assets/vectors/vector_94_x2.svg',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0, 1.5, 0, 0),
                                        child: Text(
                                          'Domestic/Around Philippines',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.getFont(
                                            'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: const Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: SvgPicture.asset(
                                    'assets/vectors/vector_211_x2.svg',
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 27,
                              bottom: 1.5,
                              child: SizedBox(
                                height: 15,
                                child: Text(
                                  'Abroad',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF0000),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      'Save',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
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