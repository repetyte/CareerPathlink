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
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/${widget.jobPostingWithPartner.coverPhoto}'),
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0x80000000),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: const SizedBox(height: 188),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 64, 16, 64),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.jobPostingWithPartner.jobTitle,
                                    style: GoogleFonts.getFont('Montserrat', fontWeight: FontWeight.w700, fontSize: 32, color: Colors.white),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: Text(
                                    widget.jobPostingWithPartner.status,
                                    style: GoogleFonts.getFont('Montserrat', fontWeight: FontWeight.w700, fontSize: 14, color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              widget.jobPostingWithPartner.fieldIndustry,
                              style: GoogleFonts.getFont('Montserrat', fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      bool isDesktop = constraints.maxWidth >= 800;
                      if (isDesktop) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetail('Job Description', widget.jobPostingWithPartner.jobDescription),
                                  _buildDetail('Job Level', widget.jobPostingWithPartner.jobLevel),
                                  _buildDetail('Min. Years of Experience Needed', widget.jobPostingWithPartner.yrsOfExperienceNeeded),
                                  _buildDetail('Employment Status', widget.jobPostingWithPartner.contractualStatus),
                                  _buildDetail('Salary Range', widget.jobPostingWithPartner.salary),
                                  _buildDetail('Location', widget.jobPostingWithPartner.jobLocation),
                                ],
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetail('Requirements', widget.jobPostingWithPartner.requirements),
                                  _buildDetail('Job Responsibilities', widget.jobPostingWithPartner.jobResponsibilities),
                                  const Text('About Employer:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text(widget.jobPostingWithPartner.partnerName.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text(widget.jobPostingWithPartner.partnerLocation.toString(), style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetail('Job Description', widget.jobPostingWithPartner.jobDescription),
                            _buildDetail('Job Level', widget.jobPostingWithPartner.jobLevel),
                            _buildDetail('Min. Years of Experience Needed', widget.jobPostingWithPartner.yrsOfExperienceNeeded),
                            _buildDetail('Employment Status', widget.jobPostingWithPartner.contractualStatus),
                            _buildDetail('Salary Range', widget.jobPostingWithPartner.salary),
                            _buildDetail('Location', widget.jobPostingWithPartner.jobLocation),
                            _buildDetail('Requirements', widget.jobPostingWithPartner.requirements),
                            _buildDetail('Job Responsibilities', widget.jobPostingWithPartner.jobResponsibilities),
                            const Text('About Employer:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(widget.jobPostingWithPartner.partnerName.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(widget.jobPostingWithPartner.partnerLocation.toString(), style: const TextStyle(fontSize: 16)),
                          ],
                        );
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  alignment: Alignment.topRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobApplicationScreen(
                            jobPostingWithPartner: widget.jobPostingWithPartner,
                            graduateAccount: widget.graduateAccount,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.send),
                    label: const Text('Submit Application'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetail(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(content, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}