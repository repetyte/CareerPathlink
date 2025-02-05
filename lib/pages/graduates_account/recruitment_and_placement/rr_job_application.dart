import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_application.dart';
import 'package:flutter_app/models/user_role/graduate.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_posting.dart';
import 'package:flutter_app/services/job_application_api_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class JobApplicationScreen extends StatefulWidget {
  final JobPostingWithPartner jobPostingWithPartner;
  final GraduateAccount graduateAccount;

  const JobApplicationScreen(
      {super.key,
      required this.jobPostingWithPartner,
      required this.graduateAccount});

  @override
  _JobApplicationScreenState createState() => _JobApplicationScreenState();
}

class _JobApplicationScreenState extends State<JobApplicationScreen> {
  int currentStep = 0;

  final JobApplicationApiService jobApplicationApiService =
      JobApplicationApiService();

  // Resume variables
  Uint8List? resumeBytes;
  String resumeSource = '';

  // Cover Letter variables
  Uint8List? coverLetterBytes;
  String coverLetterSource = '';

  // Controllers for form inputs
  final List<TextEditingController> _skillsControllers = [];
  final List<TextEditingController> _certificationsControllers = [];

  //Combined Strings
  String skills = '';
  String certifications = '';

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

  void _addSkillField() {
    setState(() {
      _skillsControllers.add(TextEditingController());
    });
  }

  void _removeSkillField(int index) {
    setState(() {
      _skillsControllers.removeAt(index);
    });
  }

  void _clearSkillFields() {
    setState(() {
      _skillsControllers.clear();
      _addSkillField();
    });
  }

  void _addCertificationField() {
    setState(() {
      _certificationsControllers.add(TextEditingController());
    });
  }

  void _removeCertificationField(int index) {
    setState(() {
      _certificationsControllers.removeAt(index);
    });
  }

  void _clearCertificationFields() {
    setState(() {
      _certificationsControllers.clear();
      _addCertificationField();
    });
  }

  void _showSubmissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Submission',
            style: GoogleFonts.getFont(
              'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
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

  String _combineFields(List<TextEditingController> controllers) {
    return controllers.map((controller) => '- ${controller.text}').join('\n');
  }

  void _submitApplication() async {
    skills = _combineFields(_skillsControllers);
    certifications = _combineFields(_certificationsControllers);

    // final DateFormat dateFormat = DateFormat('yyyy-dd-MM');
    // final String formattedDate = dateFormat.format(DateTime.now());
    // final DateTime dateApplied = dateFormat.parse(formattedDate);

    final jobApplicationData = JobApplication(
      applicant: widget.graduateAccount.graduateId.toString(),
      job: widget.jobPostingWithPartner.jobId ?? 0,
      resume: resumeSource,
      coverLetter: coverLetterSource,
      skills: skills,
      certifications: certifications,
      applicationStatus: 'Pending',
      dateApplied: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );

    // Debugging: Print the JSON data
    if (kDebugMode) {
      debugPrint(jsonEncode(jobApplicationData.toJson()));
    }

    try {
      // Send the job application data to the API
      await jobApplicationApiService.createJobApplication(jobApplicationData);
      // widget.onJobPostingAdded();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Job application submitted successfully')));
      Navigator.pop(context, true);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add job application: $error')));
    }
  }

  @override
  void initState() {
    debugPrint('Graduatesssss ID: ${widget.graduateAccount.graduateId}');
    debugPrint('Department: ${widget.graduateAccount.department}');
    super.initState();
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
                  borderRadius: BorderRadius.circular(40.0),
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
                              style: const TextStyle(
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 16),
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
                                    borderRadius: BorderRadius.circular(40.0),
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
                                    borderRadius: BorderRadius.circular(40.0),
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
                                    borderRadius: BorderRadius.circular(40.0),
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
                                    borderRadius: BorderRadius.circular(40.0),
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
                  Step(
                    title: const Text('Employer Questions',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Answer the following questions:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        // Skills
                        const Text('Skills'),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _skillsControllers.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _skillsControllers[index],
                                    decoration: InputDecoration(
                                        hintText: 'Enter skill ${index + 1}'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a skill';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _removeSkillField(index),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: _addSkillField,
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.green),
                              ),
                              // icon: Icon(Icons.add),
                              child: Text('Add your Skill'),
                            ),
                            TextButton(
                              onPressed: _clearSkillFields,
                              // icon: Icon(Icons.clear),
                              child: Text('Clear'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Certifications
                        const Text('Certifications'),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _certificationsControllers.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        _certificationsControllers[index],
                                    decoration: InputDecoration(
                                        hintText:
                                            'Enter requirement ${index + 1}'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the requirement';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () =>
                                      _removeCertificationField(index),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: _addCertificationField,
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.green),
                              ),
                              // icon: Icon(Icons.add),
                              child: Text('Add your Certification'),
                            ),
                            TextButton(
                              onPressed: _clearCertificationFields,
                              // icon: Icon(Icons.clear),
                              child: Text('Clear'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    isActive: currentStep == 1,
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Review and Submit',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Review your application:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        // Resume
                        const Text('Resume:'),
                        if (resumeBytes != null)
                          Container(
                            height: 100,
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(40.0),
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
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: const Text(
                              "No resume uploaded",
                              style: TextStyle(color: Colors.grey),
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
                              borderRadius: BorderRadius.circular(40.0),
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
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: const Text(
                              "No cover letter uploaded",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        const SizedBox(height: 16),
                        const Text('Skills:'),
                        if (_skillsControllers.isNotEmpty)
                          Text(skills = _combineFields(_skillsControllers))
                        else
                          const Text('No skills provided',
                              style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 8),
                        const Text('Certifications:'),
                        if (_certificationsControllers.isNotEmpty)
                          Text(
                              certifications =
                                  _combineFields(_certificationsControllers),
                              style: TextStyle(color: Colors.black))
                        else
                          const Text('No certifications provided',
                              style: TextStyle(color: Colors.grey)),
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
