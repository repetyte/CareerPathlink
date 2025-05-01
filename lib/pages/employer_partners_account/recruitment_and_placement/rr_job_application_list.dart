import 'package:flutter/material.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_application.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_posting.dart';
import 'package:flutter_app/services/job_application_api_service.dart';

class RrJobApplications extends StatefulWidget {
  final int jobId;
  final JobPostingWithPartner jobPostingWithPartner; // Add this parameter

  const RrJobApplications({
    super.key,
    required this.jobId,
    required this.jobPostingWithPartner, // Initialize it here
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Applications'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
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
              ),
              const SizedBox(height: 16),
              Row(
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
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(40),
                ),
                constraints: const BoxConstraints(
                  minHeight: 300, // Set the minimum height to 300
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
                        snapshot.data!
                            .every((app) => app.job != widget.jobId)) {
                      return Center(
                        child: Text(
                          filterStatus == 'Pending'
                              ? 'No pending job applications found.'
                              : 'No validated job applications found.',
                        ),
                      );
                    }

                    // Filter applications based on jobId and filterStatus
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
                        return ListTile(
                          title: Text(
                              '${application.applicantFirstName} ${application.applicantLastName}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.phone,
                              ),
                              const SizedBox(width: 8.0),
                              Text(application.applicantContactNo),
                              Text(' | '),
                              Icon(
                                Icons.email,
                              ),
                              const SizedBox(width: 8.0),
                              Text(application.applicantEmail),
                            ],
                          ),
                          trailing:
                              Text('Date Applied: ${application.dateApplied}'),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      '${application.applicantFirstName} ${application.applicantLastName}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                            Text(
                                                application.applicantContactNo),
                                          ],
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text('Resume: ${application.resume}'),
                                        Text('Cover Letter: ${application.coverLetter}'),
                                        application.skills == '' || application.skills.isEmpty
                                            ? Text('Skills: ')
                                            : Text('Skills: \n${application.skills}'),
                                        application.certifications == '' || application.certifications.isEmpty
                                            ? Text('Certifications: ')
                                            : Text('Certifications: \n${application.certifications}'),
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
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
