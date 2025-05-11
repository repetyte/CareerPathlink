import 'package:flutter/material.dart';
import 'graduates_lists_department.dart'; // Import for department tables

class GraduatesListsDean extends StatelessWidget {
  const GraduatesListsDean({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Department'),
      ),
      body: Column(
        children: [
          // Separator bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Graduates Lists',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Department Grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 4, // 4 containers per row
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              padding: const EdgeInsets.all(16.0),
              children: [
                departmentContainer(context, 'School of Social and Natural Sciences', 'assets/logo/social_sciences_logo.png'),
                departmentContainer(context, 'College of Engineering and Architecture', 'assets/logo/engineering_logo.png'),
                departmentContainer(context, 'School of Business and Accountancy', 'assets/logo/business_logo.png'),
                departmentContainer(context, 'School of Computer and Information Sciences', 'assets/logo/computer_logo.png'),
                departmentContainer(context, 'School of Law', 'assets/logo/law_logo.png'),
                departmentContainer(context, 'School of Teachers Education', 'assets/logo/education_logo.png'),
                departmentContainer(context, 'College of Criminal Justice Education', 'assets/logo/criminal_justice_logo.png'),
                departmentContainer(context, 'School of Nursing and Allied Health Sciences', 'assets/logo/nursing_logo.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget departmentContainer(BuildContext context, String name, String logoPath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GraduatesListsDepartmentDean(departmentName: name),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logoPath,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
