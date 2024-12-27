import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HendrixonAddAjob extends StatelessWidget {
  const HendrixonAddAjob({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: 
        
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                ),
                child: const SizedBox(
                  width: 430,
                  height: 100,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Container(
                            margin:
                                const EdgeInsets.fromLTRB(0, 0, 0, 16),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF808080),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                      
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF808080),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50),
                                        ),
                                      ),
                                      child: const SizedBox(
                                        width: 380,
                                        height: 150,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 16, 16, 16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment:
                                              Alignment.topCenter,
                                          child: Text(
                                            'click to choose cover photo....',
                                            style:
                                                GoogleFonts.getFont(
                                              'Montserrat',
                                              fontWeight:
                                                  FontWeight.w400,
                                              fontSize: 12,
                                              color: const Color(
                                                  0xFFD9D9D9),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              Alignment.topLeft,
                                          child: Text(
                                            'Job Title',
                                            style:
                                                GoogleFonts.getFont(
                                              'Montserrat',
                                              fontWeight:
                                                  FontWeight.w700,
                                              fontSize: 16,
                                              color: const Color(
                                                  0xFFFFFFFF),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(
                                                    0xFF000000)),
                                            borderRadius:
                                                BorderRadius.circular(
                                                    20),
                                            color:
                                                const Color(0xFFD9D9D9),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets
                                                .fromLTRB(
                                                14, 16.5, 14, 16.5),
                                            child: Text(
                                              'type here...',
                                              style:
                                                  GoogleFonts.getFont(
                                                'Montserrat',
                                                fontWeight:
                                                    FontWeight.w400,
                                                fontSize: 12,
                                                color: const Color(
                                                    0xFF808080),
                                              ),
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



                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16, 0, 0, 0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        0, 0, 0, 13),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Field/Industry',
                                        style: GoogleFonts.getFont(
                                          'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color:
                                              const Color(0xFF000000),
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
                ],
              ),
            ),
          ],
        ),


      ),
    );
  }
}
