import 'package:flutter/material.dart';
import 'package:flutter_app/models/job_posting.dart';
import 'package:flutter_app/pages/graduates_account/recruitment_and_placement/rr_document_submission.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class RrJobDetailsGraduates extends StatefulWidget {
  final JobPostingWithPartner jobPosting;

  const RrJobDetailsGraduates({super.key, required this.jobPosting});

  @override
  _RrJobDetailsGraduatesState createState() => _RrJobDetailsGraduatesState();
}

class _RrJobDetailsGraduatesState extends State<RrJobDetailsGraduates> {
  // String? industryPartnerName;
  // late final JobPostingWithPartner jobPosting;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/rectangle_351.jpeg',
                          ),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0x80000000),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                              child: const SizedBox(
                                width: 380,
                                height: 188,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(16, 49, 16, 59),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            widget.jobPosting.jobTitle,
                                            style: GoogleFonts.getFont(
                                              'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 28,
                                              color: const Color(0xFFFFFFFF),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20, 10),
                                            child: Text(
                                              widget.jobPosting.status,
                                              style: GoogleFonts.getFont(
                                                'Montserrat',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: const Color(0xFF008000),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.jobPosting.fieldIndustry,
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: const Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Job Level: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPosting.jobLevel,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Min. Years of Experience Needed: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPosting.yrsOfExperienceNeeded,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Contractual Status: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPosting.contractualStatus,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Salary Range: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPosting.salary,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Location: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPosting.jobLocation,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Job Description: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPosting.jobDescription,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Requirements: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPosting.requirements,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Job Responsibilities: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPosting.jobResponsibilities,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('About Employer: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPosting.partnerName.toString(),
                            style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold
                            )),
                            const SizedBox(height: 4),
                        Text(widget.jobPosting.partnerLocation.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(24.1, 0, 24.1, 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DocumentSubmissionScreen(
                                  jobPostingWithPartner: widget
                                      .jobPosting), // Fixed the error here
                            ),
                          );
                        },
                        child: const Text('Submit Application'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
