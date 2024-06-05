import 'package:flutter/material.dart';
import 'package:flutter_app/models/job_posting.dart';
import 'package:flutter_app/pages/recruitment_and_placement/job_detail_screen.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class JobPostingScreen extends StatefulWidget {
  const JobPostingScreen({super.key});

  @override
  _JobPostingScreenState createState() => _JobPostingScreenState();
}

class _JobPostingScreenState extends State<JobPostingScreen> {
  late Future<List<JobPosting>> futureJobPostings;

  @override
  void initState() {
    super.initState();
    futureJobPostings = ApiService().fetchJobPostings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.fromLTRB(0, 24, 25, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Image.asset(
                        'assets/images/seal_of_university_of_nueva_caceres_2.png',
                        height: 50),
                    SizedBox(width: 10),
                    // Text('Career Center\nManagement System'),
                    Column(children: [
                      Text('UNIVERSITY',
                          style: TextStyle(
                            // fontWeight: FontWeight.w700,
                            fontSize: 12,
                            // color: const Color(0xFF000000),
                            height: 1.3,
                          )),
                      Text('CAREER CENTER',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            // color: const Color(0xFF000000),
                            height: 1.3,
                          )),
                      Text('Management System',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            // color: const Color(0xFF000000),
                            height: 1.3,
                          )),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 24, 0, 24),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Recruitment and Placement',
              style: GoogleFonts.getFont(
                'Montserrat',
                fontWeight: FontWeight.w700,
                fontSize: 28,
                color: const Color(0xFF000000),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/rectangle_223.jpeg',
                ),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: -24,
                  right: 0,
                  top: -64,
                  bottom: -63,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0x80000000),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const SizedBox(
                      width: 380,
                      height: 200,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 64, 24, 63),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Seek Job Opportunities',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 25, 16),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search jobs here...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          )
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<JobPosting>>(
              future: futureJobPostings,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<JobPosting> data = snapshot.data!;
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(data[index].jobTitle,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text('Salary: ${data[index].salary}'),
                                  const SizedBox(height: 10),
                                  Text('Industry: ${data[index].fieldIndustry}'),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => JobDetailScreen(
                                              jobPosting: data[index]),
                                        ),
                                      );
                                    },
                                    child: const Text('View More'),
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: data.length,
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        )
      ]),
    );
  }
}
