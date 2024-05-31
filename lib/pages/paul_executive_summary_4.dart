import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaulExecutiveSummary4 extends StatelessWidget {
  const PaulExecutiveSummary4({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: const BoxDecoration(
        color: Color(0xFF5CF659),
      ),
      child: Container(
        width: 1920,
        padding: const EdgeInsets.fromLTRB(0, 467, 1, 497),
        child: Text(
          ' Screenshots of Design of Each Modules with Description:',
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 60,
            color: const Color(0xFF000000),
          ),
        ),
      ),
    );
  }
}