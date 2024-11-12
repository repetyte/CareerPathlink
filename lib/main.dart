import 'package:flutter/material.dart';
import 'package:flutter_app/pages/career_center_staff/recruitment_and_placement/job_posting_details_screen.dart';
import 'package:flutter_app/pages/career_center_staff/recruitment_and_placement/rr_job_dashboard_admin.dart';
import 'package:flutter_app/pages/graduates/recruitment_and_placement/rr_job_dashboard_user.dart';
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
      // home: const Dashboard(),
      home: const RrJobDashboardAdmin(),
      initialRoute: '/',
      routes: {
        '/rr_job_dashboard_user': (context) => const RrJobDashboardUser(),
        '/details': (context) => const JobPostingDetailsScreen(),
      },
    );
  }
}
