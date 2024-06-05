import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PaulDeanGraduatesUnemployedCcs extends StatelessWidget {
  const PaulDeanGraduatesUnemployedCcs({super.key});

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
      child: Container(
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
                          'assets/vectors/image_1_x2.svg',
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
                                  'assets/vectors/mobile_signal_5_x2.svg',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 5, 0.4),
                              child: SizedBox(
                                width: 15.3,
                                height: 11,
                                child: SvgPicture.asset(
                                  'assets/vectors/wifi_18_x2.svg',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: SizedBox(
                                width: 24.3,
                                height: 11.3,
                                child: SvgPicture.asset(
                                  'assets/vectors/battery_15_x2.svg',
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
                padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
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
                            margin: const EdgeInsets.fromLTRB(11, 0, 11, 66),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(0, 11.5, 0, 10.5),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 0,
                                      bottom: 0,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                              'assets/images/back.png',
                                            ),
                                          ),
                                        ),
                                        child: const SizedBox(
                                          width: 38,
                                          height: 38,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Back',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 52),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 17.5,
                                    sigmaY: 17.5,
                                  ),
                                  child: Text(
                                    'Unemployed Lists',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
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
                              padding: const EdgeInsets.fromLTRB(29, 26.5, 34, 879),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 18, 12.5),
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x40000000),
                                          offset: Offset(2, 4),
                                          blurRadius: 2.5,
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      'College of Computer Studies',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: const Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 6, 35),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color(0xFFFFFFFF),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x40000000),
                                          offset: Offset(3, 4),
                                          blurRadius: 3,
                                        ),
                                      ],
                                    ),
                                    child: SizedBox(
                                      width: 325,
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(12.6, 5, 10, 6),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(0, 5.5, 9, 4.5),
                                              child: SizedBox(
                                                width: 265.4,
                                                child: Text(
                                                  'Search the name...',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                    color: const Color(0xFF676565),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(
                                                    'assets/images/search.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 28,
                                                height: 28,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 6),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(11.1, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 9.1, 10),
                                                child: Text(
                                                  '1.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_3.png.png',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Choco Martir',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 1, 6),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(11.1, 4, 15, 7),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 12.5, 6.1, 8.5),
                                                child: Text(
                                                  '2.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_4.png.png',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 12.5, 0, 8.5),
                                                child: Text(
                                                  'Yassi Pressman',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 7, 0, 2),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 6),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(12.2, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 5.2, 10),
                                                child: Text(
                                                  '3.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_51.jpeg.jpeg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Luigi Villafuerte',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 4),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(11.5, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 4.5, 10),
                                                child: Text(
                                                  '4.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_55.jpeg.jpeg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Miguel Luis Villafuerte',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(12.2, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 5.2, 10),
                                                child: Text(
                                                  '5.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_510.jpeg.jpeg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Nelson Legacion',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 4),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(11.9, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 4.9, 10),
                                                child: Text(
                                                  '6.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_58.jpeg.jpeg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Manny Pacquiao',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 4),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(11, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 4, 10),
                                                child: Text(
                                                  '7..',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_56.jpeg.jpeg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Juan Ponce Enrile',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 4),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(11.7, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 4.7, 10),
                                                child: Text(
                                                  '8.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_59.jpeg.jpeg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Nonoy Peña',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(12, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 5, 10),
                                                child: Text(
                                                  '9.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_5.jpeg.jpeg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Andrew Eeeee',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 4),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(9.5, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 2.5, 10),
                                                child: Text(
                                                  '10.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_512.jpeg.jpeg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Brad Pete Alien',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(11.2, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 4.2, 10),
                                                child: Text(
                                                  '11.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_53.jpeg.jpeg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Toni Gonzaga',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(9.9, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 2.9, 10),
                                                child: Text(
                                                  '12.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_54.jpeg.jpeg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Kap Nino Barzaga',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 3, 10),
                                                child: Text(
                                                  '13.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_52.jpeg.jpeg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Baron Geisler',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(9.3, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 2.3, 10),
                                                child: Text(
                                                  '14.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_511.jpeg.jpeg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Melai Contiveros',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF000000)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 15, 6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 11, 3, 10),
                                                child: Text(
                                                  '15.',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                child: SizedBox(
                                                  width: 39,
                                                  height: 36,
                                                  child: SvgPicture.asset(
                                                    'assets/images/ellipse_57.jpeg.jpeg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10.5, 0, 10.5),
                                                child: Text(
                                                  'Marlon Velasquez',
                                                  style: GoogleFonts.getFont(
                                                    'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: const Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/menu_vertical.png',
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 27,
                                                height: 27,
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
      ),
    );
  }
}