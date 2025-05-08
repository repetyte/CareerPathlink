import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/career_coaching/student_notification_model.dart';

class NotificationService {
  static const String _baseUrl =
      'http://localhost/CareerPathlink/api/career_coaching/student_notifications';

  // Get all notifications for a user
  static Future<List<StudentNotification>> fetchAll(String userId) async {
    try {
      if (userId.isEmpty) {
        throw Exception('User ID cannot be empty');
      }

      final url =
          'http://localhost/CareerPathlink/api/career_coaching/student_notifications/get_notifications.php?user_id=${Uri.encodeComponent(userId)}';

      debugPrint('Fetching notifications for user ID: $userId');
      debugPrint('URL: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      ).timeout(Duration(seconds: 10));

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] != true) {
          throw Exception(responseData['error'] ?? 'API request failed');
        }

        final List<dynamic> data = responseData['data'];
        debugPrint('Fetched ${data.length} notifications');

        return data.map((json) {
          try {
            return StudentNotification.fromJson(json);
          } catch (e) {
            debugPrint('Error parsing notification: $e');
            debugPrint('Problematic JSON: $json');
            throw Exception('Failed to parse notification: $e');
          }
        }).toList();
      } else {
        throw Exception('HTTP Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error in fetchAll: $e');
      rethrow;
    }
  }

  // Get unread notifications count
  static Future<int> getUnreadCount(String userId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost/CareerPathlink/api/career_coaching/student_notifications/get_notification_count.php?user_id=$userId'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return responseData['count'] ?? 0;
        } else {
          throw Exception(
              responseData['error'] ?? 'Failed to get unread count');
        }
      } else {
        throw Exception('Failed to get unread count: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting unread count: $e');
    }
  }

  // Create a new notification
  static Future<StudentNotification> create(
    Map<String, dynamic> notificationData,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://localhost/CareerPathlink/api/career_coaching/student_notifications/create_notification.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(notificationData),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return StudentNotification.fromJson({
            ...notificationData,
            'id': responseData['id'],
            'status': 'Unread',
            'created_at': DateTime.now().toIso8601String(),
          });
        } else {
          throw Exception(
              responseData['error'] ?? 'Failed to create notification');
        }
      } else {
        throw Exception(
            'Failed to create notification: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating notification: $e');
    }
  }

  // Update notification status
  // student_notifications_service.dart
  static Future<void> updateStatus(int id, String newStatus) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/update_notification.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': id,
          'status': newStatus,
        }),
      );

      if (response.statusCode != 200) {
        final responseData = json.decode(response.body);
        throw Exception(
            responseData['error'] ?? 'Failed to update notification status');
      }
    } catch (e) {
      debugPrint('Error updating notification status: $e');
      rethrow;
    }
  }

  // Delete a notification
  static Future<void> delete(int id) async {
    try {
      final response = await http.delete(
        Uri.parse(
            'http://localhost/CareerPathlink/api/career_coaching/student_notifications/delete_notification.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': id}),
      );

      if (response.statusCode != 200) {
        final responseData = json.decode(response.body);
        throw Exception(
            responseData['error'] ?? 'Failed to delete notification');
      }
    } catch (e) {
      throw Exception('Error deleting notification: $e');
    }
  }
}
