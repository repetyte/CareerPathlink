import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/industry_partner.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_posting.dart';
import 'package:flutter_app/services/job_posting_api_service.dart';
import 'package:flutter_app/services/industry_partner_api_service.dart';

class RrUpdateJobPosting extends StatefulWidget {
  final VoidCallback onStudentUpdated;
  final JobPostingWithPartner jobPostingWithPartner;

  const RrUpdateJobPosting(
      {super.key,
      required this.jobPostingWithPartner,
      required this.onStudentUpdated,});

  @override
  _RrUpdateJobPostingState createState() => _RrUpdateJobPostingState();
}

class _RrUpdateJobPostingState extends State<RrUpdateJobPosting> {
  final JobPostingApiService jobPostingApiService = JobPostingApiService();
  final IndustryPartnerApiService industryPartnerApiService = IndustryPartnerApiService();
  final _formKey = GlobalKey<FormState>();

  IndustryPartner? _selectedPartner;
  late Future<List<IndustryPartner>> futureIndustryPartners;

  Uint8List? coverPhotoBytes;
  String coverPhotoSource = '';
  late TextEditingController _titleController;
  late TextEditingController _statusController;
  late TextEditingController _fieldIndustryController;
  late TextEditingController _jobLevelController;
  late TextEditingController _yrsOfExperienceNeededController;
  late TextEditingController _contractualStatusController;
  late TextEditingController _salaryController;
  late TextEditingController _jobLocationController;
  late TextEditingController _jobDescriptionController;
  late TextEditingController _requirementsController;
  late TextEditingController _jobResponsibilitiesController;
  late TextEditingController _industryPartnerController;

  @override
  void initState() {
    super.initState();
    futureIndustryPartners = industryPartnerApiService.fetchIndustryPartners();

    // Job Posting
    _titleController =
        TextEditingController(text: widget.jobPostingWithPartner.jobTitle);
    _statusController =
        TextEditingController(text: widget.jobPostingWithPartner.status);
    _fieldIndustryController =
        TextEditingController(text: widget.jobPostingWithPartner.fieldIndustry);
    _jobLevelController =
        TextEditingController(text: widget.jobPostingWithPartner.jobLevel);
    _yrsOfExperienceNeededController = TextEditingController(
        text: widget.jobPostingWithPartner.yrsOfExperienceNeeded);
    _contractualStatusController = TextEditingController(
        text: widget.jobPostingWithPartner.contractualStatus);
    _salaryController =
        TextEditingController(text: widget.jobPostingWithPartner.salary);
    _jobLocationController =
        TextEditingController(text: widget.jobPostingWithPartner.jobLocation);
    _jobDescriptionController = TextEditingController(
        text: widget.jobPostingWithPartner.jobDescription);
    _requirementsController =
        TextEditingController(text: widget.jobPostingWithPartner.requirements);
    _jobResponsibilitiesController = TextEditingController(
        text: widget.jobPostingWithPartner.jobResponsibilities);
    _industryPartnerController = TextEditingController(
        text: widget.jobPostingWithPartner.partnerId.toString());

    // Industry Partner
    _selectedPartner = IndustryPartner(
      partnerId: widget.jobPostingWithPartner.partnerId,
      partnerName: widget.jobPostingWithPartner.partnerName,
      partnerLocation: widget.jobPostingWithPartner.partnerLocation,
      contactNo: widget.jobPostingWithPartner.contactNo,
      emailAdd: widget.jobPostingWithPartner.emailAdd,
    );

    // Drag and drop event listeners
    final html.Element? body = html.document.body;
    if (body != null) {
      body.onDragOver.listen(_handleDragOver);
      body.onDrop.listen(_handleDrop);
    }
  }

