// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_app/models/career_coaching/student_profile_model.dart';
import 'package:flutter_app/pages/students_account/career_coaching/calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:unicons/unicons.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  // Personal Information variables
  bool _isLoadingStudent = true;
  bool _isEditing = false;
  Student? _student;

  // Variables for sessions
  List<Map<String, dynamic>> _upcomingSessions = [];
  List<Map<String, dynamic>> _pastSessions = [];
  bool _isLoadingSessions = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Profile Image
  File? _profileImage;

  Future<void> _pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Fetch the student profile data
  Future<void> _loadStudentData() async {
    try {
      final student = await ApiService.fetchStudent('19-42344');
      setState(() {
        _student = student;
        _isLoadingStudent = false;
        _nameController.text = student.name;
        _departmentController.text = student.department;
        _courseController.text = student.course;
        _levelController.text = student.level;
        _addressController.text = student.address;
        _contactController.text = student.contact;
        _emailController.text = student.email;
      });
    } catch (e) {
      print('Error loading student profile: $e');
      setState(() {
        _isLoadingStudent = false;
      });
    }
  }

  // Fetch the upcoming and past sessions
  Future<void> _loadSessions() async {
    try {
      final upcoming = await ApiService.fetchUpcomingSessions();
      final past = await ApiService.fetchPastSessions();

      setState(() {
        _upcomingSessions = upcoming;
        _pastSessions = past;
        _isLoadingSessions = false;
      });
    } catch (e) {
      print('Error loading sessions: $e');
      setState(() {
        _isLoadingSessions = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadStudentData();
    _loadSessions();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Profile',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 236, 235, 235),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _profileImage == null
                          ? null
                          : FileImage(_profileImage!),
                      child: _profileImage == null
                          ? const Icon(Icons.person,
                              size: 60, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 216, 216, 216),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _student?.name ?? 'Loading...',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            _showEditDialog(context);
                          },
                          child: Icon(
                            UniconsLine.edit,
                            size: 28,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _student?.course ?? 'Loading...',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Layout for Personal Information, Upcoming Session, and Past Session
            screenWidth > 600
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: buildInfoBlock(context, 'Personal Information'),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTextAndRectangle('Upcoming Session',
                                sessionList: _upcomingSessions),
                            const SizedBox(height: 20),
                            buildTextAndRectangle('Past Session',
                                sessionList: _pastSessions),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfoBlock(context, 'Personal Information'),
                      const SizedBox(height: 20),
                      buildTextAndRectangle('Upcoming Session',
                          sessionList: _upcomingSessions),
                      const SizedBox(height: 20),
                      buildTextAndRectangle('Past Session',
                          sessionList: _pastSessions),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  // Build personal information block
  Widget buildInfoBlock(BuildContext context, String title) {
    if (_isLoadingStudent) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Table(
            columnWidths: const {
              0: FixedColumnWidth(120),
              1: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              _buildTableRow('Student No:', _student?.studentNo ?? ''),
              _buildTableRow('Name:', _student?.name ?? ''),
              _buildTableRow('Department:', _student?.department ?? ''),
              _buildTableRow('Course:', _student?.course ?? ''),
              _buildTableRow('Level:', _student?.level ?? ''),
              _buildTableRow('Address:', _student?.address ?? ''),
              _buildTableRow('Contact:', _student?.contact ?? ''),
              _buildTableRow('Email:', _student?.email ?? ''),
              _buildTableRow('Password:', '********'),
            ],
          ),
        ],
      ),
    );
  }

  // Build a row for personal info
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    value,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  if (label == 'Password:')
                    GestureDetector(
                      onTap: () {
                        // Add your logic for changing the password
                        print('Change Password tapped');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Change Password?',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: const Color(0xFF3771C8),
                            decoration: TextDecoration.underline,
                            decorationColor: const Color(0xFF3771C8),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Build text and rectangle block for upcoming and past sessions
  Widget buildTextAndRectangle(String title,
      {List<Map<String, dynamic>>? sessionList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Align the title to the start of the rectangle container
        Padding(
          padding: const EdgeInsets.only(left: 20.0), // Align to the start
          child: Text(
            title,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: const Color(0xFFEC1D25), // Title color set to red
            ),
          ),
        ),
        const SizedBox(height: 10),
        sessionList != null && sessionList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sessionList.length,
                itemBuilder: (context, index) {
                  final sessionName =
                      sessionList[index]['session_name'] ?? 'Unknown Session';
                  final sessionDate =
                      sessionList[index]['session_date'] ?? 'Unknown Date';

                  // Determine whether the session is upcoming or completed
                  final sessionLabel = _getSessionLabel(sessionDate);
                  final formattedSessionDate = formatSessionDate(sessionDate);

                  // Wrap each session in a separate container (rectangle)
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sessionName,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$sessionLabel: $formattedSessionDate',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: const Color(0xFF7E8A8C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(child: Text('No sessions available')),
      ],
    );
  }

  // Helper function to determine whether the session is upcoming or completed
  String _getSessionLabel(String sessionDate) {
    final DateTime currentDate = DateTime.now();
    try {
      final DateTime sessionDateTime = DateTime.parse(sessionDate);

      // If the session date is in the future, it's an upcoming session
      if (sessionDateTime.isAfter(currentDate)) {
        return 'Next Session';
      } else {
        return 'Completed';
      }
    } catch (e) {
      return 'Invalid Date';
    }
  }

  // Helper function to format session date (e.g., convert from "YYYY-MM-DD" to "MM/DD/YYYY")
  String formatSessionDate(String date) {
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return '${parsedDate.month}/${parsedDate.day}/${parsedDate.year}'; // Example: 12/30/2024
    } catch (e) {
      return date; // Return as-is if date parsing fails
    }
  }

  // Function to show the edit dialog
  Future<void> _showEditDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Adjusted corner radius
          ),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            width: 500, // Set a fixed width for the dialog
            constraints: BoxConstraints(
                maxWidth: 600), // Max width to limit size on large screens
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Allow the dialog to shrink
                children: [
                  Text(
                    'Edit Information',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Text fields for editing user information
                  _buildTextField('Name', _nameController),
                  _buildTextField('Department', _departmentController),
                  _buildTextField('Course', _courseController),
                  _buildTextField('Level', _levelController),
                  _buildTextField('Address', _addressController),
                  _buildTextField('Contact No.', _contactController),
                  _buildTextField('Email', _emailController),

                  const SizedBox(height: 20),

                  // Buttons to Save or Cancel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog without saving
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _updateStudentProfile(); // This will call the API to update the student
                          Navigator.pop(
                              context); // Close the dialog after saving
                        },
                        child: Text('Update'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Helper function to create TextFields with a consistent design
  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFFEC1D25),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter $label",
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  // Method to handle updating the student profile
  void _updateStudentProfile() async {
    final updatedStudent = Student(
      studentNo: _student?.studentNo ??
          '', // Ensure you get the current student number
      name: _nameController.text,
      department: _departmentController.text,
      course: _courseController.text,
      level: _levelController.text,
      address: _addressController.text,
      contact: _contactController.text,
      email: _emailController.text,
      password: '', // You can handle password if needed
    );

    try {
      // Call the API to update the student profile
      await ApiService.updateStudent(updatedStudent);

      // Update the local student object with the updated values
      setState(() {
        _student = updatedStudent;
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      // Show an error message if the update fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile!')),
      );
    }
  }
}
