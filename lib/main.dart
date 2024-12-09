import 'package:flutter/material.dart';
import 'package:flutter_app/pages/career_center_director_account/recruitment_and_placement/job_posting_details_screen.dart';
import 'package:flutter_app/pages/employer_partners_account/recruitment_and_placement/rr_job_dashboard_emp_partners.dart';
import 'package:flutter_app/pages/graduates_account/recruitment_and_placement/rr_job_dashboard_graduates.dart';
import 'theme.dart';

void main() {
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
      // home: const RrJobDashboardUser(),
      home: const RrJobDashboardEmpPartners(),
      initialRoute: '/',
      routes: {
        '/rr_job_dashboard_user': (context) => const RrJobDashboardUser(),
        '/details': (context) => const JobPostingDetailsScreen(),
      },
    );
  }
}
