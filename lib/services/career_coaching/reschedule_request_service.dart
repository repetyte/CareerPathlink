import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/career_coaching/student_request_reschedule_model.dart';

class RescheduleRequestService {
  static Future<bool> hasPendingReschedule(int appointmentId) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/CareerPathlink/api/career_coaching/student_request_reschedule/read_reschedule.php?appointment_id=$appointmentId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.any((request) => request['status'] == 'Pending');
      }
      return false;
    } catch (e) {
      print('Error checking reschedule status: $e');
      return false;
    }
  }

  static Future<bool> hasAcceptedReschedule(int appointmentId) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/CareerPathlink/api/career_coaching/student_request_reschedule/read_reschedule.php?appointment_id=$appointmentId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.any((request) => request['status'] == 'Accepted');
      }
      return false;
    } catch (e) {
      print('Error checking accepted reschedule: $e');
      return false;
    }
  }

  static Future<RescheduleRequest?> getPendingRequest(int appointmentId) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/CareerPathlink/api/career_coaching/student_request_reschedule/read_reschedule.php?appointment_id=$appointmentId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final pendingRequests = data.where((request) => request['status'] == 'Pending').toList();
        if (pendingRequests.isNotEmpty) {
          return RescheduleRequest.fromJson(pendingRequests.first);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching pending request: $e');
      return null;
    }
  }

  static Future<List<RescheduleRequest>> getRescheduleRequestsByAppointment(int appointmentId) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/CareerPathlink/api/career_coaching/student_request_reschedule/read_reschedule.php?appointment_id=$appointmentId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => RescheduleRequest.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching reschedule requests: $e');
      return [];
    }
  }
}