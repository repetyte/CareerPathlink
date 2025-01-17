import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'in_process.dart'; // Import InProcessRequests
import 'pending_request.dart';
import 'completed.dart'; // Import Completed
import '../../students_account/career_coaching/footer.dart';
import '../../../widgets/appbar/cc_coach_header.dart';

class CoachScreen extends StatelessWidget {
  final double screenWidth;

  const CoachScreen({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgramScheduleScreen(screenWidth: screenWidth),
    );
  }
}

class ProgramScheduleScreen extends StatefulWidget {
  final double screenWidth;
  const ProgramScheduleScreen({super.key, required this.screenWidth});

  @override
  _ProgramScheduleScreenState createState() => _ProgramScheduleScreenState();
}

class _ProgramScheduleScreenState extends State<ProgramScheduleScreen> {
  int selectedIndex = 0;
  final List<String> buttonLabels = [
    'Pending',
    'In Process',
    'Completed', // Added Completed tab
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: Column(
                    children: [
                      // Adding more vertical space between the header and the buttons
                      const SizedBox(height: 20), // Increased space here
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(buttonLabels.length, (index) {
                            final isMobile = widget.screenWidth < 600;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedIndex == index
                                      ? const Color(0xFFEC1D25)
                                      : const Color.fromARGB(255, 90, 90, 90),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 8 : 16,
                                    vertical: isMobile ? 6 : 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  buttonLabels[index],
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobile ? 14 : 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Show relevant section based on selectedIndex
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 180,
                        child: selectedIndex == 0
                            ? PendingSection(screenWidth: widget.screenWidth)
                            : selectedIndex == 1
                                ? InProcessRequests(
                                    screenWidth: widget.screenWidth)
                                : Completed(), // Display the Completed section
                      ),
                    ],
                  ),
                ),
                const Footer(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              elevation: 4.0,
              color: Colors.white,
              child: const Header(),
            ),
          ),
        ],
      ),
    );
  }
}
