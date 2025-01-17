import 'package:flutter/material.dart';
import 'package:flutter_app/controller/simple_ui_controller.dart';
import 'package:flutter_app/pages/students_account/career_coaching/home_screen.dart';
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
      // home: const SignUpView(), // final route
      home: const HomeScreen(), // routes for testing purposes
      initialRoute: '/',
      routes: {
        // '/': (context) => const SignUpView(),

        // // Graduates Account Routes
        // '/graduate/recruitment_and_placement': (context) => const RrJobDashboardUser(graduateAccount: null),

        // // Students Account Routes
        // '/student/career_coachinhg': (context) => const HomeScreen(),
        // '/student/work_integrated_learning': (context) => const InternshipDashboardStud(),

        // // College Deans/Coach Account Routes
        // '/deans/career_coaching': (context) => const RrJobDashboardUser(), // test only: should be Career Coaching
        // '/deans/graduates_tracer_industry': (context) => const InternshipDashboardStud(), // test only: should be Graduates Tracer Industry
        
        // // Employer Partners Account Routes
        // '/partner/recruitment_and_placement': (context) => const RrJobDashboardEmpPartners(),
        // '/partner/work_integrated_learning': (context) => const RrJobDashboardEmpPartners(), // test only: should be Worn Integrated Learning

        // // Career Center Director Account Routes
        // '/career_center_director/recruitment_and_placement': (context) => const RrJobDashboardUser(), // test only: should be Recruitment and Placement
        // '/career_center_director/career_coaching': (context) => const JobPostingDetailsScreen(),  // test only: should be Career Coaching
        // '/career_center_director/work_integrated_learning': (context) => const JobPostingDetailsScreen(), // test only: should be Work Integrated Learning
        // '/career_center_director/graduates_tracer_industry': (context) => const JobPostingDetailsScreen(),  // test only: should be Graduates Tracer Industry
        
      },
    );
  }
}
