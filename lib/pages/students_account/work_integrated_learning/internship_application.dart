
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/student.dart';
import 'package:flutter_app/models/work_integrated_learning/internship.dart';

class InternshipApplicationScreen extends StatefulWidget {
  final StudentAccount studentAccount;
  final InternshipWithPartner internshipWithPartner;

  const InternshipApplicationScreen({super.key, required this.internshipWithPartner, required this.studentAccount});

  @override
  _InternshipApplicationScreenState createState() => _InternshipApplicationScreenState();
}

class _InternshipApplicationScreenState extends State<InternshipApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;

  // Resume variables
  Uint8List? resumeBytes;
  String resumeSource = '';

  // Cover Letter variables
  Uint8List? coverLetterBytes;
  String coverLetterSource = '';

  // Controllers for form inputs
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController certificationsController = TextEditingController();
  final TextEditingController educationController = TextEditingController();

  // Method to pick Resume
  void _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc'],
    );

    if (result != null) {
      setState(() {
        resumeBytes = result.files.first.bytes;
        resumeSource = result.files.first.name; // Store file name
      });
    }
  }

  // Method to pick Cover Letter
  void _pickCoverLetter() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc'],
    );

    if (result != null) {
      setState(() {
        coverLetterBytes = result.files.first.bytes;
        coverLetterSource = result.files.first.name; // Store file name
      });
    }
  }

  void _submitApplication() {
    // TODO: Implement the submission logic
    if (kDebugMode) {
      debugPrint('Application submitted');
    }
  }

  void _showSubmissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Submission',
              style: TextStyle(fontWeight: FontWeight.w900)),
          content:
              const Text('Are you sure you want to submit your application?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                _submitApplication(); // Submit the application
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
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
              // Internship Details Card
              Align(
                alignment: Alignment.centerLeft,
                child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        widget.internshipWithPartner.displayPhoto,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.internshipWithPartner.internshipTitle,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(widget.internshipWithPartner.partnerName,
                                style: const TextStyle(
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                  } else {
                    // Implement the submission logic
                    _showSubmissionDialog();
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
              
                  // Document Submission Step
                  Step(
                    title: const Text('Document Submission',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Please upload your resume and cover letter:',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 8),
              
                        // Resume
                        const Text(
                          'Resume: (PDF, DOCX, DOC)',
                        ),
                        GestureDetector(
                          onTap: _pickResume,
                          child: Column(
                            children: [
                              if (resumeBytes != null)
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.description,
                                          color: Colors.blue),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          resumeSource,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (resumeBytes == null)
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: const Text(
                                    "Click to upload your resume",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
              
                        // Cover Letter
                        const Text(
                          'Cover Letter: (PDF, DOCX, DOC)',
                        ),
                        GestureDetector(
                          onTap: _pickCoverLetter,
                          child: Column(
                            children: [
                              if (coverLetterBytes != null)
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.description,
                                          color: Colors.green),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          coverLetterSource,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (coverLetterBytes == null)
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: const Text(
                                    "Click to upload your cover letter",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      
                      ],
                    ),
                    isActive: currentStep == 0,
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  
                  // Employer Questions Step
                  Step(
                    title: const Text('Employer Questions',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    content: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Answer the following questions:',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: skillsController,
                          decoration:
                              const InputDecoration(labelText: 'Skills'),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: certificationsController,
                          decoration: const InputDecoration(
                              labelText: 'Certifications'),
                        ),
                        // TextField(
                        //   controller: educationController,
                        //   decoration: const InputDecoration(
                        //       labelText: 'Educational Background'),
                        // ),
                      ],
                    ),
                    isActive: currentStep == 1,
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
              
                  // Review and Submit Step
                  Step(
                    title: const Text('Review and Submit',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Review your application:',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 8),
              
                        const Text('Resume:'),
                        if (resumeBytes != null)
                          Container(
                            height: 100,
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.description,
                                    color: Colors.blue),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    resumeSource,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 16),
              
                        // Cover Letter
                        const Text('Cover Letter:'),
                        if (coverLetterBytes != null)
                          Container(
                            height: 100,
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.description,
                                    color: Colors.green),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    coverLetterSource,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 16),
                        const Text('Skills:'),
                        Text(skillsController.text),
                        const SizedBox(height: 8),
                        const Text('Certifications:'),
                        Text(certificationsController.text),
                        // const SizedBox(height: 8),
                        // const Text('Educational Background:'),
                        // Text(educationController.text),
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
