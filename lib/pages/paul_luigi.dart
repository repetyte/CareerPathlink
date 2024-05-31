import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PaulLuigi extends StatelessWidget {
  const PaulLuigi({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
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
                      'assets/vectors/ellipse_539_x2.svg',
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
    );
  }
}