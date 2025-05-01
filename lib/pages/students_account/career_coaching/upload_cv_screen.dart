// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_app/models/user_role/student.dart';
import 'package:flutter_app/pages/students_account/career_coaching/calendar.dart';
import 'dart:convert';
import '../student_home_screen.dart'; // Ensure to import your HomeScreenStudent here

class UploadCVScreen extends StatefulWidget {
  final StudentAccount studentAccount;
  const UploadCVScreen({super.key, required this.studentAccount});

  @override
  _UploadCVScreenState createState() => _UploadCVScreenState();
}

class _UploadCVScreenState extends State<UploadCVScreen> {
  String? _fileName;
  List<int>? _fileBytes;

  // Method to handle file picking
  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, // Custom file types
        allowedExtensions: [
          'pdf',
          'doc',
          'docx',
        ], // Only these file types allowed
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _fileName = result.files.single.name; // Store selected file name
          _fileBytes = result.files.single.bytes;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No file selected')),
        );
      }
    } catch (e) {
      debugPrint("Error picking file: $e");
    }
  }

  // Action for the upload button
  void _uploadCV() async {
    if (_fileBytes != null && _fileName != null) {
      String studentNo = "1"; // Use the correct student number
      bool success =
          await ApiService.uploadCV(studentNo, _fileBytes!, _fileName!);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('CV uploaded successfully!')),
        );
        // Navigate to HomeScreenStudent after successful upload
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomeScreenStudent(studentAccount: widget.studentAccount,)), // Navigate to HomeScreenStudent
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('CV upload failed! Please try again later.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a file first!')),
      );
    }
  }

  // Action for the cancel button
  void _cancelAction() {
    setState(() {
      _fileName = null;
      _fileBytes = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Action Cancelled')),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Submit Your CV', // App title
          style: TextStyle(
            fontFamily: 'Montserrat', // Matching font style from SubmitCVScreen
            color: Colors.black, // Set text color to black
          ),
        ),
        backgroundColor: Colors.white, // Set background color to white
        foregroundColor: Colors.black, // Set title color to black
      ),
      body: Center(
        // Center the entire content of the screen
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // File upload container and buttons in the same row
              LayoutBuilder(
                builder: (context, constraints) {
                  // Check if the screen width is small (mobile devices)
                  bool isMobile = constraints.maxWidth < 600;

                  return Column(
                    children: [
                      // Left side: Rectangle for file upload
                      Container(
                        width: isMobile
                            ? screenWidth * 0.9
                            : screenWidth *
                                0.45, // Adjust width based on screen size
                        height: screenHeight *
                            0.35, // Adjust height to be proportional
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: _pickFile, // Trigger file picker
                              child: Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Select File',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (_fileName != null)
                              Text(
                                'Selected: $_fileName',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                ),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Buttons: Cancel and Upload CV
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Cancel Button
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: isMobile
                                  ? screenWidth * 0.4
                                  : screenWidth * 0.2,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextButton(
                                onPressed: _cancelAction,
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Upload CV Button
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: isMobile
                                  ? screenWidth * 0.4
                                  : screenWidth * 0.2,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF0000),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextButton(
                                onPressed: _uploadCV,
                                child: const Text(
                                  'Upload CV',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
