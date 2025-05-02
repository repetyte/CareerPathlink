import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_application.dart';
import 'package:flutter_app/models/user_role/graduate.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_posting.dart';
import 'package:flutter_app/services/job_application_api_service.dart';
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
  late String resumeSource;

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
            style: TextStyle(fontWeight: FontWeight.bold),
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
    return controllers.map((controller) => '• ${controller.text}').join('\n');
  }

  void _submitApplication() async {
    skills = _combineFields(_skillsControllers);
    certifications = _combineFields(_certificationsControllers);

    // final DateFormat dateFormat = DateFormat('yyyy-dd-MM');
    // final String formattedDate = dateFormat.format(DateTime.now());
    // final DateTime dateApplied = dateFormat.parse(formattedDate);

    final jobApplicationData = JobApplication(
      job: widget.jobPostingWithPartner.jobId ?? 0,
      applicantFirstName: widget.graduateAccount.firstName,
      applicantLastName: widget.graduateAccount.lastName,
      degree: widget.graduateAccount.course,
      applicantLocation: widget.graduateAccount.address,
      applicantContactNo: widget.graduateAccount.contactNo,
      applicantEmail: widget.graduateAccount.email,
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
    super.initState();

    // Populate resume
    resumeSource = widget.graduateAccount.resume?.toString() ?? '';
    debugPrint('Resume: $resumeSource');

    // Populate skills
    if (widget.graduateAccount.skills!.isNotEmpty) {
      final skillLines = widget.graduateAccount.skills!.split('\n');
      for (var line in skillLines) {
        final skill = line.replaceFirst('• ', '').trim();
        if (skill.isNotEmpty) {
          _skillsControllers.add(TextEditingController(text: skill));
        }
      }
    } else {
      _addSkillField();
    }

    // Populate certifications
    if (widget.graduateAccount.certifications!.isNotEmpty) {
      final certificationLines =
          widget.graduateAccount.certifications!.split('\n');
      for (var line in certificationLines) {
        final certification = line.replaceFirst('• ', '').trim();
        if (certification.isNotEmpty) {
          _certificationsControllers
              .add(TextEditingController(text: certification));
        }
      }
    } else {
      _addCertificationField();
    }
  }
// (imports and class declarations unchanged)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Submission'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isDesktop = constraints.maxWidth >= 800;
              if (isDesktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          _buildJobDetailsCard(),
                          const SizedBox(height: 16),
                          _buildGraduateDetailsCard(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 1,
                      child: _buildStepper(),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildJobDetailsCard(),
                    const SizedBox(height: 16),
                    _buildGraduateDetailsCard(),
                    const SizedBox(height: 16),
                    _buildStepper(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildJobDetailsCard() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            'assets/images/${widget.jobPostingWithPartner.coverPhoto}',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Applying for",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(widget.jobPostingWithPartner.jobTitle,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(widget.jobPostingWithPartner.partnerName,
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),
                Text(widget.jobPostingWithPartner.salary,
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGraduateDetailsCard() {
    return Card(
      color: Colors.grey,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${widget.graduateAccount.firstName} ${widget.graduateAccount.lastName}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_city),
                const SizedBox(width: 4),
                Text(widget.graduateAccount.address,
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.contact_mail),
                const SizedBox(width: 4),
                Text(widget.graduateAccount.contactNo,
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.email),
                const SizedBox(width: 4),
                Text(widget.graduateAccount.email,
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper() {
    return Stepper(
      currentStep: currentStep,
      onStepContinue: () {
        if (currentStep < 2) {
          setState(() {
            currentStep++;
          });
        } else {
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
                            const Icon(Icons.description, color: Colors.blue),
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
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: widget.graduateAccount.resume!.isNotEmpty
                            ? Row(
                                children: [
                                  const Icon(Icons.description,
                                      color: Colors.blue),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      widget.graduateAccount.resume.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            : const Text(
                                "Drag and drop an image or click to select",
                                style: TextStyle(color: Colors.grey)),
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
                            const Icon(Icons.description, color: Colors.green),
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
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
        ),

        // Employer Questions Step
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
                  ElevatedButton.icon(
                    onPressed: _addSkillField,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.add),
                    label: Text('Add'),
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
                          controller: _certificationsControllers[index],
                          decoration: InputDecoration(
                              hintText: 'Enter requirement ${index + 1}'),
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
                        onPressed: () => _removeCertificationField(index),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _addCertificationField,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green),
                    ),
                    icon: Icon(Icons.add),
                    label: Text('Add'),
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
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
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
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              // Resume
              const Text('Resume:'),
              if (resumeSource.isNotEmpty)
                Row(
                  children: [
                    const Icon(Icons.description, color: Colors.blue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        resumeSource,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              else
                const Text(
                  'No resume provided',
                  style: TextStyle(color: Colors.grey),
                ),
              const SizedBox(height: 8),

              // Cover Letter
              const Text('Cover Letter:'),
              if (coverLetterBytes != null)
                Row(
                  children: [
                    const Icon(Icons.description, color: Colors.green),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        coverLetterSource,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              else
                const Text(
                  'No cover letter provided',
                  style: TextStyle(color: Colors.grey),
                ),
              const SizedBox(height: 8),

              // Skills
              const Text('Skills:'),
              if (_skillsControllers.isNotEmpty)
                Text(skills = _combineFields(_skillsControllers))
              else
                const Text('No skills provided',
                    style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),

              // Certifications
              const Text('Certifications:'),
              if (_certificationsControllers.isNotEmpty)
                Text(
                    certifications = _combineFields(_certificationsControllers),
                    style: TextStyle(color: Colors.black))
              else
                const Text('No certifications provided',
                    style: TextStyle(color: Colors.grey)),
            ],
          ),
          isActive: currentStep == 2,
          state: currentStep == 2 ? StepState.complete : StepState.indexed,
        ),
      ],
    );
  }
}
