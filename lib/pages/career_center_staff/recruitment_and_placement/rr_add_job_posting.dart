import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/industry_partner.dart';
import 'package:flutter_app/models/job_posting.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:image_picker/image_picker.dart';

class RrAddJobPosting extends StatefulWidget {
  const RrAddJobPosting({super.key});

  @override
  _RrAddJobPostingState createState() => _RrAddJobPostingState();
}

class _RrAddJobPostingState extends State<RrAddJobPosting> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();

  Uint8List? coverPhoto;
  Uint8List? profilePic;
  String jobTitle = '';
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
  String partnerName = '';
  String partnerLocation = '';
  String contactNo = '';
  String emailAdd = '';

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  void _submitJobPosting() async {
    if (_formKey.currentState!.validate()) {
      JobPosting jobPosting = JobPosting(
        jobTitle: jobTitle,
        status: status,
        fieldIndustry: fieldIndustry,
        jobLevel: jobLevel,
        yrsOfExperienceNeeded: yrsOfExperienceNeeded,
        contractualStatus: contractualStatus,
        salary: salary,
        jobLocation: jobLocation,
        jobDescription: jobDescription,
        requirements: requirements,
        jobResponsibilities: jobResponsibilities,
        coverPhoto:
            coverPhoto != null ? String.fromCharCodes(coverPhoto!) : null,
        industryPartner: IndustryPartner(
          profilePic:
              profilePic != null ? String.fromCharCodes(profilePic!) : null,
          partnerName: partnerName,
          partnerLocation: partnerLocation,
          contactNo: contactNo,
          emailAdd: emailAdd,
        ),
      );

      try {
        await apiService.createJobPosting(jobPosting);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Job added successfully')));
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to add job: $error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Job Posting'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Photo
              const Text(
                'Cover Photo:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              // Option 1
              // ElevatedButton(
              //   onPressed: () => _pickImage(true),
              //   child: const Text('Choose Cover Photo'),
              // ),
              // if (coverPhoto != null) Image.memory(coverPhoto!, height: 100),

              // Option 2
              // _image == null
              //     ? const Text('No cover photo selected.')
              //     : Image.file(_image!),
              // ElevatedButton(
              //   onPressed: _pickImage,
              //   child: const Text('Choose Cover Photo'),
              // ),

              // Option 3
              Center(
                child: _image == null
                    ? const Text('No image selected.')
                    : Image.file(_image!),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 16.0),

              // Job Title
              TextFormField(
                decoration: const InputDecoration(labelText: 'Job Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job title';
                  }
                  jobTitle = value;
                  return null;
                },
              ),

              // Status
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Status'),
                value: status,
                onChanged: (newValue) {
                  setState(() {
                    status = newValue!;
                  });
                },
                items: ['Open', 'Closed'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              // Field/Industry
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Field/Industry'),
                value: fieldIndustry,
                onChanged: (newValue) {
                  setState(() {
                    fieldIndustry = newValue!;
                  });
                },
                items: [
                  'Engineering',
                  'Business and Finance',
                  'Information Technology',
                  'Education',
                  'Healthcare',
                  'Law Enforcement',
                  'Architecture'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              // Job Level
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Job Level'),
                value: jobLevel,
                onChanged: (newValue) {
                  setState(() {
                    jobLevel = newValue!;
                  });
                },
                items: ['Entry Level', 'Mid-level', 'Senior Level']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              // Years of Experience Needed
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                    labelText: 'Years of Experience Needed'),
                value: yrsOfExperienceNeeded,
                onChanged: (newValue) {
                  setState(() {
                    yrsOfExperienceNeeded = newValue!;
                  });
                },
                items: [
                  'Fresh Graduate',
                  '<1 year',
                  '1-3 years',
                  '3-5 years',
                  '5+ years'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              // Contractual Status
              DropdownButtonFormField<String>(
                decoration:
                    const InputDecoration(labelText: 'Contractual Status'),
                value: contractualStatus,
                onChanged: (newValue) {
                  setState(() {
                    contractualStatus = newValue!;
                  });
                },
                items: ['Full-time', 'Part-time', 'Contractual']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              // Salary Range
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Salary Range'),
                value: salary,
                onChanged: (newValue) {
                  setState(() {
                    salary = newValue!;
                  });
                },
                items: [
                  'Below PHP 10,000',
                  'PHP 10,000 - PHP 50,000',
                  'PHP 50,000 - PHP 100,000',
                  'Above PHP 100,000'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              // Job Location
              TextFormField(
                decoration: const InputDecoration(labelText: 'Job Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job location';
                  }
                  jobLocation = value;
                  return null;
                },
              ),

              // Job Description
              TextFormField(
                decoration: const InputDecoration(labelText: 'Job Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job description';
                  }
                  jobDescription = value;
                  return null;
                },
              ),

              // Requirements
              TextFormField(
                decoration: const InputDecoration(labelText: 'Requirements'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the requirements';
                  }
                  requirements = value;
                  return null;
                },
              ),

              // Job Responsibilities
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Job Responsibilities'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job responsibilities';
                  }
                  jobResponsibilities = value;
                  return null;
                },
              ),

              // About Employer
              const Text('About Employer:',
                  style: TextStyle(fontWeight: FontWeight.bold)),

              // Profile Picture
              const Text('Profile Picture:'),

              // Option 1
              // ElevatedButton(
              //   onPressed: () => _pickImage(false),
              //   child: const Text('Choose Profile Picture'),
              // ),
              // if (profilePic != null) Image.memory(profilePic!, height: 100),

              // Option 2
              // _image == null
              //     ? const Text('No pfofile picture selected.')
              //     : Image.file(_image!),
              // ElevatedButton(
              //   onPressed: _pickImage,
              //   child: const Text('Choose Profile Picture'),
              // ),

              // Option 3
              Center(
                child: _image == null
                    ? const Text('No image selected.')
                    : Image.file(_image!),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Choose Profile Pic'),
              ),
              const SizedBox(height: 16.0),

              // Partner Name
              TextFormField(
                decoration: const InputDecoration(labelText: 'Partner Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the partner name';
                  }
                  partnerName = value;
                  return null;
                },
              ),

              // Partner Location
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Partner Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the partner location';
                  }
                  partnerLocation = value;
                  return null;
                },
              ),

              // Contact Number
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contact Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the contact number';
                  }
                  contactNo = value;
                  return null;
                },
              ),

              // Email Address
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the email address';
                  }
                  emailAdd = value;
                  return null;
                },
              ),

              // Submit Button
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitJobPosting,
                  child: const Text('Post Job'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
