import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/job_posting.dart';

class JobApplicationScreen extends StatefulWidget {
  final JobPostingWithPartner jobPostingWithPartner;

  const JobApplicationScreen({super.key, required this.jobPostingWithPartner});

  @override
  _JobApplicationScreenState createState() => _JobApplicationScreenState();
}

class _JobApplicationScreenState extends State<JobApplicationScreen> {
  int currentStep = 0;
  Uint8List? coverPhotoBytes;
  String coverPhotoSource = ''; // Keeps track of the image source (path or URL)

  // Controllers for form inputs
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController certificationsController =
      TextEditingController();
  final TextEditingController educationController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Submission'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Job Details Card
              Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      widget.jobPostingWithPartner.coverPhoto,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.jobPostingWithPartner.jobTitle,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(widget.jobPostingWithPartner.salary,
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                          const SizedBox(height: 4),
                          Text(widget.jobPostingWithPartner.fieldIndustry,
                              style: const TextStyle(
                                fontSize: 14,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Stepper for application process
              Stepper(
                currentStep: currentStep,
                onStepContinue: () {
                  if (currentStep < 2) {
                    setState(() {
                      currentStep++;
                    });
                  }
                },
                onStepCancel: () {
                  if (currentStep > 0) {
                    setState(() {
                      currentStep--;
                    });
                  }
                },
                steps: [
                  Step(
                    title: const Text('Document Submission',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Resume: (PDF, DOCX, DOC)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: _pickFromFileExplorer,
                          child: Column(children: [
                            if (coverPhotoBytes != null)
                              Container(
                                height: 400,
                                width: 400,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.memory(coverPhotoBytes!,
                                      fit: BoxFit.contain),
                                ),
                              ),
                            if (coverPhotoBytes == null)
                              Container(
                                height: 400,
                                width: 400,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                      "Drag and drop an image or click to select",
                                      style: TextStyle(color: Colors.grey)),
                                ),
                              ),
                          ]),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Cover Letter: (PDF, DOCX, DOC)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: _pickFromFileExplorer,
                          child: Column(children: [
                            if (coverPhotoBytes != null)
                              Container(
                                height: 400,
                                width: 400,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.memory(coverPhotoBytes!,
                                      fit: BoxFit.contain),
                                ),
                              ),
                            if (coverPhotoBytes == null)
                              Container(
                                height: 400,
                                width: 400,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                      "Drag and drop an image or click to select",
                                      style: TextStyle(color: Colors.grey)),
                                ),
                              ),
                          ]),
                        ),
                      ],
                    ),
                    isActive: currentStep == 0,
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Employer Questions', style: TextStyle(fontWeight: FontWeight.bold)),
                    content: Column(
                      children: [
                        TextField(
                          controller: skillsController,
                          decoration:
                              const InputDecoration(labelText: 'Skills'),
                        ),
                        TextField(
                          controller: certificationsController,
                          decoration: const InputDecoration(
                              labelText: 'Certifications'),
                        ),
                        TextField(
                          controller: educationController,
                          decoration: const InputDecoration(
                              labelText: 'Educational Background'),
                        ),
                      ],
                    ),
                    isActive: currentStep == 1,
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Review and Submit', style: TextStyle(fontWeight: FontWeight.bold)),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Skills:'),
                        Text(skillsController.text),
                        const SizedBox(height: 8),
                        const Text('Certifications:'),
                        Text(certificationsController.text),
                        const SizedBox(height: 8),
                        const Text('Educational Background:'),
                        Text(educationController.text),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Implement the submission logic
                          },
                          child: const Text('Submit Application'),
                        ),
                      ],
                    ),
                    isActive: currentStep == 2,
                    state: currentStep == 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
