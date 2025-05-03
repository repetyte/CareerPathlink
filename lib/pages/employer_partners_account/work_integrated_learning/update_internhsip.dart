import 'dart:convert';
import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/industry_partner.dart';
import 'package:flutter_app/models/work_integrated_learning/internship.dart';
import 'package:flutter_app/services/internship_api_service.dart';
import 'package:flutter_app/services/industry_partner_api_service.dart';

class UpdateInternship extends StatefulWidget {
  final IndustryPartnerAccount employerPartnerAccount;
  final InternshipWithPartner internshipWithPartner;
  final VoidCallback onInternshipUpdated;

  const UpdateInternship(
      {super.key,
      required this.onInternshipUpdated,
      required this.employerPartnerAccount,
      required this.internshipWithPartner});

  @override
  _UpdateInternshipState createState() => _UpdateInternshipState();
}

class _UpdateInternshipState extends State<UpdateInternship> {
  final InternshipApiService internshipApiService = InternshipApiService();
  final IndustryPartnerApiService industryPartnerApiService =
      IndustryPartnerApiService();
  final _formKey = GlobalKey<FormState>();

  IndustryPartner? _selectedPartner;
  late Future<List<IndustryPartner>> futureIndustryPartners;

  Uint8List? displayPhotoBytes;
  late String displayPhotoSource;
  late TextEditingController _titleController;
  late TextEditingController _hoursController;
  late TextEditingController _takehomePayController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late TextEditingController _requiredSkillsController;
  late TextEditingController _qualificationsController;
  late TextEditingController _industryPartnerController;

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

    displayPhotoSource = widget.internshipWithPartner.displayPhoto;
    _titleController = TextEditingController(
        text: widget.internshipWithPartner.internshipTitle);
    _hoursController =
        TextEditingController(text: widget.internshipWithPartner.hours);
    _takehomePayController =
        TextEditingController(text: widget.internshipWithPartner.takehomePay);
    _locationController =
        TextEditingController(text: widget.internshipWithPartner.location);
    _descriptionController =
        TextEditingController(text: widget.internshipWithPartner.description);
    _requiredSkillsController = TextEditingController(
        text: widget.internshipWithPartner.requiredSkills);
    _qualificationsController = TextEditingController(
        text: widget.internshipWithPartner.qualifications);
    _industryPartnerController = TextEditingController(
        text: widget.internshipWithPartner.industryPartner.toString());

    _selectedPartner = IndustryPartner(
      partnerId: widget.internshipWithPartner.internshipId,
      partnerName: widget.internshipWithPartner.partnerName,
      partnerLocation: widget.internshipWithPartner.partnerLocation,
      contactNo: widget.internshipWithPartner.contactNo,
      emailAdd: widget.internshipWithPartner.emailAdd,
    );

    _initializeFields(
        _requiredSkillsController.text, _requiredSkillsControllers);
    _initializeFields(
        _qualificationsController.text, _qualificationsControllers);
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

  Future<void> _updateInternship() async {
    if (_formKey.currentState!.validate()) {
      _requiredSkillsController.text =
          _combineFields(_requiredSkillsControllers);
      _qualificationsController.text =
          _combineFields(_qualificationsControllers);

      final internshipData = InternshipWithPartner(
        internshipId: widget.internshipWithPartner.internshipId,
        displayPhoto: displayPhotoSource,
        internshipTitle: _titleController.text,
        hours: _hoursController.text,
        takehomePay: _takehomePayController.text,
        location: _locationController.text,
        description: _descriptionController.text,
        requiredSkills: _requiredSkillsController.text,
        qualifications: _qualificationsController.text,
        industryPartner: int.parse(_industryPartnerController.text),
        partnerId: widget.internshipWithPartner.partnerId,
        profilePic: widget.internshipWithPartner.profilePic,
        partnerName: widget.internshipWithPartner.partnerName,
        partnerLocation: widget.internshipWithPartner.partnerLocation,
        contactNo: widget.internshipWithPartner.contactNo,
        emailAdd: widget.internshipWithPartner.emailAdd,
      );

      if (kDebugMode) {
        debugPrint(jsonEncode(internshipData.toJson()));
      }

      try {
        await internshipApiService.updateInternship(internshipData);
        widget.onInternshipUpdated();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('WIL Opportunity updated successfully')));
        Navigator.pop(context, internshipData);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update internship: $error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update WIL Opportunity Posting'),
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
                                        ? _buildDesktopTopSection()
                                        : _buildMobileTopSection(),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: isDesktop
                                      ? _buildDesktopBottomSection()
                                      : _buildMobileBottomSection(),
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

  Widget _buildMobileTopSection() {
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
                      child:
                          widget.internshipWithPartner.displayPhoto.isNotEmpty
                              ? Image.network(
                                  'assets/images/${widget.internshipWithPartner.displayPhoto}',
                                  fit: BoxFit.contain,
                                )
                              : const Text(
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
                controller: _titleController,
                decoration: const InputDecoration(
                    hintText: 'Enter WIL Opportunity Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the internship title';
                  }
                  _titleController.text = value;
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
                controller: _descriptionController,
                decoration: const InputDecoration(
                    hintText: 'Enter the internship description'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the internship description';
                  }
                  _descriptionController.text = value;
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopTopSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column - Display Photo
          Expanded(
            flex: 1,
            child: Column(
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
                        child:
                            widget.internshipWithPartner.displayPhoto.isNotEmpty
                                ? Image.network(
                                    'assets/images/${widget.internshipWithPartner.displayPhoto}',
                                    fit: BoxFit.contain,
                                  )
                                : const Text(
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
                  controller: _titleController,
                  decoration: const InputDecoration(
                      hintText: 'Enter WIL Opportunity Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the internship title';
                    }
                    _titleController.text = value;
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
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      hintText: 'Enter the internship description'),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the internship description';
                    }
                    _descriptionController.text = value;
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

  Widget _buildMobileBottomSection() {
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
            value: _locationController.text,
            hint: Text('Select an option'),
            onChanged: (newValue) {
              setState(() {
                _locationController.text = newValue!;
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
                          return 'Please enter the required skill';
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
                          return 'Please enter the qualification';
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
            label: _hoursController.text,
            value: int.parse(_hoursController.text).toDouble(),
            onChanged: (value) {
              setState(() {
                _hoursController.text = value.round().toString();
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
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _takehomePayController.text,
            hint: Text('Select an option'),
            onChanged: (newValue) {
              setState(() {
                _takehomePayController.text = newValue!;
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

          // Save Changes Button
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              onPressed: _updateInternship,
              label: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopBottomSection() {
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
                    value: _locationController.text,
                    hint: Text('Select an option'),
                    onChanged: (newValue) {
                      setState(() {
                        _locationController.text = newValue!;
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
                                  return 'Please enter the required skill';
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
                                  return 'Please enter the qualification';
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
                    label: _hoursController.text,
                    value: int.parse(_hoursController.text).toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _hoursController.text = value.round().toString();
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
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _takehomePayController.text,
                    hint: Text('Select an option'),
                    onChanged: (newValue) {
                      setState(() {
                        _takehomePayController.text = newValue!;
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

        // Save Changes Button
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.save),
            onPressed: _updateInternship,
            label: const Text('Save Changes'),
          ),
        ),
      ],
    );
  }
}
