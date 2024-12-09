import 'dart:html' as html;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/job_posting.dart';
import 'package:flutter_app/services/api_service.dart';

class RrUpdateJobPosting extends StatefulWidget {
  final JobPostingWithPartner jobPostingWithPartner;

  const RrUpdateJobPosting(
      {super.key, required this.jobPostingWithPartner});

  @override
  _RrUpdateJobPostingState createState() =>
      _RrUpdateJobPostingState();
}

class _RrUpdateJobPostingState extends State<RrUpdateJobPosting> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  // late Uint8List? coverPhotoBytes;
  // late String coverPhotoSource;
  late TextEditingController _titleController;
  late TextEditingController _levelController;
  late TextEditingController _experienceController;
  late TextEditingController _contractualStatusController;
  late TextEditingController _salaryController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late TextEditingController _requirementsController;
  late TextEditingController _responsibilitiesController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current job details
    _titleController =
        TextEditingController(text: widget.jobPostingWithPartner.jobTitle);
    _levelController =
        TextEditingController(text: widget.jobPostingWithPartner.jobLevel);
    _experienceController = TextEditingController(
        text: widget.jobPostingWithPartner.yrsOfExperienceNeeded);
    _contractualStatusController = TextEditingController(
        text: widget.jobPostingWithPartner.contractualStatus);
    _salaryController =
        TextEditingController(text: widget.jobPostingWithPartner.salary);
    _locationController =
        TextEditingController(text: widget.jobPostingWithPartner.jobLocation);
    _descriptionController = TextEditingController(
        text: widget.jobPostingWithPartner.jobDescription);
    _requirementsController =
        TextEditingController(text: widget.jobPostingWithPartner.requirements);
    _responsibilitiesController = TextEditingController(
        text: widget.jobPostingWithPartner.jobResponsibilities);

    // final html.Element? body = html.document.body;
    // if (body != null) {
    //   body.onDragOver.listen(_handleDragOver);
    //   body.onDrop.listen(_handleDrop);
    // }
  }

  // void _pickFromFileExplorer() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //   );

  //   if (result != null) {
  //     setState(() {
  //       coverPhotoBytes = result.files.first.bytes;
  //       coverPhotoSource = result.files.first.name;
  //     });
  //   }
  // }

  // void _handleDragOver(html.MouseEvent event) {
  //   event.preventDefault();
  // }

  // void _handleDrop(html.MouseEvent event) async {
  //   event.preventDefault();
  //   final html.DataTransfer dataTransfer = event.dataTransfer;
  //   if (dataTransfer.files!.isNotEmpty) {
  //     final file = dataTransfer.files!.first;
  //     final reader = html.FileReader();

  //     reader.readAsArrayBuffer(file);
  //     reader.onLoadEnd.listen((_) {
  //       setState(() {
  //         coverPhotoBytes = reader.result as Uint8List?;
  //         coverPhotoSource = file.name;
  //       });
  //     });
  //   }
  // }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final updatedJob = JobPostingWithPartner(
        jobId: widget.jobPostingWithPartner.jobId,
        coverPhoto: widget.jobPostingWithPartner.coverPhoto,
        jobTitle: _titleController.text,
        jobLevel: _levelController.text,
        yrsOfExperienceNeeded: _experienceController.text,
        contractualStatus: _contractualStatusController.text,
        salary: _salaryController.text,
        jobLocation: _locationController.text,
        jobDescription: _descriptionController.text,
        requirements: _requirementsController.text,
        jobResponsibilities: _responsibilitiesController.text,
        partnerName: widget.jobPostingWithPartner.partnerName,
        status: widget.jobPostingWithPartner.status,
        fieldIndustry: widget.jobPostingWithPartner.fieldIndustry,
      );

      try {
        await apiService.updateJobPosting(updatedJob);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job updated successfully!')),
        );
        Navigator.pop(context, true); // Return to the details page
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update job: $e')),
        );
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
              const Text(
                'Job Details:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Divider(),

              // Cover Photo
              const Text(
                'Cover Photo:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              // GestureDetector(
              //   onTap: _pickFromFileExplorer,
              //   child: Column(
              //       children: [
              //         if (coverPhotoBytes != null)
              //           Container(
              //             height: 200,
              //             width: double.infinity,
              //             decoration: BoxDecoration(
              //               border: Border.all(color: Colors.grey),
              //               borderRadius: BorderRadius.circular(40.0),
              //             ),
              //             child:
              //                 Image.memory(coverPhotoBytes!, fit: BoxFit.contain),
              //           ),
              //         if (coverPhotoBytes == null)
              //           Container(
              //             height: 200,
              //             width: double.infinity,
              //             alignment: Alignment.center,
              //             decoration: BoxDecoration(
              //               border: Border.all(color: Colors.grey),
              //               borderRadius: BorderRadius.circular(40.0),
              //             ),
              //             child: const Text(
              //                 "Drag and drop an image or click to select"),
              //           ),
              //       ]),
              // ),
              const SizedBox(height: 16.0),
              const Divider(),

              const Text(
                'Requirements:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const Divider(),

              const Text(
                'Responsibilities:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              // Job Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Job Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _levelController,
                decoration: const InputDecoration(labelText: 'Job Level'),
              ),
              TextFormField(
                controller: _experienceController,
                decoration: const InputDecoration(
                    labelText: 'Years of Experience Needed'),
              ),
              TextFormField(
                controller: _contractualStatusController,
                decoration:
                    const InputDecoration(labelText: 'Contractual Status'),
              ),
              TextFormField(
                controller: _salaryController,
                decoration: const InputDecoration(labelText: 'Salary'),
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Job Location'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Job Description'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _requirementsController,
                decoration: const InputDecoration(labelText: 'Requirements'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _responsibilitiesController,
                decoration:
                    const InputDecoration(labelText: 'Job Responsibilities'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
