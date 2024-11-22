import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:io'
    if (dart.library.html) 'dart:html'; // Platform-specific imports

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/industry_partner.dart';
import 'package:flutter_app/models/job_posting.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class RrAddJobPosting extends StatefulWidget {
  const RrAddJobPosting({super.key});

  @override
  _RrAddJobPostingState createState() => _RrAddJobPostingState();
}

class _RrAddJobPostingState extends State<RrAddJobPosting> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  // String? coverPhotoPath;
  Uint8List? _webImage;
  String _imageSource = ''; // Keeps track of the image source (path or URL)

  IndustryPartner? _selectedPartner;
  late Future<List<IndustryPartner>> futureIndustryPartners;

  String jobTitle = '';
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

  @override
  void initState() {
    super.initState();
    futureIndustryPartners = apiService.fetchIndustryPartners();

    final html.Element? body = html.document.body;
    if (body != null) {
      body.onDragOver.listen(_handleDragOver);
      body.onDrop.listen(_handleDrop);
    }
  }

  void _pickFromFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _webImage = result.files.first.bytes;
        _imageSource = result.files.first.name;
      });
    }
  }

  void _handleDragOver(html.MouseEvent event) {
    event.preventDefault();
  }

  void _handleDrop(html.MouseEvent event) async {
    event.preventDefault();
    final html.DataTransfer? dataTransfer = event.dataTransfer;
    if (dataTransfer != null && dataTransfer.files!.isNotEmpty) {
      final file = dataTransfer.files!.first;
      final reader = html.FileReader();

      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((_) {
        setState(() {
          _webImage = reader.result as Uint8List?;
          // coverPhotoPath = null; // Clear path if we're using bytes
          _imageSource = file.name;
        });
      });
    }
  }

  // void _pickImage() async {
  //   final picker = ImagePicker();
  //   final XFile? pickedFile =
  //       await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     if (kIsWeb) {
  //       final webImageBytes = await pickedFile.readAsBytes();
  //       setState(() {
  //         _webImage = webImageBytes;
  //         coverPhotoPath = null; // Clear path if we're using bytes
  //         _imageSource = 'Gallery';
  //       });
  //     } else {
  //       setState(() {
  //         coverPhotoPath = pickedFile.path;
  //         _webImage = null; // Clear bytes if we're using path
  //         _imageSource = pickedFile.path;
  //       });
  //     }
  //   }
  // }

  // another _pickImage method
  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final XFile? pickedFile =
  //       await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     if (kIsWeb) {
  //       final webImageBytes = await pickedFile.readAsBytes();
  //       setState(() {
  //         _webImage = webImageBytes;
  //         coverPhotoPath = null; // Not using file paths for web
  //       });
  //       if (kDebugMode) {
  //         print('Web image bytes: $webImageBytes');
  //       }
  //     } else {
  //       setState(() {
  //         coverPhotoPath = pickedFile.path; // Path is not valid for web
  //         _webImage = null;
  //       });
  //       if (kDebugMode) {
  //         print('Cover photo path: $coverPhotoPath');
  //       }
  //     }
  //   } else {
  //     if (kDebugMode) {
  //       print('No image selected.');
  //     }
  //   }
  // }

  // void _handleUrlInput(String url) async {
  //   try {
  //     final request =
  //         await html.HttpRequest.request(url, responseType: "arraybuffer");
  //     setState(() {
  //       _webImage = request.response as Uint8List?;
  //       coverPhotoPath = null; // Clear path if using URL
  //       _imageSource = url;
  //     });
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('Error loading image: $e'),
  //     ));
  //   }
  // }

  void _submitJobPosting() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedPartner == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please select an industry partner.')));
        return;
      }

      final jobPostingData = JobPosting(
        coverPhoto: _imageSource, // Use appropriate source
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

      if (_imageSource != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Image Source: $_imageSource")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No image selected")),
        );
      }

      try {
        await apiService.createJobPosting(jobPostingData);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Job added successfully')));
        Navigator.pop(context);
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
              // Cover Photo
              const Text(
                'Cover Photo:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: _pickFromFileExplorer,
                child: Column(
                    // width: double.infinity,
                    // height: 300,
                    // alignment: Alignment.center,
                    // child: _webImage != null
                    //     ? Image.memory(_webImage!) // For web-uploaded images
                    //     : coverPhotoPath != null
                    //         ? kIsWeb
                    //             ? Image.network(
                    //                 coverPhotoPath!) // Display images from URL if `coverPhotoPath` contains a URL
                    //             : const Text(
                    //                 'Invalid file path for the web.',
                    //                 style: TextStyle(color: Colors.red),
                    //               )
                    //         : const Text(
                    //             'Drag and drop an image here\nor tap to select',
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(color: Colors.grey),
                    //           ),
                    children: [
                      if (_webImage != null)
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child:
                              Image.memory(_webImage!, fit: BoxFit.contain),
                        ),
                      if (_webImage == null)
                        Container(
                          height: 200,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: const Text(
                              "Drag and drop an image or click to select"),
                        ),
                    ]),
              ),
              const SizedBox(height: 16.0),
              // TextField(
              //   decoration: const InputDecoration(
              //     labelText: 'Enter Image URL',
              //     border: OutlineInputBorder(),
              //   ),
              //   onSubmitted: _handleUrlInput,
              // ),
              // const SizedBox(height: 32.0),

              // Job Title
              const Text(
                'Job Title:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                // decoration: const InputDecoration(labelText: 'Job Title'),
                decoration: const InputDecoration(hintText: 'Enter Job Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                items: ['Open', 'Closed'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),

              // Field/Industry
              const Text(
                'Field/Industry:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                items: ['Entry Level', 'Mid-level', 'Senior Level']
                    .map((String value) {
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                items: ['Full-time', 'Part-time', 'Contractual']
                    .map((String value) {
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                // decoration: const InputDecoration(labelText: 'Job Location'),
                decoration:
                    const InputDecoration(hintText: 'Enter the job location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job location';
                  }
                  jobLocation = value;
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Job Description
              const Text(
                'Job Description:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                // decoration: const InputDecoration(labelText: 'Job Description'),
                decoration: const InputDecoration(
                    hintText: 'Enter the job description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                // decoration: const InputDecoration(labelText: 'Requirements'),
                decoration: const InputDecoration(
                    hintText: 'Enter the job requirements'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job requirements';
                  }
                  requirements = value;
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Job Responsibilities
              const Text(
                'Job Responsibilities:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                // decoration:
                //     const InputDecoration(labelText: 'Job Responsibilities'),
                decoration: const InputDecoration(
                    hintText: 'Enter the job responsibilities'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job responsibilities';
                  }
                  jobResponsibilities = value;
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // About Employer
              const Text(
                'About Employer:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              FutureBuilder<List<IndustryPartner>>(
                future: futureIndustryPartners,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No industry partners available."),
                    );
                  } else {
                    List<IndustryPartner> partners = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: partners.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(partners[index].partnerName),
                          subtitle: Text(
                              '${partners[index].partnerLocation}\n${partners[index].emailAdd}'),
                          onTap: () {
                            setState(() {
                              _selectedPartner = partners[index];
                            });
                          },
                          selected: _selectedPartner == partners[index],
                          selectedTileColor: Colors.grey[200],
                        );
                      },
                    );
                  }
                },
              ),

              // Submit Button
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _submitJobPosting,
                  child: const Text('Post Job'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
