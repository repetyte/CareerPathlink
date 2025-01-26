import 'package:flutter/material.dart';
import 'employed_lists_department.dart'; // Import the department details screen

class EmployedListsDirector extends StatelessWidget {
  const EmployedListsDirector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Department'),
      ),
      body: Column(
        children: [
          // Separator bar
          Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.all(16.0),
            child: const Center(
              child: Text(
                'Employed Lists',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
                departmentContainer('School of Social and Natural Sciences', 'assets/logo/social_sciences_logo.png', context),
                departmentContainer('College of Engineering and Architecture', 'assets/logo/engineering_logo.png', context),
                departmentContainer('School of Business and Accountancy', 'assets/logo/business_logo.png', context),
                departmentContainer('School of Computer and Information Sciences', 'assets/logo/computer_logo.png', context),
                departmentContainer('School of Law', 'assets/logo/law_logo.png', context),
                departmentContainer('School of Teachers Education', 'assets/logo/education_logo.png', context),
                departmentContainer('College of Criminal Justice Education', 'assets/logo/criminal_justice_logo.png', context),
                departmentContainer('School of Nursing and Allied Health Sciences', 'assets/logo/nursing_logo.png', context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget departmentContainer(String name, String logoPath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployedListsDepartmentDirector(departmentName: name),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
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
