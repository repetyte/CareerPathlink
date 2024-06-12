import 'package:flutter/material.dart';
import 'package:flutter_app/services/api_service.dart';

import '../../models/job_posting.dart';

class AddJobPostingScreen extends StatefulWidget {
  final Function onJobPosted;

  const AddJobPostingScreen({required this.onJobPosted, super.key});

  @override
  _AddJobPostingScreenState createState() => _AddJobPostingScreenState();
}

class _AddJobPostingScreenState extends State<AddJobPostingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _statusController = TextEditingController();
  final _industryController = TextEditingController();
  final _levelController = TextEditingController();
  final _experienceController = TextEditingController();
  final _contractualStatusController = TextEditingController();
  final _salaryController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _requirementsController = TextEditingController();
  final _responsibilitiesController = TextEditingController();
  final _partnerController = TextEditingController();

  Future<void> _postJob() async {
    if (_formKey.currentState!.validate()) {
      final jobPosting = JobPosting(
        jobTitle: _titleController.text,
        jobStatus: _statusController.text,
        fieldIndustry: _industryController.text,
        jobLevel: _levelController.text,
        yrsOfExperienceNeeded: _experienceController.text,
        contractualStatus: _contractualStatusController.text,
        salary: _salaryController.text,
        jobLocation: _locationController.text,
        jobDescription: _descriptionController.text,
        requirements: _requirementsController.text,
        jobResponsibilities: _responsibilitiesController.text,
        industryPartner: _partnerController.text,
      );

      await ApiService().createJobPosting(jobPosting);

      widget.onJobPosted();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Add Job Posting', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Job Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a job title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _statusController,
                      decoration: const InputDecoration(labelText: 'Job Status'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a job status';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _industryController,
                      decoration: const InputDecoration(labelText: 'Field Industry'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the field industry';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _levelController,
                      decoration: const InputDecoration(labelText: 'Job Level'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the job level';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _experienceController,
                      decoration: const InputDecoration(labelText: 'Years of Experience Needed'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the years of experience needed';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _contractualStatusController,
                      decoration: const InputDecoration(labelText: 'Contractual Status'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the contractual status';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _salaryController,
                      decoration: const InputDecoration(labelText: 'Salary'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a salary';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(labelText: 'Job Location'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the job location';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(labelText: 'Job Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a job description';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _requirementsController,
                      decoration: const InputDecoration(labelText: 'Requirements'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the requirements';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _responsibilitiesController,
                      decoration: const InputDecoration(labelText: 'Job Responsibilities'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the job responsibilities';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _partnerController,
                      decoration: const InputDecoration(labelText: 'Industry Partner'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the industry partner';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _postJob,
                      child: const Text('Post Job Posting'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