  void _pickFromFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        coverPhotoBytes = result.files.first.bytes;
        coverPhotoSource = result.files.first.name;
      });
    }
  }

  void _handleDragOver(html.MouseEvent event) {
    event.preventDefault();
  }

  void _handleDrop(html.MouseEvent event) async {
    event.preventDefault();
    final html.DataTransfer dataTransfer = event.dataTransfer;
    if (dataTransfer.files!.isNotEmpty) {
      final file = dataTransfer.files!.first;
      final reader = html.FileReader();

      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((_) {
        setState(() {
          coverPhotoBytes = reader.result as Uint8List?;
          coverPhotoSource = file.name;
        });
      });
    }
  }

  void _updateJobPosting() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedPartner == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please select an industry partner.')));
        return;
      }

      final jobPostingData = JobPostingWithPartner(
        jobId: widget.jobPostingWithPartner.jobId,
        coverPhoto: 'assets/images/$coverPhotoSource', // Use appropriate source
        jobTitle: _titleController.text,
        status: _statusController.text,
        fieldIndustry: _fieldIndustryController.text,
        jobLevel: _jobLevelController.text,
        yrsOfExperienceNeeded: _yrsOfExperienceNeededController.text,
        contractualStatus: _contractualStatusController.text,
        salary: _salaryController.text,
        jobLocation: _jobLocationController.text,
        jobDescription: _jobDescriptionController.text,
        requirements: _requirementsController.text,
        jobResponsibilities: _jobResponsibilitiesController.text,
        industryPartner: int.parse(_industryPartnerController.text),

        partnerId: _selectedPartner!.partnerId!,
        profilePic: _selectedPartner!.profilePic,
        partnerName: _selectedPartner!.partnerName,
        partnerLocation: _selectedPartner!.partnerLocation,
        contactNo: _selectedPartner!.contactNo,
        emailAdd: _selectedPartner!.emailAdd,
      );

      if (kDebugMode) {
        print(jobPostingData.toJson());
      }

      try {
        await jobPostingApiService.updateJobPosting(jobPostingData);
        widget.onStudentUpdated();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Job updated successfully')));
        Navigator.pop(context, true); // Pass true to indicate update success
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update job: $error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Job Posting'),
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
              GestureDetector(
                onTap: _pickFromFileExplorer,
                child: Column(children: [
                  if (coverPhotoBytes != null)
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child:
                          Image.memory(coverPhotoBytes!, fit: BoxFit.contain),
                    ),
                  if (coverPhotoBytes == null)
                    Container(
                      height: 200,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: const Text(
                          "Drag and drop an image or click to select"),
                    ),
                ]),
              ),
              const SizedBox(height: 16.0),

              // Job Title
              const Text(
                'Job Title:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                // decoration: const InputDecoration(labelText: 'Job Title'),
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Enter Job Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Status
              const Text(
                'Status:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                // decoration: const InputDecoration(labelText: 'Status', hintText: 'Job Status'),
                // value: status,
                value: _statusController.text,
                hint: Text('Select an option'),
                onChanged: (newValue) {
                  setState(() {
                    _statusController.text = newValue!;
                  });
                },
                items: ['Open', 'Closed'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),

              // Field/Industry
              const Text(
                'Field/Industry:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                // decoration: const InputDecoration(labelText: 'Field/Industry'),
                value: _fieldIndustryController.text,
                hint: Text('Select an option'),
                onChanged: (newValue) {
                  setState(() {
                    _fieldIndustryController.text = newValue!;
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
              const SizedBox(height: 16.0),

              // Job Level
              const Text(
                'Job Level:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                // decoration: const InputDecoration(labelText: 'Job Level'),
                value: _jobLevelController.text,
                hint: Text('Select an option'),
                onChanged: (newValue) {
                  setState(() {
                    _jobLevelController.text = newValue!;
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
              const SizedBox(height: 16.0),

              // Years of Experience Needed
              const Text(
                'Years of Experience Needed:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                // decoration: const InputDecoration(
                //     labelText: 'Years of Experience Needed'),
                value: _yrsOfExperienceNeededController.text,
                hint: Text('Select an option'),
                onChanged: (newValue) {
                  setState(() {
                    _yrsOfExperienceNeededController.text = newValue!;
                  });
                },
                items: [
                  'Fresh Graduate',
                  'Less than 1 Year',
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
              const SizedBox(height: 16.0),

              // Contractual Status
              const Text(
                'Contractual Status:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                // decoration:
                //     const InputDecoration(labelText: 'Contractual Status'),
                value: _contractualStatusController.text,
                hint: Text('Select an option'),
                onChanged: (newValue) {
                  setState(() {
                    _contractualStatusController.text = newValue!;
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
              const SizedBox(height: 16.0),

              // Salary Range
              const Text(
                'Salary Range:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                // decoration: const InputDecoration(labelText: 'Salary Range'),
                value: _salaryController.text,
                hint: Text('Select an option'),
                onChanged: (newValue) {
                  setState(() {
                    _salaryController.text = newValue!;
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
              const SizedBox(height: 16.0),

              // Job Location
              const Text(
                'Job Location:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                // decoration: const InputDecoration(labelText: 'Job Location'),
                controller: _jobLocationController,
                decoration:
                    const InputDecoration(hintText: 'Enter the job location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Job Description
              const Text(
                'Job Description:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                // decoration: const InputDecoration(labelText: 'Job Description'),
                controller: _jobDescriptionController,
                decoration: const InputDecoration(
                    hintText: 'Enter the job description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Requirements
              const Text(
                'Requirements:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                // decoration: const InputDecoration(labelText: 'Requirements'),
                controller: _requirementsController,
                decoration: const InputDecoration(
                    hintText: 'Enter the job requirements'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job requirements';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Job Responsibilities
              const Text(
                'Job Responsibilities:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                // decoration:
                //     const InputDecoration(labelText: 'Job Responsibilities'),
                controller: _jobResponsibilitiesController,
                decoration: const InputDecoration(
                    hintText: 'Enter the job responsibilities'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job responsibilities';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // About Employer
              const Text(
                'About Employer:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
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

              // Save Changes Button
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  onPressed: _updateJobPosting,
                  label: const Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF008000),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
