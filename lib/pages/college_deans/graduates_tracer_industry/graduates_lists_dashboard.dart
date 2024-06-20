import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'graduates_lists.dart'; // Import the GraduatesLists page

class GraduatesListsDashboard extends StatelessWidget {
  final List<Map<String, String>> departments = [
    {
      "image": "assets/images/college_arts_sciences.png",
      "name": "College of Arts and Sciences"
    },
    {
      "image": "assets/images/college_business_accountancy.png",
      "name": "College of Business and Accountancy"
    },
    {
      "image": "assets/images/college_computer_studies.png",
      "name": "College of Computer Studies"
    },
    {
      "image": "assets/images/college_criminal.png",
      "name": "College of Criminal Justice Education"
    },
    {
      "image": "assets/images/college_education.png",
      "name": "College of Education"
    },
    {
      "image": "assets/images/college_engineering.png",
      "name": "College of Engineering and Architecture"
    },
    {"image": "assets/images/college_law.png", "name": "School of Law"},
    {
      "image": "assets/images/college_nursing.png",
      "name": "College of Nursing"
    },
  ];

  GraduatesListsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Back Button and Title
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                width: double.infinity,
                height: 100,
                color: const Color(0xFF232222),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        'Graduates Lists',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/image_1.png'),
                            radius: 30,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Last Update: 10 Aug. 2023',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Container for the departments list
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF808080),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(34, 50, 34, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Departments',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // GridView.builder wrapped in a ConstrainedBox for height limit
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: departments.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigate to the graduates lists of the selected department
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GraduatesLists(
                                    departmentName: departments[index]["name"]!,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          departments[index]["image"]!,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Text(
                                      departments[index]["name"]!,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
