import 'dart:convert';
import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/industry_partner.dart';
import 'package:flutter_app/models/recruitment_and_placement/job_posting.dart';
import 'package:flutter_app/services/job_posting_api_service.dart';
import 'package:flutter_app/services/industry_partner_api_service.dart';

class RrUpdateJobPosting extends StatefulWidget {
  final VoidCallback onStudentUpdated;
  final JobPostingWithPartner jobPostingWithPartner;
  final IndustryPartnerAccount employerPartnerAccount;

  const RrUpdateJobPosting({
    super.key,
    required this.jobPostingWithPartner,
    required this.onStudentUpdated,
    required this.employerPartnerAccount,
  });

  @override
  _RrUpdateJobPostingState createState() => _RrUpdateJobPostingState();
}

class _RrUpdateJobPostingState extends State<RrUpdateJobPosting> {
  final JobPostingApiService jobPostingApiService = JobPostingApiService();
  final IndustryPartnerApiService industryPartnerApiService =
      IndustryPartnerApiService();
  final _formKey = GlobalKey<FormState>();

  IndustryPartner? _selectedPartner;
  late Future<List<IndustryPartner>> futureIndustryPartners;

  Uint8List? coverPhotoBytes;
  late String coverPhotoSource;
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

  final List<TextEditingController> _requirementsControllers = [];
  final List<TextEditingController> _jobResponsibilitiesControllers = [];

  @override
  void initState() {
    super.initState();
    futureIndustryPartners = industryPartnerApiService.fetchIndustryPartners();

    // Initialize controllers with existing job posting data
    coverPhotoSource = widget.jobPostingWithPartner.coverPhoto;
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

    _selectedPartner = IndustryPartner(
      partnerId: widget.jobPostingWithPartner.partnerId,
      partnerName: widget.jobPostingWithPartner.partnerName,
      partnerLocation: widget.jobPostingWithPartner.partnerLocation,
      contactNo: widget.jobPostingWithPartner.contactNo,
      emailAdd: widget.jobPostingWithPartner.emailAdd,
    );

    _initializeFields(_requirementsController.text, _requirementsControllers);
    _initializeFields(
        _jobResponsibilitiesController.text, _jobResponsibilitiesControllers);

    final html.Element? body = html.document.body;
    if (body != null) {
      body.onDragOver.listen(_handleDragOver);
      body.onDrop.listen(_handleDrop);
    }
  }

