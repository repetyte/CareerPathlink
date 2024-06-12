import 'package:flutter/material.dart';
// import 'package:flutter_app/pages/user/hendrixon_dashboard_user.dart';
import 'package:flutter_app/pages/user/rr_job_dashboard_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recruitment and Placement',
      theme: ThemeData(
        fontFamily: 'Montserrat', colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(secondary: Colors.red),
      ),
      home: const RrJobDashboardUser(),
      // initialRoute: '/',
      routes: {
        '/rr_job_dashboard': (context) => const RrJobDashboardUser(),
        // '/details': (context) => JobPostingDetailsScreen(),
      },
    );
  }
}
