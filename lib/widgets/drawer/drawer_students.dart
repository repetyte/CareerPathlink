import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/coach_model.dart';
import 'package:flutter_app/models/user_role/student.dart';
import 'package:flutter_app/pages/students_account/career_coaching/notification_provider.dart';
import 'package:flutter_app/pages/students_account/student_home_screen.dart';
import 'package:flutter_app/pages/students_account/work_integrated_learning/internship_dashboard_stud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../pages/students_account/career_coaching/terms_conditions_screen.dart';

class MyDrawerStudents extends StatelessWidget {
  CoachAccount? coachAccount;
  final StudentAccount studentAccount;
  MyDrawerStudents({super.key, required this.studentAccount, this.coachAccount});

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
              // navigateTo("/rr_job_dashboard", context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreenStudent(
                    studentAccount: studentAccount,
                  ),
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AppointmentBookingScreen(
              //       studentAccount: studentAccount,
              //     ), // Navigate to AppointmentBookingScreen
              //   ),
              // );
              // When navigating to AppointmentBookingScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (_) => StudentNotificationProvider(),
                    child: AppointmentBookingScreen(
                        studentAccount: studentAccount, coachAccount: coachAccount,),
                  ),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InternshipDashboardStud(
                    studentAccount: studentAccount,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
