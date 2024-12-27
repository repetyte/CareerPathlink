import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/industry_partner.dart';
import 'package:flutter_app/models/job_posting.dart';
import 'package:flutter_app/services/job_posting_api_service.dart';
import 'package:flutter_app/services/industry_partner_api_service.dart';

class RrAddJobPosting extends StatefulWidget {
  final VoidCallback onJobPostingAdded;

  const RrAddJobPosting({super.key, required this.onJobPostingAdded});

  @override
  _RrAddJobPostingState createState() => _RrAddJobPostingState();
}

class _RrAddJobPostingState extends State<RrAddJobPosting> {
  final JobPostingApiService jobPostingApiService = JobPostingApiService();
  final IndustryPartnerApiService industryPartnerApiService = IndustryPartnerApiService();
  final _formKey = GlobalKey<FormState>();

  IndustryPartner? _selectedPartner;
  late Future<List<IndustryPartner>> futureIndustryPartners;

  String jobTitle = '';
  Uint8List? coverPhotoBytes;
  String coverPhotoSource = ''; // Keeps track of the image source (path or URL)
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

  final List<TextEditingController> _requirementsControllers = [];
  final List<TextEditingController> _responsibilitiesControllers = [];

  @override
  void initState() {
    super.initState();
    futureIndustryPartners = industryPartnerApiService.fetchIndustryPartners();

    final html.Element? body = html.document.body;
    if (body != null) {
      body.onDragOver.listen(_handleDragOver);
      body.onDrop.listen(_handleDrop);
    }

    _addRequirementField();
    _addResponsibilityField();
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
      _responsibilitiesControllers.add(TextEditingController());
    });
  }

  void _removeResponsibilityField(int index) {
    setState(() {
      _responsibilitiesControllers.removeAt(index);
    });
  }

  void _clearResponsibilityFields() {
    setState(() {
      _responsibilitiesControllers.clear();
      _addResponsibilityField();
    });
  }

  String _combineFields(List<TextEditingController> controllers) {
    return controllers.map((controller) => '- ${controller.text}').join('\n');
  }

  Future<void> _submitJobPosting() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedPartner == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please select an industry partner.')));
        return;
      }

      requirements = _combineFields(_requirementsControllers);
      jobResponsibilities = _combineFields(_responsibilitiesControllers);

      final jobPostingData = JobPosting(
        coverPhoto: 'assets/images/$coverPhotoSource', // Use appropriate source
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

      if (kDebugMode) {
        print(jobPostingData.toJson());
      }

      try {
        await jobPostingApiService.createJobPosting(jobPostingData);
        widget.onJobPostingAdded();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Job added successfully')));
        Navigator.pop(context, true);
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
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                      ),
                      child: const SizedBox(
                        width: 430,
                        height: 100,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF808080),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 16, 16, 16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Cover Photo
                                              const Text(
                                                'Cover Photo:',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              GestureDetector(
                                                onTap: _pickFromFileExplorer,
                                                child: Column(children: [
                                                  if (coverPhotoBytes != null)
                                                    Container(
                                                      height: 400,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.0),
                                                      ),
                                                      child: Image.memory(
                                                          coverPhotoBytes!,
                                                          fit: BoxFit.contain),
                                                    ),
                                                  if (coverPhotoBytes == null)
                                                    Container(
                                                      height: 400,
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.0),
                                                      ),
                                                      child: const Text(
                                                          "Drag and drop an image or click to select",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey)),
                                                    ),
                                                ]),
                                              ),

                                              const SizedBox(height: 16.0),

                                              // Job Title
                                              const Text(
                                                'Job Title:',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              TextFormField(
                                                // decoration: const InputDecoration(labelText: 'Job Title'),
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            'Enter Job Title'),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter the job title';
                                                  }
                                                  jobTitle = value;
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(height: 16.0),

                                              // Status
                                              const Text(
                                                'Status:',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              DropdownButtonFormField<String>(
                                                // decoration: const InputDecoration(labelText: 'Status', hintText: 'Job Status'),
                                                // value: status,
                                                hint: Text('Select an option'),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    status = newValue!;
                                                  });
                                                },
                                                items: ['Open', 'Closed']
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Field/Industry
                                        const Text(
                                          'Field/Industry:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        DropdownButtonFormField<String>(
                                          // decoration: const InputDecoration(labelText: 'Field/Industry'),
                                          // value: fieldIndustry,
                                          hint: Text('Select an option'),
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
                                        const SizedBox(height: 16.0),

                                        // Job Level
                                        const Text(
                                          'Job Level:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        DropdownButtonFormField<String>(
                                          // decoration: const InputDecoration(labelText: 'Job Level'),
                                          // value: jobLevel,
                                          hint: Text('Select an option'),
                                          onChanged: (newValue) {
                                            setState(() {
                                              jobLevel = newValue!;
                                            });
                                          },
                                          items: [
                                            'Entry Level',
                                            'Mid-level',
                                            'Senior Level'
                                          ].map((String value) {
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
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        DropdownButtonFormField<String>(
                                          // decoration: const InputDecoration(
                                          //     labelText: 'Years of Experience Needed'),
                                          // value: yrsOfExperienceNeeded,
                                          hint: Text('Select an option'),
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
                                        const SizedBox(height: 16.0),

                                        // Contractual Status
                                        const Text(
                                          'Contractual Status:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        DropdownButtonFormField<String>(
                                          // decoration:
                                          //     const InputDecoration(labelText: 'Contractual Status'),
                                          // value: contractualStatus,
                                          hint: Text('Select an option'),
                                          onChanged: (newValue) {
                                            setState(() {
                                              contractualStatus = newValue!;
                                            });
                                          },
                                          items: [
                                            'Full-time',
                                            'Part-time',
                                            'Contractual'
                                          ].map((String value) {
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
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        DropdownButtonFormField<String>(
                                          // decoration: const InputDecoration(labelText: 'Salary Range'),
                                          // value: salary,
                                          hint: Text('Select an option'),
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
                                        const SizedBox(height: 16.0),

                                        // Job Location
                                        const Text(
                                          'Job Location:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        DropdownButtonFormField<String>(
                                          // decoration: const InputDecoration(labelText: 'Job Location'),
                                          // value: jobLocation,
                                          hint: Text('Select an option'),
                                          onChanged: (newValue) {
                                            setState(() {
                                              jobLocation = newValue!;
                                            });
                                          },
                                          items: [
                                            'Around Naga City',
                                            'Around Camarines Sur',
                                            'Around Bicol Rrgion',
                                            'Domestic/Around Philippines',
                                            'International/Abroad'
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                        const SizedBox(height: 16.0),

                                        // Job Description
                                        const Text(
                                          'Job Description:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextFormField(
                                          // decoration: const InputDecoration(labelText: 'Job Description'),
                                          decoration: const InputDecoration(
                                              hintText:
                                                  'Enter the job description'),
                                          maxLines: 5,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter the job description';
                                            }
                                            jobDescription = value;
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16.0),

                                        // Requirements
                                        const Text(
                                          'Requirements:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              _requirementsControllers.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        _requirementsControllers[
                                                            index],
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            'Enter requirement ${index + 1}'),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter the requirement';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () =>
                                                      _removeRequirementField(
                                                          index),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: _addRequirementField,
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                        Colors.green),
                                              ),
                                              // icon: Icon(Icons.add),
                                              child: Text('Add Requirement'),
                                            ),
                                            TextButton(
                                              onPressed:
                                                  _clearRequirementFields,
                                              // icon: Icon(Icons.clear),
                                              child: Text('Clear'),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16.0),

                                        // Job Responsibilities
                                        const Text(
                                          'Job Responsibilities:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              _responsibilitiesControllers
                                                  .length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        _responsibilitiesControllers[
                                                            index],
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            'Enter responsibility ${index + 1}'),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter the responsibility';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () =>
                                                      _removeResponsibilityField(
                                                          index),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed:
                                                  _addResponsibilityField,
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                        Colors.green),
                                              ),
                                              child: Text('Add Responsibility'),
                                            ),
                                            TextButton(
                                              onPressed:
                                                  _clearResponsibilityFields,
                                              child: Text(
                                                  'Clear'), // icon: Icon(Icons.clear),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16.0),

                                        // About Employer
                                        const Text(
                                          'About Employer:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        FutureBuilder<List<IndustryPartner>>(
                                          future: futureIndustryPartners,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                    "Error: ${snapshot.error}"),
                                              );
                                            } else if (!snapshot.hasData ||
                                                snapshot.data!.isEmpty) {
                                              return const Center(
                                                child: Text(
                                                    "No industry partners available."),
                                              );
                                            } else {
                                              List<IndustryPartner> partners =
                                                  snapshot.data!;
                                              return ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: partners.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    title: Text(partners[index]
                                                        .partnerName),
                                                    subtitle: Text(
                                                        '${partners[index].partnerLocation}\n${partners[index].emailAdd}'),
                                                    onTap: () {
                                                      setState(() {
                                                        _selectedPartner =
                                                            partners[index];
                                                      });
                                                    },
                                                    selected:
                                                        _selectedPartner ==
                                                            partners[index],
                                                    selectedTileColor:
                                                        Colors.grey[200],
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        ),

                                        // Submit Button
                                        const SizedBox(height: 16),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: ElevatedButton.icon(
                                            icon: const Icon(Icons.save),
                                            onPressed: () async {
                                              // Validate the form and post the job
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                await _submitJobPosting();
                                              }
                                            },
                                            label: const Text('Post Job'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
