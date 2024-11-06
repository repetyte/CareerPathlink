import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/job_posting.dart';
import 'package:google_fonts/google_fonts.dart';

class DocumentSubmissionScreen extends StatefulWidget {
  final JobPosting jobPosting;

  const DocumentSubmissionScreen({super.key, required this.jobPosting});

  @override
  _DocumentSubmissionScreenState createState() =>
      _DocumentSubmissionScreenState();
}

class _DocumentSubmissionScreenState extends State<DocumentSubmissionScreen> {
  int currentStep = 0;

  // Controllers for form inputs
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController certificationsController =
      TextEditingController();
  final TextEditingController educationController = TextEditingController();

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
                child: Stack(
                  children: [
                    widget.jobPosting.coverPhoto != null
                        ? Image.memory(
                            widget.jobPosting.coverPhoto! as Uint8List,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                            color: Colors.black.withOpacity(0.6),
                            colorBlendMode: BlendMode.darken,
                          )
                        : Container(),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Text(
                        widget.jobPosting.jobTitle,
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Text(
                        widget.jobPosting.salary,
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 48,
                      left: 16,
                      child: Text(
                        widget.jobPosting.fieldIndustry,
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white,
                        ),
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
                    title: const Text('Document Submission'),
                    content: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // TODO: Implement file picker and upload logic
                          },
                          child: const Text('Upload Resume (PDF, Max 2MB)'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // TODO: Implement file picker and upload logic
                          },
                          child:
                              const Text('Upload Cover Letter (PDF, Max 2MB)'),
                        ),
                      ],
                    ),
                    isActive: currentStep == 0,
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Employer Questions'),
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
                    title: const Text('Review and Submit'),
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
