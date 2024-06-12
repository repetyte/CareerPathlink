import 'package:flutter/material.dart';
import 'package:flutter_app/models/job_posting.dart';

class JobDetailScreen extends StatelessWidget {
  final JobPosting jobPosting;

  const JobDetailScreen({super.key, required this.jobPosting});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jobPosting.jobTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Job Title: ', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(jobPosting.jobTitle, style: const TextStyle(fontSize:16)),
              const SizedBox(height: 24),
              const Text('Field/Industry: ', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(jobPosting.fieldIndustry, style: const TextStyle(fontSize:16,)),
              const SizedBox(height: 24),
              const Text('Status: ', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(jobPosting.jobStatus, style: const TextStyle(fontSize:16,)),
              const SizedBox(height: 24),
              const Text('Job Level: ', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(jobPosting.jobLevel, style: const TextStyle(fontSize:16,)),
              const SizedBox(height: 24),
              const Text('Min. Years of Experience Needed: ', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(jobPosting.yrsOfExperienceNeeded, style: const TextStyle(fontSize:16,)),
              const SizedBox(height: 24),
              const Text('Contractual Status: ', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(jobPosting.contractualStatus, style: const TextStyle(fontSize:16,)),
              const SizedBox(height: 24),
              const Text('Salary Range: ', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(jobPosting.salary, style: const TextStyle(fontSize:16,)),
              const SizedBox(height: 24),
              const Text('Location: ', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(jobPosting.jobLocation, style: const TextStyle(fontSize:16,)),
              const SizedBox(height: 24),
              const Text('Job Description: ', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(jobPosting.jobDescription, style: const TextStyle(fontSize:16,)),
              const SizedBox(height: 24),
              const Text('Requirements: ', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(jobPosting.requirements, style: const TextStyle(fontSize:16,)),
              const SizedBox(height: 24),
              const Text('Job Responsibilities: ', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(jobPosting.jobResponsibilities, style: const TextStyle(fontSize:16,)),
              const SizedBox(height: 24),
              const Text('About Employer: ', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(jobPosting.industryPartner, style: const TextStyle(fontSize:16,)),
              const SizedBox(height: 24),
              // Add more fields as needed
            ],
          ),
        ),
      ),
    );
  }
}
