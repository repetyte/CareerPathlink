import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_app/models/user_role/graduate.dart';
import 'package:flutter_app/pages/graduates_account/graduate_home_screen.dart';
import 'package:flutter_app/pages/graduates_account/recruitment_and_placement/rr_job_dashboard_graduates.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawerGraduates extends StatelessWidget {
final GraduateAccount graduateAccount;

  const MyDrawerGraduates({super.key, required this.graduateAccount});
=======

class MyDrawerGraduates extends StatelessWidget {
  const MyDrawerGraduates({super.key});
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65

  navigateTo(String route, BuildContext context) {
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
<<<<<<< HEAD
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
=======
          const DrawerHeader(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [
                        Text('UNIVERSITY',
                            style: TextStyle(
                              // fontWeight: FontWeight.w700,
                              fontSize: 12,
                              // color: const Color(0xFF000000),
                              height: 1.3,
                            )),
                        Text('CAREER CENTER',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              // color: const Color(0xFF000000),
                              height: 1.3,
                            )),
                        Text('MANAGEMENT SYSTEM',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              // color: const Color(0xFF000000),
                              height: 1.3,
                            )),
                      ]),
                    ],
                  ),
                ]),
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
            // child: Text('University\nCAREER CENTER\nManagement System'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
<<<<<<< HEAD
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreenGraduate(
                    graduateAccount: graduateAccount,
                  ),
                ),
              );
=======
              // navigateTo("/rr_job_dashboard", context);
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
            },
          ),
          ListTile(
            leading: const Icon(Icons.work),
            title: const Text(
              'Recruitment and Placement',
              style: TextStyle(),
            ),
            onTap: () {
<<<<<<< HEAD
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RrJobDashboardUser(graduateAccount: graduateAccount),
              ),
            );
=======
              navigateTo("/rr_job_dashboard_user", context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.on_device_training),
            title: const Text(
              'Career Engagement and Training',
              style: TextStyle(
                height: 1.3,
              ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
>>>>>>> 2b286650dd93c4f00f37a894a3d7a86db3622b65
            },
          ),
        ],
      ),
    );
  }
}
