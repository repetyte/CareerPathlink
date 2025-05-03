import 'dart:convert';
import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/industry_partner.dart';
import 'package:flutter_app/models/work_integrated_learning/internship.dart';
import 'package:flutter_app/services/internship_api_service.dart';
import 'package:flutter_app/services/industry_partner_api_service.dart';

class AddInternship extends StatefulWidget {
  final IndustryPartnerAccount employerPartnerAccount;
  final VoidCallback onInternshipAdded;

  const AddInternship(
      {super.key,
      required this.onInternshipAdded,
      required this.employerPartnerAccount});

  @override
  _AddInternshipState createState() => _AddInternshipState();
}

class _AddInternshipState extends State<AddInternship> {
  final InternshipApiService internshipApiService = InternshipApiService();
  final IndustryPartnerApiService industryPartnerApiService =
      IndustryPartnerApiService();
  final _formKey = GlobalKey<FormState>();

  IndustryPartner? _selectedPartner;
  late Future<List<IndustryPartner>> futureIndustryPartners;

  String internshipTitle = '';
  Uint8List? displayPhotoBytes;
  String displayPhotoSource =
      ''; // Keeps track of the image source (path or URL)
  int hours = 20;
  String takehomePay = 'Below PHP 10,000';
  String location = 'Work From Home';
  String description = '';
  String requiredSkills = '';
  String qualifications = '';

  final List<TextEditingController> _requiredSkillsControllers = [];
  final List<TextEditingController> _qualificationsControllers = [];

  @override
  void initState() {
    debugPrint(
        'Employer Partner ID: ${widget.employerPartnerAccount.partnerName}');
    debugPrint(
        'Employer Partner Location: ${widget.employerPartnerAccount.partnerLocation}\n');
    super.initState();
    futureIndustryPartners = industryPartnerApiService.fetchIndustryPartners();

    final html.Element? body = html.document.body;
    if (body != null) {
      body.onDragOver.listen(_handleDragOver);
      body.onDrop.listen(_handleDrop);
    }

    _addRequiredSkillField();
    _addQualificationField();
  }

