import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PaulDeanGraduatesDepartment extends StatelessWidget {
  const PaulDeanGraduatesDepartment({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF232222),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 27.2, 0, 38.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.4),
                    width: 28.4,
                    height: 11.1,
                    child: SizedBox(
                      width: 28.4,
                      height: 11.1,
                      child: SvgPicture.asset(
                        'assets/vectors/image_14_x2.svg',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0.2, 0, 0),
                    child: SizedBox(
                      width: 66.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0.3, 5, 0.3),
                            child: SizedBox(
                              width: 17,
                              height: 10.7,
                              child: SvgPicture.asset(
                                'assets/vectors/mobile_signal_11_x2.svg',
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 5, 0.4),
                            child: SizedBox(
                              width: 15.3,
                              height: 11,
                              child: SvgPicture.asset(
                                'assets/vectors/wifi_3_x2.svg',
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              width: 24.3,
                              height: 11.3,
                              child: SvgPicture.asset(
                                'assets/vectors/battery_7_x2.svg',
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
            decoration: const BoxDecoration(
              color: Color(0x33000000),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
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
                          margin: const EdgeInsets.fromLTRB(16, 0, 16, 61),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                  child: SizedBox(
                                    width: 14,
                                    height: 26,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_315_x2.svg',
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 3),
                                  child: Text(
                                    'Dashboard',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(30, 0, 30, 51),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 17.5,
                                  sigmaY: 17.5,
                                ),
                                child: Text(
                                  'Graduates Lists',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 29,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF808080),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80),
                              topRight: Radius.circular(80),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(34, 41.5, 29, 848),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 1, 37.5),
                                  child: Text(
                                    'Departments',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 1, 35),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(0, 0, 46, 0),
                                          child: Stack(
                                            children: [
                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0,
                                              child: ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                  sigmaX: 2,
                                                  sigmaY: 2,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: const Color(0xFF000000)),
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: const Color(0xFFFFFFFF),
                                                  ),
                                                  child: const SizedBox(
                                                    width: 160,
                                                    height: 179,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      Container(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.5),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 11.5),
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                              'assets/images/cas_removebg_preview_1.png',
                                                            ),
                                                          ),
                                                        ),
                                                        child: const SizedBox(
                                                          width: 101,
                                                          height: 101,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(0, 0, 1, 0),
                                                      child: Text(
                                                        'College of Arts and Sciences',
                                                        textAlign: TextAlign.center,
                                                        style: GoogleFonts.getFont(
                                                          'Montserrat',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 13,
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
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: -15.1,
                                              right: -15.1,
                                              top: -25,
                                              bottom: -15.5,
                                              child: ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                  sigmaX: 2,
                                                  sigmaY: 2,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: const Color(0xFF000000)),
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: const Color(0xFFFFFFFF),
                                                  ),
                                                  child: const SizedBox(
                                                    width: 160,
                                                    height: 179,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      Container(
                                              padding: const EdgeInsets.fromLTRB(15.1, 25, 15.1, 15.5),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 16.5),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                            'assets/images/cea_removebg_preview_1.png',
                                                          ),
                                                        ),
                                                      ),
                                                      child: const SizedBox(
                                                        width: 100,
                                                        height: 100,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'College of Engineering and Architecture',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.getFont(
                                                      'Montserrat',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 11,
                                                      height: 1,
                                                      color: const Color(0xFF000000),
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
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 43),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(0, 0, 47, 0),
                                          child: Stack(
                                            children: [
                                            Positioned(
                                              left: -14.4,
                                              right: -15.4,
                                              top: -25,
                                              bottom: -19.5,
                                              child: ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                  sigmaX: 2,
                                                  sigmaY: 2,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: const Color(0xFF000000)),
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: const Color(0xFFFFFFFF),
                                                  ),
                                                  child: const SizedBox(
                                                    width: 160,
                                                    height: 179,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      Container(
                                                padding: const EdgeInsets.fromLTRB(14.4, 25, 15.4, 19.5),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 11.5),
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                              'assets/images/cba_removebg_preview_1.png',
                                                            ),
                                                          ),
                                                        ),
                                                        child: const SizedBox(
                                                          width: 101,
                                                          height: 101,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      'College of Business and Accountancy',
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.getFont(
                                                        'Montserrat',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 13,
                                                        height: 0.8,
                                                        color: const Color(0xFF000000),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: -18.8,
                                              right: -19.8,
                                              top: -29,
                                              bottom: -19.5,
                                              child: ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                  sigmaX: 2,
                                                  sigmaY: 2,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: const Color(0xFF000000)),
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: const Color(0xFFFFFFFF),
                                                  ),
                                                  child: const SizedBox(
                                                    width: 160,
                                                    height: 179,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      Container(
                                              padding: const EdgeInsets.fromLTRB(18.8, 29, 19.8, 19.5),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 13.5),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                            'assets/images/ccs_removebg_preview_1.png',
                                                          ),
                                                        ),
                                                      ),
                                                      child: const SizedBox(
                                                        width: 103,
                                                        height: 95,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'College of Computer Studies',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.getFont(
                                                      'Montserrat',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 13,
                                                      height: 0.8,
                                                      color: const Color(0xFF000000),
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
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 1, 40),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(0, 0, 46, 0),
                                          child: Stack(
                                            children: [
                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0,
                                              child: ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                  sigmaX: 2,
                                                  sigmaY: 2,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: const Color(0xFF000000)),
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: const Color(0xFFFFFFFF),
                                                  ),
                                                  child: const SizedBox(
                                                    width: 160,
                                                    height: 179,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      Container(
                                                padding: const EdgeInsets.fromLTRB(0, 37, 2, 25),
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                                          child: SizedBox(
                                                            width: 96,
                                                            height: 91,
                                                            child: SvgPicture.asset(
                                                              'assets/vectors/ellipse_21_x2.svg',
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                                                          child: Text(
                                                            'School of Law',
                                                            style: GoogleFonts.getFont(
                                                              'Montserrat',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 13,
                                                              height: 0.8,
                                                              color: const Color(0xFF000000),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Positioned(
                                                      top: 33,
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                              'assets/images/law_removebg_preview_11.png',
                                                            ),
                                                          ),
                                                        ),
                                                        child: const SizedBox(
                                                          width: 97,
                                                          height: 97,
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
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: -10.5,
                                              right: -10.5,
                                              top: -33,
                                              bottom: -25,
                                              child: ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                  sigmaX: 2,
                                                  sigmaY: 2,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: const Color(0xFF000000)),
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: const Color(0xFFFFFFFF),
                                                  ),
                                                  child: const SizedBox(
                                                    width: 160,
                                                    height: 179,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      Container(
                                              padding: const EdgeInsets.fromLTRB(10.5, 33, 10.5, 25),
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          margin: const EdgeInsets.fromLTRB(0, 0, 2, 14),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color: const Color(0xFFFFFFFF),
                                                              borderRadius: BorderRadius.circular(48),
                                                            ),
                                                            child: const SizedBox(
                                                              width: 96,
                                                              height: 96,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'College of Education',
                                                          style: GoogleFonts.getFont(
                                                            'Montserrat',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 13,
                                                            height: 0.8,
                                                            color: const Color(0xFF000000),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                            'assets/images/law_removebg_preview_111.png',
                                                          ),
                                                        ),
                                                      ),
                                                      child: const SizedBox(
                                                        width: 97,
                                                        height: 97,
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
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 1, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(0, 0, 46, 0),
                                          child: Stack(
                                            children: [
                                            Positioned(
                                              left: -15.9,
                                              right: -16.9,
                                              top: -35,
                                              bottom: -15.5,
                                              child: ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                  sigmaX: 2,
                                                  sigmaY: 2,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: const Color(0xFF000000)),
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: const Color(0xFFFFFFFF),
                                                  ),
                                                  child: const SizedBox(
                                                    width: 160,
                                                    height: 179,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      Container(
                                                padding: const EdgeInsets.fromLTRB(15.9, 35, 16.9, 15.5),
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.fromLTRB(13.1, 0, 18.1, 10.5),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                color: const Color(0xFFFFFFFF),
                                                                borderRadius: BorderRadius.circular(48),
                                                              ),
                                                              child: const SizedBox(
                                                                width: 96,
                                                                height: 96,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            'College of Criminal Justice Educatrion',
                                                            textAlign: TextAlign.center,
                                                            style: GoogleFonts.getFont(
                                                              'Montserrat',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 13,
                                                              height: 0.8,
                                                              color: const Color(0xFF000000),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 9.1,
                                                      top: -3,
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                              'assets/images/law_removebg_preview_112.png',
                                                            ),
                                                          ),
                                                        ),
                                                        child: const SizedBox(
                                                          width: 103,
                                                          height: 100,
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
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: -18,
                                              right: -18,
                                              top: 0,
                                              bottom: 0,
                                              child: ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                  sigmaX: 2,
                                                  sigmaY: 2,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: const Color(0xFF000000)),
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: const Color(0xFFFFFFFF),
                                                  ),
                                                  child: const SizedBox(
                                                    width: 160,
                                                    height: 179,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      Container(
                                              padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.fromLTRB(0, 0, 2, 14),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(48),
                                                        image: const DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                            'assets/images/ellipse_1.png',
                                                          ),
                                                        ),
                                                      ),
                                                      child: const SizedBox(
                                                        width: 96,
                                                        height: 96,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'College of Nursing',
                                                    style: GoogleFonts.getFont(
                                                      'Montserrat',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 13,
                                                      height: 0.8,
                                                      color: const Color(0xFF000000),
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 33,
                    top: 39,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/image_1.png',
                          ),
                        ),
                      ),
                      child: const SizedBox(
                        width: 147,
                        height: 147,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    top: 133,
                    child: SizedBox(
                      height: 20,
                      child: Text(
                        'Last Update: 10 Aug. 2023',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
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
    );
  }
}