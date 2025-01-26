import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/graduate.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_posting.dart';
import 'package:flutter_app/pages/graduates_account/recruitment_and_placement/rr_job_application.dart';
import 'package:flutter_app/services/job_posting_api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class RrJobDetailsGraduates extends StatefulWidget {
  final JobPostingWithPartner jobPostingWithPartner;
  final GraduateAccount graduateAccount;

  const RrJobDetailsGraduates({super.key, required this.jobPostingWithPartner, required this.graduateAccount});

  @override
  _RrJobDetailsGraduatesState createState() => _RrJobDetailsGraduatesState();
}

class _RrJobDetailsGraduatesState extends State<RrJobDetailsGraduates> {
  // String? industryPartnerName;
  // late final JobPostingWithPartner jobPostingWithPartner;
  final JobPostingApiService jobPostingApiService = JobPostingApiService();

  @override
  void initState() {
    debugPrint('Graduatesssss ID: ${widget.graduateAccount.graduateId}');
    debugPrint('Department: ${widget.graduateAccount.department}');
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
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            widget.jobPostingWithPartner.coverPhoto,
                          ),
                        ),
                        borderRadius: const BorderRadius.only(
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
                            padding: const EdgeInsets.fromLTRB(16, 64, 16, 64),
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
                                            widget.jobPostingWithPartner.jobTitle,
                                            style: GoogleFonts.getFont(
                                              'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 32,
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
                                              widget.jobPostingWithPartner.status,
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
                                    widget.jobPostingWithPartner.fieldIndustry,
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
                        Text(widget.jobPostingWithPartner.jobLevel,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Min. Years of Experience Needed: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPostingWithPartner.yrsOfExperienceNeeded,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Contractual Status: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPostingWithPartner.contractualStatus,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Salary Range: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPostingWithPartner.salary,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Location: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPostingWithPartner.jobLocation,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Job Description: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPostingWithPartner.jobDescription,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Requirements: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPostingWithPartner.requirements,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('Job Responsibilities: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPostingWithPartner.jobResponsibilities,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 24),
                        const Text('About Employer: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(widget.jobPostingWithPartner.partnerName.toString(),
                            style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold
                            )),
                            const SizedBox(height: 4),
                        Text(widget.jobPostingWithPartner.partnerLocation.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobApplicationScreen(
                                  jobPostingWithPartner: widget
                                      .jobPostingWithPartner, graduateAccount: widget.graduateAccount,), // Fixed the error here
                            ),
                          );
                        },
                        icon: const Icon(Icons.send),
                        label: const Text('Submit Application'),
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
