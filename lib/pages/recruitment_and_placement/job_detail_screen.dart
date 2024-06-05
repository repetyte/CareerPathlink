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
              Text('Job Title: ', style: const TextStyle(fontSize: 20,)),
              const SizedBox(height: 4),
              Text('${jobPosting.jobTitle}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('Field/Industry: ', style: const TextStyle(fontSize: 20,)),
              const SizedBox(height: 4),
              Text('${jobPosting.fieldIndustry}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('Status: ', style: const TextStyle(fontSize: 20,)),
              const SizedBox(height: 4),
              Text('${jobPosting.jobStatus}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('Job Title: ', style: const TextStyle(fontSize: 20,)),
              const SizedBox(height: 4),
              Text('${jobPosting.jobTitle}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('Min. Years of Experience Needed: ', style: const TextStyle(fontSize: 20,)),
              const SizedBox(height: 4),
              Text('${jobPosting.yrsOfExperienceNeeded}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('Contractual Status: ', style: const TextStyle(fontSize: 20,)),
              const SizedBox(height: 4),
              Text('${jobPosting.contractualStatus}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('Salary Range: ', style: const TextStyle(fontSize: 20,)),
              const SizedBox(height: 4),
              Text('${jobPosting.salary}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('Location: ', style: const TextStyle(fontSize: 20,)),
              const SizedBox(height: 4),
              Text('${jobPosting.jobLocation}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('Job Description: ', style: const TextStyle(fontSize: 20,)),
              const SizedBox(height: 4),
              Text('${jobPosting.jobDescription}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('Requirements: ', style: const TextStyle(fontSize: 20,)),
              const SizedBox(height: 4),
              Text('${jobPosting.requirements}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('Job Responsibilities: ', style: const TextStyle(fontSize: 20,)),
              const SizedBox(height: 4),
              Text('${jobPosting.jobResponsibilities}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('About Employer: ', style: const TextStyle(fontSize: 20,)),
              const SizedBox(height: 4),
              Text('${jobPosting.industryPartner}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              // Add more fields as needed
            ],
          ),
        ),
      ),
    );
  }
}
