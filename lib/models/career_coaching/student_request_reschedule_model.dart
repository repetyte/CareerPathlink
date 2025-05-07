class RescheduleRequest {
  final int id;
  final int appointmentId;
  final String studentName;
  final String dateRequest;
  final String timeRequest;
  final String message;
  final String serviceType; // Add this field


  RescheduleRequest({
    required this.id,
    required this.appointmentId,
    required this.studentName,
    required this.dateRequest,
    required this.timeRequest,
    required this.message,
    required this.serviceType, // Add this to constructor
  });

  // Factory method to create a RescheduleRequest from JSON
  factory RescheduleRequest.fromJson(Map<String, dynamic> json) {
    return RescheduleRequest(
      id: int.parse(json['id']),
      appointmentId: int.parse(json['appointment_id']),
      studentName: json['student_name'],
      dateRequest: json['date_request'],
      timeRequest: json['time_request'],
      message: json['message'],
      serviceType: json['service_type']?.toString() ?? 'Unknown', // Add this
    );
  }

  get status => null;

  // Method to convert RescheduleRequest to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "appointment_id": appointmentId.toString(),
      "student_name": studentName,
      "date_request": dateRequest,
      "time_request": timeRequest,
      "message": message,
    };
  }
}