import 'package:flutter/material.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_application.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_posting.dart';
import 'package:flutter_app/services/job_application_api_service.dart';

class RrJobApplications extends StatefulWidget {
  final int jobId;
  final JobPostingWithPartner jobPostingWithPartner;

  const RrJobApplications({
    super.key,
    required this.jobId,
    required this.jobPostingWithPartner,
  });

  @override
  _RrJobApplicationsState createState() => _RrJobApplicationsState();
}

class _RrJobApplicationsState extends State<RrJobApplications> {
  final JobApplicationApiService jobApplicationApiService =
      JobApplicationApiService();
  late Future<List<JobApplicationComplete>> futureApplications;
  String filterStatus = 'Pending';

  @override
  void initState() {
    super.initState();
    futureApplications = jobApplicationApiService.fetchJobApplications();
  }

  Widget _buildJobPostingCard() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            'assets/images/${widget.jobPostingWithPartner.coverPhoto}',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Job Applications for",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(widget.jobPostingWithPartner.jobTitle,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(widget.jobPostingWithPartner.partnerName,
                    style: const TextStyle(
                      fontSize: 16,
                    )),
                const SizedBox(height: 4),
                Text(widget.jobPostingWithPartner.salary,
                    style: const TextStyle(
                      fontSize: 14,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        filterStatus == 'Pending'
            ? ElevatedButton(
                onPressed: () {
                  setState(() {
                    filterStatus = 'Pending';
                  });
                },
                child: const Text('Pending'),
              )
            : TextButton(
                onPressed: () {
                  setState(() {
                    filterStatus = 'Pending';
                  });
                },
                child: const Text('Pending'),
              ),
        filterStatus == 'Validated'
            ? ElevatedButton(
                onPressed: () {
                  setState(() {
                    filterStatus = 'Validated';
                  });
                },
                child: const Text('Validated'),
              )
            : TextButton(
                onPressed: () {
                  setState(() {
                    filterStatus = 'Validated';
                  });
                },
                child: const Text('Validated'),
              ),
      ],
    );
  }

  Widget _buildApplicationsList() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(40),
      ),
      constraints: const BoxConstraints(
        minHeight: 300,
      ),
      child: FutureBuilder<List<JobApplicationComplete>>(
        future: futureApplications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.isEmpty ||
              snapshot.data!.every((app) => app.job != widget.jobId)) {
            return Center(
              child: Text(
                filterStatus == 'Pending'
                    ? 'No pending job applications found.'
                    : 'No validated job applications found.',
              ),
            );
          }

          final filteredApplications = snapshot.data!
              .where((app) =>
                  app.job == widget.jobId &&
                  app.applicationStatus == filterStatus)
              .toList();

          if (filteredApplications.isEmpty) {
            return Center(
              child: Text(
                filterStatus == 'Pending'
                    ? 'No pending job applications found.'
                    : 'No validated job applications found.',
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredApplications.length,
            itemBuilder: (context, index) {
              final application = filteredApplications[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListTile(
                  title: Text(
                      '${application.applicantFirstName} ${application.applicantLastName}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Row(
                    children: [
                      Icon(Icons.phone),
                      const SizedBox(width: 8.0),
                      Text(application.applicantContactNo),
                      Text('  | '),
                      Icon(Icons.email),
                      const SizedBox(width: 8.0),
                      Text(application.applicantEmail),
                    ],
                  ),
                  trailing: Text('Date Applied: ${application.dateApplied}'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              '${application.applicantFirstName} ${application.applicantLastName}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.school),
                                    const SizedBox(width: 4.0),
                                    Text(application.degree),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.email),
                                    const SizedBox(width: 4.0),
                                    Text(application.applicantEmail),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_pin),
                                    const SizedBox(width: 4.0),
                                    Text(application.applicantLocation),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.phone),
                                    const SizedBox(width: 4.0),
                                    Text(application.applicantContactNo),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Text('Resume: ${application.resume}'),
                                Text(
                                    'Cover Letter: ${application.coverLetter}'),
                                application.skills == '' ||
                                        application.skills.isEmpty
                                    ? Text('Skills: ')
                                    : Text('Skills: \n${application.skills}'),
                                application.certifications == '' ||
                                        application.certifications.isEmpty
                                    ? Text('Certifications: ')
                                    : Text(
                                        'Certifications: \n${application.certifications}'),
                                Text(
                                    'Status: ${application.applicationStatus}'),
                                Text(
                                    'Date Applied: ${application.dateApplied}'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                            if (application.applicationStatus != 'Validated')
                              ElevatedButton(
                                onPressed: () async {
                                  try {
                                    final updatedApplication =
                                        JobApplicationComplete(
                                      // JobApplication fields
                                      applicationId: application.applicationId,
                                      job: application.job,
                                      applicantFirstName:
                                          application.applicantFirstName,
                                      applicantLastName:
                                          application.applicantLastName,
                                      degree: application.degree,
                                      applicantLocation:
                                          application.applicantLocation,
                                      applicantContactNo:
                                          application.applicantContactNo,
                                      applicantEmail:
                                          application.applicantEmail,
                                      resume: application.resume,
                                      coverLetter: application.coverLetter,
                                      skills: application.skills,
                                      certifications:
                                          application.certifications,
                                      applicationStatus: 'Validated',
                                      dateApplied: application.dateApplied,

                                      // Job posting fields
                                      jobId: application.jobId,
                                      coverPhoto: application.coverPhoto,
                                      jobTitle: application.jobTitle,
                                      status: application.status,
                                      fieldIndustry: application.fieldIndustry,
                                      jobLevel: application.jobLevel,
                                      yrsOfExperienceNeeded:
                                          application.yrsOfExperienceNeeded,
                                      contractualStatus:
                                          application.contractualStatus,
                                      salary: application.salary,
                                      jobLocation: application.jobLocation,
                                      jobDescription:
                                          application.jobDescription,
                                      requirements: application.requirements,
                                      jobResponsibilities:
                                          application.jobResponsibilities,
                                      industryPartner:
                                          application.industryPartner,
                                    );

                                    await jobApplicationApiService
                                        .updateJobApplication(
                                            updatedApplication);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Application validated successfully')));

                                    // Close dialog and refresh data
                                    Navigator.of(context).pop();
                                    await Future.delayed(const Duration(milliseconds: 300));
                                    setState(() {
                                      futureApplications =
                                          jobApplicationApiService
                                              .fetchJobApplications();
                                    });
                                  } catch (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Failed to update job application: $error')));
                                  }
                                },
                                child: const Text('Validate'),
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Applications'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side - Job Posting Card
                    Expanded(
                      flex: 1,
                      child: _buildJobPostingCard(),
                    ),
                    const SizedBox(width: 32),
                    // Right side - Filter and Applications List
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _buildFilterButtons(),
                          const SizedBox(height: 16.0),
                          _buildApplicationsList(),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildJobPostingCard(),
                    const SizedBox(height: 32),
                    _buildFilterButtons(),
                    const SizedBox(height: 16.0),
                    _buildApplicationsList(),
                  ],
                ),
        ),
      ),
    );
  }
}
