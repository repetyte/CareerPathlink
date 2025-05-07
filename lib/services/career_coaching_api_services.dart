// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_app/models/user_role/coach_model.dart';
// import 'package:flutter_app/models/career_coaching/in_process_appointment_model.dart';
// import 'package:flutter_app/models/career_coaching/pending_model.dart';
// import 'package:flutter_app/models/user_role/student.dart';
// import 'package:flutter_app/pages/students_account/career_coaching/calendar_ver2.dart';
// import 'package:http/http.dart' as http;
// // ignore: unused_import


// class ApiService {
//   static const String baseUrl = 'http://localhost/CareerPathlink/api/api';

//   static Future<List<Coach>> fetchCoaches() async {
//     final response = await http
//         .get(Uri.parse('http://localhost/CareerPathlink/api/career_coaching/get_coaches.php'));
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       return data.map((json) => Coach.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load coaches');
//     }
//   }

//   // Upload CV
//   static Future<bool> uploadCV(
//       String studentNo, List<int> fileBytes, String fileName) async {
//     try {
//       var uri = Uri.parse('http://localhost/CareerPathlink/api/career_coaching/upload_cv.php');
//       var request = http.MultipartRequest('POST', uri);

//       // Add fields
//       request.fields['student_no'] = studentNo;

//       // Add file as bytes
//       request.files.add(
//         http.MultipartFile.fromBytes(
//           'file',
//           fileBytes,
//           filename: fileName,
//         ),
//       );

//       // Send request
//       var response = await request.send();

//       debugPrint(
//           "Response status: ${response.statusCode}"); // Debug log for status code

//       if (response.statusCode == 200) {
//         var responseData = await response.stream.bytesToString();
//         debugPrint("Response data: $responseData"); // Debug log for response

//         try {
//           var json = jsonDecode(responseData);
//           if (json['success'] == true) {
//             debugPrint("Upload successful: ${json['uploaded_at']}"); // Debugging log
//             return true;
//           } else {
//             debugPrint("Upload failed: ${json['message']}"); // Debugging log
//             return false;
//           }
//         } catch (e) {
//           debugPrint('Error parsing JSON: $e');
//           debugPrint('Response data: $responseData'); // Debugging log
//           return false;
//         }
//       } else {
//         debugPrint('Server returned status code: ${response.statusCode}');
//         return false;
//       }
//     } catch (e) {
//       debugPrint('Error: $e');
//       return false;
//     }
//   }

//   // Fetch the list of available slots based on the selected coach_id
//   static Future<List<Slot>> fetchAvailableSlots(int coachId) async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'http://localhost/CareerPathlink/api/career_coaching/get_slots.php?coach_id=$coachId'),
//       );

//       if (response.statusCode == 200) {
//         debugPrint('Response: ${response.body}'); // Debugging the API response
//         List<dynamic> data = jsonDecode(response.body);
//         return data.map((json) => Slot.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load available slots');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // Add appointment (POST)
//   static Future<void> addAppointment(
//       Map<String, dynamic> appointmentData) async {
//     final response = await http.post(
//       Uri.parse('http://localhost/CareerPathlink/api/career_coaching/add_appointment.php'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(appointmentData),
//     );

//     // Debugging: Print the raw response
//     debugPrint('Response status: ${response.statusCode}');
//     debugPrint('Response body: ${response.body}');

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       if (data['status'] == 'success') {
//         final appointmentId = data['appointment_id']; // Get the ID
//         debugPrint("Appointment added successfully with ID: $appointmentId");

//         // Optionally, you can return the ID for further use in your app
//       } else {
//         debugPrint("Error: ${data['message']}");
//         throw Exception('Failed to add appointment: ${data['message']}');
//       }
//     } else {
//       debugPrint("Error: ${response.statusCode} - ${response.body}");
//       throw Exception('Failed to add appointment');
//     }
//   }

//   // Fetch upcoming sessions
//   static Future<List<Map<String, dynamic>>> fetchUpcomingSessions() async {
//     final response =
//         await http.get(Uri.parse('$baseUrl/get_upcoming_sessions.php'));

//     if (response.statusCode == 200) {
//       debugPrint(
//           'Upcoming Sessions Response: ${response.body}'); // Print the response body for debugging
//       var decodedResponse = jsonDecode(response.body);
//       if (decodedResponse is Map && decodedResponse.containsKey('data')) {
//         List<dynamic> data = decodedResponse['data'];
//         return data.map((json) => Map<String, dynamic>.from(json)).toList();
//       } else {
//         throw Exception('Unexpected response format');
//       }
//     } else {
//       throw Exception('Failed to load upcoming sessions');
//     }
//   }

//   // Fetch past sessions
//   static Future<List<Map<String, dynamic>>> fetchPastSessions() async {
//     final response =
//         await http.get(Uri.parse('$baseUrl/get_past_sessions.php'));

//     if (response.statusCode == 200) {
//       debugPrint(
//           'Past Sessions Response: ${response.body}'); // Print the response body for debugging
//       var decodedResponse = jsonDecode(response.body);
//       if (decodedResponse is Map && decodedResponse.containsKey('data')) {
//         List<dynamic> data = decodedResponse['data'];
//         return data.map((json) => Map<String, dynamic>.from(json)).toList();
//       } else {
//         throw Exception('Unexpected response format');
//       }
//     } else {
//       throw Exception('Failed to load past sessions');
//     }
//   }

//   static Future<Student> fetchStudent(String studentNo) async {
//     final response = await http.get(
//       Uri.parse(
//           'http://localhost/CareerPathlink/api/career_coaching/get_student_profile.php?student_no=$studentNo'),
//     );

//     if (response.statusCode == 200) {
//       return Student.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load student data');
//     }
//   }

//   //Update student Profile
//   static Future<void> updateStudent(Student student) async {
//     final response = await http.post(
//       Uri.parse('http://localhost/CareerPathlink/api/career_coaching/update_student_profile.php'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(student.toJson()), // Send student data in JSON format
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to update student data');
//     }
//   }

// // Fetch student insight  from the API
//   static Future<List<Map<String, dynamic>>> fetchGenderDistribution() async {
//     try {
//       final response = await http
//           .get(Uri.parse(
//               'http://localhost/CareerPathlink/api/career_coaching/read_student_insight.php'))
//           .timeout(const Duration(seconds: 10), onTimeout: () {
//         throw Exception('Request timeout');
//       });

//       if (response.statusCode == 200) {
//         var decodedResponse = jsonDecode(response.body);

//         if (decodedResponse is Map && decodedResponse.containsKey('data')) {
//           List<dynamic> data = decodedResponse['data'];
//           return data.map((json) => Map<String, dynamic>.from(json)).toList();
//         } else {
//           throw Exception('Unexpected response format: Missing data key');
//         }
//       } else {
//         throw Exception(
//             'Failed to load gender distribution. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error fetching gender distribution: $e');
//       throw Exception('Error fetching gender distribution: $e');
//     }
//   }

//   // Fetch year level insights from the API
//   static Future<List<Map<String, dynamic>>> fetchYearLevelInsights() async {
//     try {
//       final response = await http.get(
//           Uri.parse('http://localhost/CareerPathlink/api/career_coaching/read_year_levels.php'));

//       if (response.statusCode == 200) {
//         debugPrint('Year Levels Response: ${response.body}'); // Debugging log
//         var decodedResponse = jsonDecode(response.body);

//         // Check if the response contains data
//         if (decodedResponse is Map && decodedResponse.containsKey('data')) {
//           List<dynamic> data = decodedResponse['data'];
//           return data.map((json) => Map<String, dynamic>.from(json)).toList();
//         } else {
//           throw Exception('Unexpected response format: Missing data key');
//         }
//       } else {
//         throw Exception(
//             'Failed to load year level insights. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error fetching year level insights: $e');
//       throw Exception('Error fetching year level insights: $e');
//     }
//   }

// // Fetch service details
//   Future<List<Map<String, dynamic>>> fetchServiceDetails() async {
//     final response = await http.get(
//       Uri.parse(
//           'http://localhost/CareerPathlink/api/career_coaching/read_service_details.php'), // Correct URL here
//     );

//     if (response.statusCode == 200) {
//       var decodedResponse = jsonDecode(response.body);
//       if (decodedResponse is Map && decodedResponse.containsKey('data')) {
//         return List<Map<String, dynamic>>.from(decodedResponse['data']);
//       } else {
//         throw Exception('Unexpected response format: Missing data key');
//       }
//     } else {
//       throw Exception(
//           'Failed to load service details. Status code: ${response.statusCode}');
//     }
//   }

//   // Fetch department data from read_department.php
//   static Future<List<Map<String, dynamic>>> fetchDepartmentData() async {
//     try {
//       final response = await http.get(
//           Uri.parse('http://localhost/CareerPathlink/api/career_coaching/read_department.php'));

//       if (response.statusCode == 200) {
//         var decodedResponse = jsonDecode(response.body);

//         // Check if the response contains the data key
//         if (decodedResponse is Map && decodedResponse.containsKey('data')) {
//           List<dynamic> data = decodedResponse['data'];
//           return data.map((json) => Map<String, dynamic>.from(json)).toList();
//         } else {
//           throw Exception('Unexpected response format: Missing data key');
//         }
//       } else {
//         throw Exception(
//             'Failed to load department data. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error fetching department data: $e');
//       throw Exception('Error fetching department data: $e');
//     }
//   }

// // fetch pending appointments
//   static Future<List<PendingAppointment>> fetchPendingAppointments() async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'http://localhost/CareerPathlink/api/career_coaching/read_pending.php'), // Make sure this URL is correct
//       );

//       debugPrint('Response Status: ${response.statusCode}');
//       debugPrint('Response Body: ${response.body}');

//       if (response.statusCode == 200) {
//         var decodedResponse = jsonDecode(response.body);

//         // Check if response is valid and contains data
//         if (decodedResponse is Map && decodedResponse.containsKey('data')) {
//           List<dynamic> data = decodedResponse['data'];

//           // Return parsed list of PendingAppointment objects
//           return data.map((json) => PendingAppointment.fromJson(json)).toList();
//         } else {
//           throw Exception('Unexpected response format: Missing data key');
//         }
//       } else {
//         throw Exception(
//             'Failed to load pending appointments. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error fetching pending appointments: $e');
//       throw Exception('Error fetching pending appointments: $e');
//     }
//   }

//   // Fetch in-process appointments
//   static Future<List<InProcessAppointment>> fetchInProcessAppointments() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://localhost/CareerPathlink/api/career_coaching/read_in_process.php'),
//       );

//       if (response.statusCode == 200) {
//         var decodedResponse = jsonDecode(response.body);

//         if (decodedResponse is Map && decodedResponse.containsKey('data')) {
//           List<dynamic> data = decodedResponse['data'];
//           return data
//               .map((json) => InProcessAppointment.fromJson(json))
//               .toList();
//         } else {
//           throw Exception('Unexpected response format: Missing data key');
//         }
//       } else {
//         throw Exception(
//             'Failed to load in-process appointments. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error fetching in-process appointments: $e');
//       throw Exception('Error fetching in-process appointments: $e');
//     }
//   }

//   static Future<bool> updateStatus(int id, String status) async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://localhost/CareerPathlink/api/career_coaching/update_status.php'),
//         body: {'id': id.toString(), 'status': status},
//       );

//       final decodedResponse = jsonDecode(response.body);
//       if (decodedResponse['status'] == 'success') {
//         return true;
//       } else {
//         throw Exception(decodedResponse['message'] ?? 'Unknown error');
//       }
//     } catch (e) {
//       debugPrint('Error updating status: $e');
//       return false;
//     }
//   }

//   // Fetch completed appointments
//   static Future<List<Map<String, dynamic>>> fetchCompletedAppointments() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://localhost/CareerPathlink/api/career_coaching/read_completed.php'),
//       );

//       if (response.statusCode == 200) {
//         var decodedResponse = jsonDecode(response.body);

//         if (decodedResponse is Map && decodedResponse.containsKey('data')) {
//           List<dynamic> data = decodedResponse['data'];
//           return data.map((json) => Map<String, dynamic>.from(json)).toList();
//         } else {
//           throw Exception('Unexpected response format: Missing data key');
//         }
//       } else {
//         throw Exception(
//             'Failed to load completed appointments. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Error fetching completed appointments: $e');
//       throw Exception('Error fetching completed appointments: $e');
//     }
//   }

//   static updateStudentProfile(Student updatedStudent) {}

//   static void changePassword(String currentPassword, String newPassword) {}

//   static sendPasswordResetEmail(String email) {}

//   static sendResetPasswordEmail(String email) {}
// }
