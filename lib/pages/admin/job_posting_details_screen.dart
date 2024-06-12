import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/models/job_posting.dart';
import 'package:flutter_app/services/api_service.dart';
import 'job_posting_update_screen.dart';

class JobPostingDetailsScreen extends StatefulWidget {
  const JobPostingDetailsScreen({super.key});

  @override
  _JobPostingDetailsScreenState createState() => _JobPostingDetailsScreenState();
}

class _JobPostingDetailsScreenState extends State<JobPostingDetailsScreen> {
  late Future<List<JobPosting>> futureJobPostings;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureJobPostings = apiService.fetchJobPostings();
  }

  void _refreshJobPostings() {
    setState(() {
      futureJobPostings = apiService.fetchJobPostings();
    });
  }

  void _deleteSJobPosting(int? id) {
    apiService.deleteJobPosting(id).then((_) {
      _refreshJobPostings();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student deleted successfully')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete student: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Job Postings', style: TextStyle(fontFamily: 'Montserrat')),
      ),
      body: FutureBuilder<List<JobPosting>>(
        future: futureJobPostings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<JobPosting> jobPostings = snapshot.data!;
            return ListView.builder(
              itemCount: jobPostings.length,
              itemBuilder: (context, index) {
                JobPosting job = jobPostings[index];
                return Card(
                  child: ListTile(
                    title: Text(job.jobTitle),
                    subtitle: Text('${job.salary} | ${job.fieldIndustry}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobPostingUpdateScreen(jobPosting: job),
                              ),
                            ).then((_) => _refreshJobPostings());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            Provider.of<ApiService>(context, listen: false).deleteJobPosting(job.jobId).then((_) {
                              _refreshJobPostings();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
