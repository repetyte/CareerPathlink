import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/models/job_posting.dart';
import 'package:flutter_app/services/api_service.dart';

class JobPostingUpdateScreen extends StatefulWidget {
  final JobPosting jobPosting;

  const JobPostingUpdateScreen({super.key, required this.jobPosting});

  @override
  _JobPostingUpdateScreenState createState() => _JobPostingUpdateScreenState();
}

class _JobPostingUpdateScreenState extends State<JobPostingUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late String jobTitle;
  late String jobStatus;
  late String fieldIndustry;
  late String jobLevel;
  late String yrsOfExperienceNeeded;
  late String contractualStatus;
  late String salary;
  late String jobLocation;
  late String jobDescription;
  late String requirements;
  late String jobResponsibilities;
  late String industryPartner;

  @override
  void initState() {
    super.initState();
    jobTitle = widget.jobPosting.jobTitle ?? '';
    jobStatus = widget.jobPosting.jobStatus ?? '';
    fieldIndustry = widget.jobPosting.fieldIndustry ?? '';
    jobLevel = widget.jobPosting.jobLevel ?? '';
    yrsOfExperienceNeeded = widget.jobPosting.yrsOfExperienceNeeded ?? '';
    contractualStatus = widget.jobPosting.contractualStatus ?? '';
    salary = widget.jobPosting.salary ?? '';
    jobLocation = widget.jobPosting.jobLocation ?? '';
    jobDescription = widget.jobPosting.jobDescription ?? '';
    requirements = widget.jobPosting.requirements ?? '';
    jobResponsibilities = widget.jobPosting.jobResponsibilities ?? '';
    industryPartner = widget.jobPosting.industryPartner ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Job Posting', style: TextStyle(fontFamily: 'Montserrat')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: jobTitle,
                decoration: const InputDecoration(labelText: 'Job Title'),
                onSaved: (value) {
                  jobTitle = value!;
                },
              ),
              TextFormField(
                initialValue: jobStatus,
                decoration: const InputDecoration(labelText: 'Job Status'),
                onSaved: (value) {
                  jobStatus = value!;
                },
              ),
              TextFormField(
                initialValue: fieldIndustry,
                decoration: const InputDecoration(labelText: 'Field Industry'),
                onSaved: (value) {
                  fieldIndustry = value!;
                },
              ),
              TextFormField(
                initialValue: jobLevel,
                decoration: const InputDecoration(labelText: 'Job Level'),
                onSaved: (value) {
                  jobLevel = value!;
                },
              ),
              TextFormField(
                initialValue: yrsOfExperienceNeeded,
                decoration: const InputDecoration(labelText: 'Years of Experience Needed'),
                onSaved: (value) {
                  yrsOfExperienceNeeded = value!;
                },
              ),
              TextFormField(
                initialValue: contractualStatus,
                decoration: const InputDecoration(labelText: 'Contractual Status'),
                onSaved: (value) {
                  contractualStatus = value!;
                },
              ),
              TextFormField(
                initialValue: salary,
                decoration: const InputDecoration(labelText: 'Salary'),
                onSaved: (value) {
                  salary = value!;
                },
              ),
              TextFormField(
                initialValue: jobLocation,
                decoration: const InputDecoration(labelText: 'Job Location'),
                onSaved: (value) {
                  jobLocation = value!;
                },
              ),
              TextFormField(
                initialValue: jobDescription,
                decoration: const InputDecoration(labelText: 'Job Description'),
                onSaved: (value) {
                  jobDescription = value!;
                },
              ),
              TextFormField(
                initialValue: requirements,
                decoration: const InputDecoration(labelText: 'Requirements'),
                onSaved: (value) {
                  requirements = value!;
                },
              ),
              TextFormField(
                initialValue: jobResponsibilities,
                decoration: const InputDecoration(labelText: 'Job Responsibilities'),
                onSaved: (value) {
                  jobResponsibilities = value!;
                },
              ),
              TextFormField(
                initialValue: industryPartner,
                decoration: const InputDecoration(labelText: 'Industry Partner'),
                onSaved: (value) {
                  industryPartner = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    JobPosting updatedJob = JobPosting(
                      jobId: widget.jobPosting.jobId,
                      jobTitle: jobTitle,
                      jobStatus: jobStatus,
                      fieldIndustry: fieldIndustry,
                      jobLevel: jobLevel,
                      yrsOfExperienceNeeded: yrsOfExperienceNeeded,
                      contractualStatus: contractualStatus,
                      salary: salary,
                      jobLocation: jobLocation,
                      jobDescription: jobDescription,
                      requirements: requirements,
                      jobResponsibilities: jobResponsibilities,
                      industryPartner: industryPartner,
                    );
                    Provider.of<ApiService>(context, listen: false)
                        .updateJobPosting(updatedJob)
                        .then((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: const Text('Update Job Posting'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
