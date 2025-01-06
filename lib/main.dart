import 'package:flutter/material.dart';
import 'package:flutter_app/controller/simple_ui_controller.dart';
import 'package:flutter_app/pages/career_center_director_account/recruitment_and_placement/job_posting_details_screen.dart';
import 'package:flutter_app/pages/employer_partners_account/recruitment_and_placement/rr_job_dashboard_emp_partners.dart';
import 'package:flutter_app/pages/graduates_account/recruitment_and_placement/rr_job_dashboard_graduates.dart';
import 'package:flutter_app/pages/login_and_signup/signUp_view.dart';
import 'package:flutter_app/pages/login_and_signup/login_view.dart';
import 'pages/students_account/work_integrated_learning/internship_dashboard_stud.dart';
import 'theme.dart';
import 'package:get/get.dart';

void main() {
  Get.put(SimpleUIController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UNC CareerPathlink',
      theme: AppTheme.themeData,
      // darkTheme: ThemeData.dark(),

      // home: const LoginVisew(),
      // home: const SignUpView(),
      // home: const LoginScreen(),
      
      // home: const RrJobDashboardUser(),
      // home: const RrJobDashboardEmpPartners(),

      // home: InternshipDashboardStud(),

      // home: const HendrixonAddAjob(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SignUpView(),

        // Graduates Account Routes
        '/rr_job_dashboard_user': (context) => const RrJobDashboardUser(),

        // Employer Partners Account Routes
        '/rr_job_dashboard_emp_partners': (context) =>
            const RrJobDashboardEmpPartners(),
      },
    );
  }
}
