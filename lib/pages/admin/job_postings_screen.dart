import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/models/job_posting.dart';
import 'package:flutter_app/services/api_service.dart';
import 'job_posting_update_screen.dart';

class JobPostingsScreen extends StatefulWidget {
  const JobPostingsScreen({super.key});

  @override
  _JobPostingsScreenState createState() => _JobPostingsScreenState();
}

class _JobPostingsScreenState extends State<JobPostingsScreen> {
  late Future<List<JobPosting>> futureJobPostings;

  @override
  void initState() {
    super.initState();
    futureJobPostings = Provider.of<ApiService>(context, listen: false).fetchJobPostings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Postings', style: TextStyle(fontFamily: 'Montserrat')),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.pushNamed(context, '/details');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<JobPosting>>(
        future: futureJobPostings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<JobPosting> jobPostings = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
              ),
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
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            Provider.of<ApiService>(context, listen: false).deleteJobPosting(job.jobId);
                            setState(() {
                              futureJobPostings = Provider.of<ApiService>(context, listen: false).fetchJobPostings();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create job posting screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
