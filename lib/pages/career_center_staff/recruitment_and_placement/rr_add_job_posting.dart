import 'dart:io';
import 'package:flutter/foundation.dart'; // Import foundation to check platform
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
  Uint8List? _webImage; // To store the image bytes for web
  final picker = ImagePicker();
  IndustryPartner? _selectedPartner;
  late Future<List<IndustryPartner>> futureIndustryPartners;

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
  int industryPartner = 0;

  Future<void> _pickImage() async {
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    if (kIsWeb) {
      // For web, store the image bytes without marking setState as async
      final webImageBytes = await pickedFile.readAsBytes();
      setState(() {
        _webImage = webImageBytes;
      });
    } else {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  } else {
    if (kDebugMode) {
      print('No image selected.');
    }
  }
}

  void _submitJobPosting() async {
  if (_formKey.currentState!.validate()) {
    // If the platform is web, use _webImage for cover photo; otherwise, use _image
    final Uint8List? coverPhotoBytes = kIsWeb
        ? _webImage
        : _image != null
            ? await _image!.readAsBytes()
            : null;

    // Ensure _selectedPartner is selected before proceeding
    if (_selectedPartner == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an industry partner.')));
      return;
    }

    // Construct the job posting data
    // final jobPostingData = {
    //   'cover_photo': coverPhotoBytes,
    //   'job_title': jobTitle,
    //   'status': status,
    //   'field_industry': fieldIndustry,
    //   'job_level': jobLevel,
    //   'yrs_of_experience_needed': yrsOfExperienceNeeded,
    //   'contractual_status': contractualStatus,
    //   'salary': salary,
    //   'job_location': jobLocation,
    //   'job_description': jobDescription,
    //   'requirements': requirements,
    //   'job_responsibilities': jobResponsibilities,
    //   'industry_partner': _selectedPartner!.partnerId,
    // };

    final jobPostingData = JobPosting(
      coverPhoto: coverPhotoBytes,
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
      industryPartner: _selectedPartner!.partnerId,
    );

    // Print the job posting data for debugging
    if (kDebugMode) {
      print('Job Posting Data:');
      print(jobPostingData);
    }

    try {
      await apiService.createJobPosting(jobPostingData);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job added successfully')));
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add job: $error')));
    }
  }
}


  @override
  void initState() {
    super.initState();
    futureIndustryPartners = ApiService().fetchIndustryPartners();
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
              Center(
                child: _image == null && _webImage == null
                    ? const Text('No image selected.')
                    : kIsWeb
                        ? Image.memory(_webImage!)
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

              FutureBuilder<List<IndustryPartner>>(
                future: futureIndustryPartners,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No industry partners available."),
                    );
                  } else {
                    List<IndustryPartner> partners = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: partners.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(partners[index].partnerName),
                          subtitle: Text(
                              '${partners[index].partnerLocation}\n${partners[index].emailAdd}'),
                          onTap: () {
                            setState(() {
                              _selectedPartner = partners[index];
                            });
                          },
                          selected: _selectedPartner == partners[index],
                          selectedTileColor: Colors.grey[200],
                        );
                      },
                    );
                  }
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
