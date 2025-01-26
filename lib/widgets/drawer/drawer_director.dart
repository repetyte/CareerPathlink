import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/career_center_director.dart';
import 'package:flutter_app/pages/career_center_director_account/career_coaching/coaching_home_screen.dart';
import 'package:flutter_app/pages/career_center_director_account/director_home_screen.dart';
import 'package:flutter_app/pages/career_center_director_account/graduates_tracer_industry/graduates_tracer.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawerDirector extends StatelessWidget {
  final CareerCenterDirectorAccount careerCenterDirectorAccount;
  const MyDrawerDirector({super.key, required this.careerCenterDirectorAccount});

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
                    HomeScreenDirector(careerCenterDirectorAccount: careerCenterDirectorAccount,),
              ),
            );
            },
          ),
          ListTile(
            leading: const Icon(Icons.work),
            title: const Text(
              'Recruitment and Placement',
              style: TextStyle(),
            ),
            onTap: () {
            //   Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => RrJobDashboardUser(graduateAccount: graduateAccount),
            //   ),
            // );
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
                    EngagementDashboard(careerCenterDirectorAccount: careerCenterDirectorAccount,),
              ),
            );
            },
          ),
          ListTile(
            leading: const Icon(Icons.on_device_training),
            title: const Text(
              'Work Integrated Learning',
              style: TextStyle(
                height: 1.3,
              ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text(
              'Graduates Tracer Industry',
              style: TextStyle(
                height: 1.3,
              ),
            ),
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TracerDashboardPartner(careerCenterDirectorAccount: careerCenterDirectorAccount,),
              ),
            );
            },
          ),
          
        ],
      ),
    );
  }
}
