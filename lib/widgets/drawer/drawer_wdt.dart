import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/coach_model.dart';
import 'package:flutter_app/pages/wdt_account/wdt_home_screen.dart';
import 'package:flutter_app/pages/wdt_account/career_coaching/wdt_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawerCoach extends StatelessWidget {
  final CoachAccount coachAccount;
  final double screenWidth;
  const MyDrawerCoach({super.key, required this.coachAccount, required this.screenWidth});

  navigateTo(String route, BuildContext context) {
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/images/seal_of_university_of_nueva_caceres_2.png'),
                    ),
                  ),
                  child: const SizedBox(
                    width: 48,
                    height: 48,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UNC ',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: const Color(0xFF000000),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Career',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: const Color(0xFF9E9E9E),
                          ),
                        ),
                        Text(
                          'Pathlink',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: const Color.fromARGB(255, 255, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // child: Text('University\nCAREER CENTER\nManagement System'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomeScreenCoach(coachAccount: coachAccount, screenWidth: screenWidth,),
              ),
            );
            },
          ),
          ListTile(
            leading: const Icon(Icons.on_device_training),
            title: const Text(
              'Career Coaching',
              style: TextStyle(
                height: 1.3,
              ),
            ),
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CoachScreen(coachAccount: coachAccount, screenWidth: screenWidth,),
              ),
            );
            },
          ),
        ],
      ),
    );
  }
}
