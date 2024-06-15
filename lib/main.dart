import 'package:flutter/material.dart';
import 'package:flutter_app/pages/admin/job_posting_details_screen.dart';
import 'package:flutter_app/pages/user/rr_job_dashboard_user.dart';
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
      title: 'Recruitment and Placement',
      theme: AppTheme.themeData,
      home: const RrJobDashboardUser(),
      initialRoute: '/',
      routes: {
        '/rr_job_dashboard': (context) => const RrJobDashboardUser(),
        '/details': (context) => const JobPostingDetailsScreen(),
      },
    );
  }
}