  void _pickFromFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        displayPhotoBytes = result.files.first.bytes;
        displayPhotoSource = result.files.first.name;
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
          displayPhotoBytes = reader.result as Uint8List?;
          displayPhotoSource = file.name;
        });
      });
    }
  }

  void _addRequiredSkillField() {
    setState(() {
      _requiredSkillsControllers.add(TextEditingController());
    });
  }

  void _removeRequiredSkillField(int index) {
    setState(() {
      _requiredSkillsControllers.removeAt(index);
    });
  }

  void _clearRequiredSkillFields() {
    setState(() {
      _requiredSkillsControllers.clear();
      _addRequiredSkillField();
    });
  }

  void _addQualificationField() {
    setState(() {
      _qualificationsControllers.add(TextEditingController());
    });
  }

  void _removeQualificationField(int index) {
    setState(() {
      _qualificationsControllers.removeAt(index);
    });
  }

  void _clearQualificationFields() {
    setState(() {
      _qualificationsControllers.clear();
      _addQualificationField();
    });
  }

  String _combineFields(List<TextEditingController> controllers) {
    return controllers.map((controller) => '• ${controller.text}').join('\n');
  }

  Future<void> _submitInternship() async {
    if (_formKey.currentState!.validate()) {
      requiredSkills = _combineFields(_requiredSkillsControllers);
      qualifications = _combineFields(_qualificationsControllers);

      final internshipData = Internship(
        displayPhoto: displayPhotoSource, // Use appropriate source
        internshipTitle: internshipTitle,
        hours: hours.toString(),
        takehomePay: takehomePay,
        location: location,
        description: description,
        requiredSkills: requiredSkills,
        qualifications: qualifications,
        industryPartner: widget.employerPartnerAccount.partnerId,
      );

      // Debugging: Print the JSON data
      if (kDebugMode) {
        debugPrint(jsonEncode(internshipData.toJson()));
      }

      try {
        await internshipApiService.createInternship(internshipData);
        widget.onInternshipAdded();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('WIL Opportunity added successfully')));
        Navigator.pop(context, true);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add internship: $error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add WIL Opportunity Posting'),
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
                                    child: isDesktop
                                        ? _buildDesktopLayout()
                                        : _buildMobileLayout(),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: isDesktop
                                      ? _buildDesktopBottomLayout()
                                      : _buildMobileBottomLayout(),
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

  Widget _buildMobileLayout() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display Photo
              const Text(
                'Display Photo:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              GestureDetector(
                onTap: _pickFromFileExplorer,
                child: Column(children: [
                  if (displayPhotoBytes != null)
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child:
                          Image.memory(displayPhotoBytes!, fit: BoxFit.contain),
                    ),
                  if (displayPhotoBytes == null)
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      height: 400,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: const Text(
                          "Drag and drop an image or click to select",
                          style: TextStyle(color: Colors.grey)),
                    ),
                ]),
              ),
              const SizedBox(height: 16.0),

              // WIL Opportunity Title
              const Text(
                'WIL Opportunity Title:',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Enter WIL Opportunity Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the internship title';
                  }
                  internshipTitle = value;
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // WIL Opportunity Description
              const Text(
                'WIL Opportunity Description:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Enter the internship description'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the internship description';
                  }
                  description = value;
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column - Display Photo
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Display Photo:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: _pickFromFileExplorer,
                  child: Column(children: [
                    if (displayPhotoBytes != null)
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Image.memory(displayPhotoBytes!,
                            fit: BoxFit.contain),
                      ),
                    if (displayPhotoBytes == null)
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        height: 400,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: const Text(
                            "Drag and drop an image or click to select",
                            style: TextStyle(color: Colors.grey)),
                      ),
                  ]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          // Right column - Title and Description
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // WIL Opportunity Title
                const Text(
                  'WIL Opportunity Title:',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Enter WIL Opportunity Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the internship title';
                    }
                    internshipTitle = value;
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // WIL Opportunity Description
                const Text(
                  'WIL Opportunity Description:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Enter the internship description'),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the internship description';
                    }
                    description = value;
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileBottomLayout() {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // WIL Opportunity Location
          const Text(
            'WIL Opportunity Location:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          DropdownButtonFormField<String>(
            hint: Text('Select an option'),
            onChanged: (newValue) {
              setState(() {
                location = newValue!;
              });
            },
            items: [
              'Work From Home',
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

          // Required Skills
          const Text(
            'Required Skills:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _requiredSkillsControllers.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _requiredSkillsControllers[index],
                      decoration: InputDecoration(
                          hintText: 'Enter required skill ${index + 1}'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the required skil';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeRequiredSkillField(index),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _addRequiredSkillField,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green),
                ),
                icon: Icon(Icons.add),
                label: Text('Add'),
              ),
              TextButton(
                onPressed: _clearRequiredSkillFields,
                child: Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // WIL Opportunity Qualifications
          const Text(
            'WIL Opportunity Qualifications:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _qualificationsControllers.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _qualificationsControllers[index],
                      decoration: InputDecoration(
                          hintText: 'Enter qualification ${index + 1}'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the quailification';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeQualificationField(index),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _addQualificationField,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green),
                ),
                icon: Icon(Icons.add),
                label: Text('Add'),
              ),
              TextButton(
                onPressed: _clearQualificationFields,
                child: Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // WIL Opportunity Hours
          const Text(
            'WIL Opportunity Hours:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Slider(
            min: 20,
            max: 100,
            divisions: 80,
            label: hours.toString(),
            value: hours.toDouble(),
            onChanged: (value) {
              setState(() {
                hours = value.round();
              });
            },
          ),
          const SizedBox(height: 16.0),

          // WIL Allowance
          const Text(
            'WIL Allowance:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          DropdownButtonFormField<String>(
            hint: Text('Select an option'),
            onChanged: (newValue) {
              setState(() {
                takehomePay = newValue!;
              });
            },
            items: [
              'Below PHP 10,000',
              'PHP 10,000 - PHP 15,000',
              'PHP 15,000 - PHP 20,000',
              'PHP 20,000 - PHP 25,000',
              'Above PHP 25,000'
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 16.0),

          // About Employer
          const Text(
            'About Employer:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(widget.employerPartnerAccount.partnerName.toString(),
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(
            widget.employerPartnerAccount.partnerLocation.toString(),
          ),

          // Submit Button
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _submitInternship();
                }
              },
              label: const Text('Post WIL Opportunity'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopBottomLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column - Location to Qualifications
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // WIL Opportunity Location
                  const Text(
                    'WIL Opportunity Location:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  DropdownButtonFormField<String>(
                    hint: Text('Select an option'),
                    onChanged: (newValue) {
                      setState(() {
                        location = newValue!;
                      });
                    },
                    items: [
                      'Work From Home',
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

                  // Required Skills
                  const Text(
                    'Required Skills:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _requiredSkillsControllers.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _requiredSkillsControllers[index],
                              decoration: InputDecoration(
                                  hintText:
                                      'Enter required skill ${index + 1}'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the required skil';
                                }
                                return null;
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _removeRequiredSkillField(index),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _addRequiredSkillField,
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.green),
                        ),
                        icon: Icon(Icons.add),
                        label: Text('Add'),
                      ),
                      TextButton(
                        onPressed: _clearRequiredSkillFields,
                        child: Text('Clear'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),

                  // WIL Opportunity Qualifications
                  const Text(
                    'WIL Opportunity Qualifications:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _qualificationsControllers.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _qualificationsControllers[index],
                              decoration: InputDecoration(
                                  hintText: 'Enter qualification ${index + 1}'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the quailification';
                                }
                                return null;
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _removeQualificationField(index),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _addQualificationField,
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.green),
                        ),
                        icon: Icon(Icons.add),
                        label: Text('Add'),
                      ),
                      TextButton(
                        onPressed: _clearQualificationFields,
                        child: Text('Clear'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            // Right column - Hours to About Employer
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // WIL Opportunity Hours
                  const Text(
                    'WIL Opportunity Hours:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Slider(
                    min: 20,
                    max: 100,
                    divisions: 80,
                    label: hours.toString(),
                    value: hours.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        hours = value.round();
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),

                  // WIL Allowance
                  const Text(
                    'WIL Allowance:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  DropdownButtonFormField<String>(
                    hint: Text('Select an option'),
                    onChanged: (newValue) {
                      setState(() {
                        takehomePay = newValue!;
                      });
                    },
                    items: [
                      'Below PHP 10,000',
                      'PHP 10,000 - PHP 15,000',
                      'PHP 15,000 - PHP 20,000',
                      'PHP 20,000 - PHP 25,000',
                      'Above PHP 25,000'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),

                  // About Employer
                  const Text(
                    'About Employer:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(widget.employerPartnerAccount.partnerName.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                    widget.employerPartnerAccount.partnerLocation.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Submit Button
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.save),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await _submitInternship();
              }
            },
            label: const Text('Post WIL Opportunity'),
          ),
        ),
      ],
    );
  }
}
