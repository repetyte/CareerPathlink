import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pages/employer_partners_account/recruitment_and_placement/rr_update_job_posting.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_app/models/user_role/industry_partner.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_posting.dart';
import 'package:flutter_app/services/job_posting_api_service.dart';

class RrJobDetailsCCD extends StatefulWidget {
  JobPostingWithPartner jobPostingWithPartner;
  final IndustryPartnerAccount employerPartnerAccount;

  RrJobDetailsCCD(
      {super.key,
      required this.jobPostingWithPartner,
      required this.employerPartnerAccount});

  @override
  _RrJobDetailsCCDState createState() => _RrJobDetailsCCDState();
}

class _RrJobDetailsCCDState extends State<RrJobDetailsCCD> {
  final JobPostingApiService jobPostingApiService = JobPostingApiService();
  late Future<List<JobPostingWithPartner>> futureJobPostings;

  late Future<List<IndustryPartner>> futureIndustryPartners;

  String jobTitle = '';
  Uint8List? coverPhotoBytes;
  String coverPhotoSource = ''; // Keeps track of the image source (path or URL)
  String status = 'Open';
  String fieldIndustry = 'Engineering';
  String jobLevel = 'Entry Level';
  String yrsOfExperienceNeeded = 'Fresh Graduate';
  String contractualStatus = 'Full-time';
  String salary = 'Below PHP 10,000';
  String jobLocation = '';
  String jobDescription = '';
  String requirements = '';
  String jobResponsibilities = '';

  @override
  void initState() {
    debugPrint(
        'Employer Partner ID: ${widget.employerPartnerAccount.partnerName}');
    debugPrint(
        'Employer Partner Location: ${widget.employerPartnerAccount.partnerLocation}\n');
    super.initState();
    futureJobPostings = jobPostingApiService.fetchJobPostings();
  }

  void _refreshJobPostings() {
    setState(() {
      futureJobPostings = jobPostingApiService.fetchJobPostings();
    });
  }

  void _updateJobPosting(JobPostingWithPartner jobPostingWithPartner) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RrUpdateJobPosting(
          jobPostingWithPartner: widget.jobPostingWithPartner,
          onStudentUpdated: _refreshJobPostings,
          employerPartnerAccount: widget.employerPartnerAccount,
        ),
      ),
    ).then((updatedJobPosting) {
      if (updatedJobPosting != null) {
        setState(() {
          widget.jobPostingWithPartner = updatedJobPosting;
          futureJobPostings =
              jobPostingApiService.fetchJobPostings(); // Refresh job postings
        });
      }
    });
  }

  void _deleteJobPosting(int? jobId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Job Posting',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text(
              'Are you sure you want to delete this job posting? All applications from this job posting will be deleted.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (jobId != null) {
                  jobPostingApiService.deleteJobPosting(jobId).then((_) {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context)
                        .pop(true); // Navigate back and refresh
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Job Posting deleted successfully.')),
                    );
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete job: $error')),
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid Job ID')),
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
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
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
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
                            'assets/images/${widget.jobPostingWithPartner.coverPhoto}',
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
                                            widget
                                                .jobPostingWithPartner.jobTitle,
                                            style: GoogleFonts.getFont(
                                              'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 32,
                                              color: const Color(0xFFFFFFFF),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Call the API to apply for the internship
                                          },
                                          child: const Text(
                                              'Internship Applications'),
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
                        Text(
                            widget.jobPostingWithPartner.partnerName.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          widget.jobPostingWithPartner.partnerLocation
                              .toString(),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () => _deleteJobPosting(
                                widget.jobPostingWithPartner.jobId),
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete Job'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () =>
                                _updateJobPosting(widget.jobPostingWithPartner),
                            icon: const Icon(Icons.update),
                            label: const Text('Update Job'),
                          ),
                        ],
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
