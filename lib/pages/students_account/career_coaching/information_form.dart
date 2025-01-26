import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_role/student.dart';
import 'package:flutter_app/pages/students_account/career_coaching/calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'booking_confirmation.dart';
import '../../../widgets/footer/footer.dart';
import '../../../widgets/appbar/student_header.dart';
import '../student_home_screen.dart';
import 'package:flutter/services.dart';

class StudentInformationScreen extends StatefulWidget {
  final StudentAccount studentAccount;
  final String coach;
  final String dateTime;

  const StudentInformationScreen({super.key, required this.coach, required this.dateTime, required this.studentAccount});

  @override
  _StudentInformationScreenState createState() =>
      _StudentInformationScreenState();
}

class _StudentInformationScreenState extends State<StudentInformationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form data variables
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController suffixController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController studentNoController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  String? gender;
  String? yearLevel;
  String? department;
  String? programInterest;
  int? programId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill out your Information'),   
      ),
      body: Column(
        children: [// Header stays fixed at the top

          // Divider with shadow below the header
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(
              thickness: 0,
              color: const Color.fromARGB(255, 209, 208, 208),
            ),
          ),

          // Add the "Personal Information" text
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Personal Information",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Wrap the form part in a SingleChildScrollView
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Row for Last Name and Suffix
                                Row(
                                  children: [
                                    // Last Name field
                                    Expanded(
                                      flex: 1,
                                      child: _buildTextField(
                                        "Last Name",
                                        controller: lastNameController,
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    // Suffix field
                                    Expanded(
                                      flex: 1,
                                      child: _buildTextField(
                                        "Suffix",
                                        controller: suffixController,
                                        hintText: "(Optional)",
                                        isSuffixField:
                                            true, // Allow this field to be empty
                                      ),
                                    ),
                                  ],
                                ),

                                _buildTextField('First Name',
                                    controller: firstNameController),
                                _buildTextField('Middle Name',
                                    controller: middleNameController),
                                _buildTextField('Email',
                                    controller: emailController),

                                // Row for Phone Number and Student Number
                                Row(
                                  children: [
                                    // Phone Number field
                                    Expanded(
                                      flex: 1,
                                      child: _buildTextField(
                                        'Phone no:',
                                        hintText: "09XXXXXXXXXX",
                                        controller: phoneNoController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(11),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    // Student Number field
                                    Expanded(
                                      flex: 1,
                                      child: _buildTextField(
                                        'Student no:',
                                        hintText:
                                            "00-00000", // Format hint with 8 characters (including hyphen)
                                        controller: studentNoController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                          StudentNumberFormatter(), // Custom formatter to handle hyphen
                                          LengthLimitingTextInputFormatter(
                                              8), // Limit total length to 8 characters (including hyphen)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                // Row for Date of Birth and Gender
                                Row(
                                  children: [
                                    // Date of Birth field
                                    Expanded(
                                      flex: 1,
                                      child: _buildDateField(
                                        'Date of Birth',
                                        hintText: "Select Date",
                                        controller: dateOfBirthController,
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    // Gender field
                                    Expanded(
                                      flex: 1,
                                      child: _buildDropdown(
                                        'Gender',
                                        ['Male', 'Female'],
                                        onChanged: (value) => gender = value,
                                      ),
                                    ),
                                  ],
                                ),

                                // Row for Year Level and Department
                                Row(
                                  children: [
                                    // Year Level dropdown
                                    Expanded(
                                      flex: 1,
                                      child: _buildDropdown(
                                        'Year Level',
                                        [
                                          '1st Year',
                                          '2nd Year',
                                          '3rd Year',
                                          '4th Year',
                                          '5th Year'
                                        ],
                                        onChanged: (value) => yearLevel = value,
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    // Department dropdown
                                    Expanded(
                                      flex: 1,
                                      child: _buildDropdown(
                                        'Department',
                                        [
                                          'Arts & Sciences',
                                          'Business & Accountancy',
                                          'Computer Studies',
                                          'Criminal Justice Education',
                                          'Education',
                                          'Engineering & Architecture',
                                          'Nursing'
                                        ],
                                        onChanged: (value) =>
                                            department = value,
                                      ),
                                    ),
                                  ],
                                ),

                                _buildDropdown(
                                  'Program Interest',
                                  [
                                    'Career Coaching',
                                    'Mock Interview',
                                    'Mentoring',
                                    'Cv Review'
                                  ],
                                  onChanged: (value) {
                                    programInterest = value;
                                    switch (value) {
                                      case 'Career Coaching':
                                        programId = 1;
                                        break;
                                      case 'Mock Interview':
                                        programId = 2;
                                        break;
                                      case 'Mentoring':
                                        programId = 3;
                                        break;
                                      case 'Cv Review':
                                        programId = 4;
                                        break;
                                      default:
                                        programId = null;
                                    }
                                  },
                                ),

                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .end, // Align buttons to the end
                                  children: [
                                    // Cancel Button
                                    ElevatedButton(
                                      onPressed: () {
                                        // Show confirmation dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Confirm Cancel"),
                                              content: Text(
                                                "Are you sure you want to cancel?",
                                              ),
                                              actions: [
                                                // No Button
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context); // Close the dialog without navigating
                                                  },
                                                  child: Text("No"),
                                                ),
                                                // Yes Button - Navigate to HomeScreenStudent
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context); // Close the confirmation dialog
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreenStudent(studentAccount: widget.studentAccount,)), // Navigate to HomeScreenStudent
                                                    );
                                                  },
                                                  child: Text("Yes"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF9F9F9F),
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                        width:
                                            8), // Add a small space between the buttons

                                    // Book Button
                                    ElevatedButton(
                                      onPressed: _submitForm,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFFF0000),
                                      ),
                                      child: Text(
                                        "Book",
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label,
      {TextEditingController? controller,
      TextInputType keyboardType = TextInputType.text,
      String? hintText,
      List<TextInputFormatter>? inputFormatters,
      bool isSuffixField = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text at the top of the text field
          Text(
            label,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500, // Medium weight
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4.0),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hintText ?? 'Enter $label',
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.red), // Set border color to red
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.red), // Border color when not focused
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.red), // Border color when focused
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            ),
            validator: (value) {
              if (!isSuffixField && (value == null || value.isEmpty)) {
                return 'Please enter $label';
              }

              // Email-specific validation
              if (label == 'Email' &&
                  value != null &&
                  value.isNotEmpty &&
                  !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                return 'Please enter a valid email address';
              }

              // Phone number-specific validation
              if (label == 'Phone no:' &&
                  value != null &&
                  value.isNotEmpty &&
                  !RegExp(r'^09\d{9}$').hasMatch(value)) {
                return 'Please enter a valid phone number';
              }

              // Student number-specific validation (must be exactly 8 characters including the hyphen)
              if (label == 'Student no:' &&
                  value != null &&
                  value.isNotEmpty &&
                  value.length != 8) {
                return 'Please enter a valid Student number with 8 characters, including the hyphen.';
              }

              return null; // Validation passed
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label,
      {TextEditingController? controller, required String hintText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4.0),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(
                Icons.calendar_today,
                color: const Color.fromARGB(255, 72, 72, 72),
                size: 20,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (selectedDate != null) {
                setState(() {
                  controller!.text = "${selectedDate.toLocal()}".split(' ')[0];
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  int getYearLevelInt(String? yearLevel) {
    switch (yearLevel) {
      case '1st Year':
        return 1;
      case '2nd Year':
        return 2;
      case '3rd Year':
        return 3;
      case '4th Year':
        return 4;
      case '5th Year':
        return 5;
      default:
        return 0;
    }
  }

  Widget _buildDropdown(String label, List<String> items,
      {required Function(String?) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4.0),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: 'Select $label',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            ),
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (value) {
              onChanged(value);
              setState(() {}); // Update the UI with the selected value
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return; // If form validation fails, exit.
    }

    // Prepare appointment data (same as before)
    final appointmentData = {
      'coach_id': 1,
      'slot_id': 1,
      'last_name': lastNameController.text,
      'suffix': suffixController.text,
      'first_name': firstNameController.text,
      'middle_name': middleNameController.text,
      'email': emailController.text,
      'phone_no': phoneNoController.text,
      'student_no': studentNoController.text,
      'date_of_birth': dateOfBirthController.text,
      'gender': gender ??
          '', // Ensure this has the selected value (e.g., "Male" or "Female")
      'year_level': yearLevel ?? '',
      'department':
          department ?? '', // Ensure this has the correct department value
      'program_id': programId,
    };

    try {
      // Call the ApiService to add the appointment
      await ApiService.addAppointment(appointmentData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment successfully added')),
      );

      // Navigate to Booking Confirmation after the form is submitted
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookingConfirmationScreen(
            coach: widget.coach,
            dateTime: widget.dateTime, studentAccount: widget.studentAccount,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add appointment')),
      );
    }
  }
}

// Formatter for student number to automatically insert a hyphen after the first two digits
class StudentNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll('-', '');
    if (newText.length > 2) {
      newText = '${newText.substring(0, 2)}-${newText.substring(2)}';
    }
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