  void _initializeFields(String text, List<TextEditingController> controllers) {
    final statements =
        text.split('\n').map((s) => s.replaceFirst('• ', '')).toList();
    for (var statement in statements) {
      controllers.add(TextEditingController(text: statement));
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

  void _addRequirementField() {
    setState(() {
      _requirementsControllers.add(TextEditingController());
    });
  }

  void _removeRequirementField(int index) {
    setState(() {
      _requirementsControllers.removeAt(index);
    });
  }

  void _clearRequirementFields() {
    setState(() {
      _requirementsControllers.clear();
      _addRequirementField();
    });
  }

  void _addResponsibilityField() {
    setState(() {
      _jobResponsibilitiesControllers.add(TextEditingController());
    });
  }

  void _removeResponsibilityField(int index) {
    setState(() {
      _jobResponsibilitiesControllers.removeAt(index);
    });
  }

  void _clearResponsibilityFields() {
    setState(() {
      _jobResponsibilitiesControllers.clear();
      _addResponsibilityField();
    });
  }

  String _combineFields(List<TextEditingController> controllers) {
    return controllers.map((controller) => '• ${controller.text}').join('\n');
  }

  void _updateJobPosting() async {
    if (_formKey.currentState!.validate()) {
      _requirementsController.text = _combineFields(_requirementsControllers);
      _jobResponsibilitiesController.text =
          _combineFields(_jobResponsibilitiesControllers);

      final jobPostingData = JobPostingWithPartner(
        jobId: widget.jobPostingWithPartner.jobId,
        coverPhoto: coverPhotoSource,
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
        partnerId: widget.jobPostingWithPartner.partnerId,
        profilePic: widget.jobPostingWithPartner.profilePic,
        partnerName: widget.jobPostingWithPartner.partnerName,
        partnerLocation: widget.jobPostingWithPartner.partnerLocation,
        contactNo: widget.jobPostingWithPartner.contactNo,
        emailAdd: widget.jobPostingWithPartner.emailAdd,
      );

      try {
        await jobPostingApiService.updateJobPosting(jobPostingData);
        widget.onStudentUpdated();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Job updated successfully')));
        Navigator.pop(context, jobPostingData);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update job: $error')));
      }
    }
  }

  Widget _buildCoverPhotoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cover Photo:',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: _pickFromFileExplorer,
          child: Column(children: [
            if (coverPhotoBytes != null)
              Container(
                padding: const EdgeInsets.all(16.0),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Image.memory(coverPhotoBytes!, fit: BoxFit.contain),
              ),
            if (coverPhotoBytes == null)
              Container(
                padding: const EdgeInsets.all(16.0),
                height: 200,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: widget.jobPostingWithPartner.coverPhoto.isNotEmpty
                    ? Image.network(
                        'assets/images/${widget.jobPostingWithPartner.coverPhoto}',
                        fit: BoxFit.contain,
                      )
                    : const Text("Drag and drop an image or click to select",
                        style: TextStyle(color: Colors.grey)),
              ),
          ]),
        ),
      ],
    );
  }

  Widget _buildJobInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Job Title:',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
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
        const Text(
          'Field/Industry:',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField<String>(
          value: _fieldIndustryController.text,
          hint: const Text('Select an option'),
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
        const Text(
          'Status:',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField<String>(
          value: _statusController.text,
          hint: const Text('Select an option'),
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
      ],
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildJobDescriptionSection(),
        const SizedBox(height: 16.0),
        _buildJobLevelSection(),
        const SizedBox(height: 16.0),
        _buildExperienceSection(),
        const SizedBox(height: 16.0),
        _buildEmploymentStatusSection(),
        const SizedBox(height: 16.0),
        _buildSalarySection(),
        const SizedBox(height: 16.0),
        _buildLocationSection(),
      ],
    );
  }

  Widget _buildRightColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRequirementsSection(),
        const SizedBox(height: 16.0),
        _buildResponsibilitiesSection(),
        const SizedBox(height: 16.0),
        _buildAboutEmployerSection(),
      ],
    );
  }

  Widget _buildJobDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Job Description:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: _jobDescriptionController,
          decoration:
              const InputDecoration(hintText: 'Enter the job description'),
          maxLines: 3,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the job description';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildJobLevelSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Job Level:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField<String>(
          value: _jobLevelController.text,
          hint: const Text('Select an option'),
          onChanged: (newValue) {
            setState(() {
              _jobLevelController.text = newValue!;
            });
          },
          items:
              ['Entry Level', 'Mid-level', 'Senior Level'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Years of Experience Needed:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField<String>(
          value: _yrsOfExperienceNeededController.text,
          hint: const Text('Select an option'),
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
      ],
    );
  }

  Widget _buildEmploymentStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Employment Status:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField<String>(
          value: _contractualStatusController.text,
          hint: const Text('Select an option'),
          onChanged: (newValue) {
            setState(() {
              _contractualStatusController.text = newValue!;
            });
          },
          items: ['Full-time', 'Part-time', 'Contractual'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSalarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Salary Range:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField<String>(
          value: _salaryController.text,
          hint: const Text('Select an option'),
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
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Job Location:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: _jobLocationController,
          decoration: const InputDecoration(hintText: 'Enter the job location'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the job location';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildRequirementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Requirements:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _requirementsControllers.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _requirementsControllers[index],
                    decoration: InputDecoration(
                        hintText: 'Enter requirement ${index + 1}'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a requirement';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _removeRequirementField(index),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _addRequirementField,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
              ),
              icon: Icon(Icons.add),
              label: Text('Add'),
            ),
            TextButton(
              onPressed: _clearRequirementFields,
              child: const Text('Clear'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResponsibilitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Job Responsibilities:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _jobResponsibilitiesControllers.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _jobResponsibilitiesControllers[index],
                    decoration: InputDecoration(
                        hintText: 'Enter a job responsibility ${index + 1}'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a job responsibility';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _removeResponsibilityField(index),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _addResponsibilityField,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
              ),
              icon: Icon(Icons.add),
              label: Text('Add'),
            ),
            TextButton(
              onPressed: _clearResponsibilityFields,
              child: const Text('Clear'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAboutEmployerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About Employer:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Text(widget.jobPostingWithPartner.partnerName.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(
          widget.jobPostingWithPartner.partnerLocation.toString(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 768;

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
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF808080),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: isDesktop
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left side - Cover Photo
                                  Expanded(
                                    flex: 1,
                                    child: _buildCoverPhotoSection(),
                                  ),
                                  const SizedBox(width: 20),
                                  // Right side - Job Info
                                  Expanded(
                                    flex: 1,
                                    child: _buildJobInfoSection(),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  _buildCoverPhotoSection(),
                                  const SizedBox(height: 16),
                                  _buildJobInfoSection(),
                                ],
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: isDesktop
                          ? Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Left column - Job Description to Location
                                    Expanded(
                                      flex: 1,
                                      child: _buildLeftColumn(),
                                    ),
                                    const SizedBox(width: 20),
                                    // Right column - Requirements to About Employer
                                    Expanded(
                                      flex: 1,
                                      child: _buildRightColumn(),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.bottomRight,
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
                            )
                          : Column(
                              children: [
                                _buildLeftColumn(),
                                _buildRightColumn(),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.bottomRight,
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
