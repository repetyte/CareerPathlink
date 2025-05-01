import 'package:flutter/material.dart';
import 'package:flutter_app/models/work_integrated_learning/internship.dart';
import 'package:flutter_app/models/work_integrated_learning/internship_application.dart';
import 'package:flutter_app/services/internship_application_api_service.dart';

class OpportunityApplications extends StatefulWidget {
  final int internshipId;
  final InternshipWithPartner internshipWithPartner; // Add this parameter

  const OpportunityApplications({
    super.key,
    required this.internshipId,
    required this.internshipWithPartner, // Initialize it here
  });

  @override
  _OpportunityApplicationsState createState() => _OpportunityApplicationsState();
}

class _OpportunityApplicationsState extends State<OpportunityApplications> {
  final InternshipApplicationApiService internshipApplicationApiService =
      InternshipApplicationApiService();
  late Future<List<InternshipApplicationComplete>> futureApplications;
  String filterStatus = 'Pending';

  @override
  void initState() {
    super.initState();
    futureApplications = internshipApplicationApiService.fetchInternshipApplications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WIL Opportunity Applications'),
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
                      'assets/images/${widget.internshipWithPartner.displayPhoto}',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Opportunity Applications for",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(widget.internshipWithPartner.internshipTitle,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(widget.internshipWithPartner.partnerName,
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                          const SizedBox(height: 4),
                          Text(widget.internshipWithPartner.takehomePay,
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
                child: FutureBuilder<List<InternshipApplicationComplete>>(
                  future: futureApplications,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.isEmpty ||
                        snapshot.data!
                            .every((app) => app.internship != widget.internshipId)) {
                      return Center(
                        child: Text(
                          filterStatus == 'Pending'
                              ? 'No pending opportunity applications found.'
                              : 'No validated opportunity applications found.',
                        ),
                      );
                    }

                    // Filter applications based on internshipId and filterStatus
                    final filteredApplications = snapshot.data!
                        .where((app) =>
                            app.internship == widget.internshipId &&
                            app.applicationStatus == filterStatus)
                        .toList();

                    if (filteredApplications.isEmpty) {
                      return Center(
                        child: Text(
                          filterStatus == 'Pending'
                              ? 'No pending opportunity applications found.'
                              : 'No validated opportunity applications found.',
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
                                        application.skills == '' || application.skills!.isEmpty
                                            ? Text('Skills: ')
                                            : Text('Skills: \n${application.skills}'),
                                        application.certifications == '' || application.certifications!.isEmpty
                                            ? Text('Certifications: ')
                                            : Text('Certifications: \n${application.certifications}'),
                                        Text('Status: ${application.applicationStatus}'),
                                        Text('Date Applied: ${application.dateApplied}'),
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
