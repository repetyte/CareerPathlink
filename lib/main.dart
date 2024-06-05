import 'package:flutter/material.dart';
import 'package:flutter_app/pages/admin/job_posting_details_screen.dart';
import 'package:flutter_app/pages/admin/job_postings_screen.dart';
import 'package:provider/provider.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ApiService()),
      ],
      child: MaterialApp(
        title: 'Recruitment and Placement',
        theme: ThemeData(
          fontFamily: 'Montserrat', colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(secondary: Colors.red),
        ),
        home: const JobPostingsScreen(),
        routes: {
          '/details': (context) => const JobPostingDetailsScreen(),
        },
      ),
    );
  }
}
