class Appointment {
  final int id;
  final String studentName;
  final String dateRequested;
  final String timeRequested;
  final String profileImageUrl;
  final String serviceType;
  final int? coachId;

  Appointment({
    required this.id,
    required this.studentName,
    required this.dateRequested,
    required this.timeRequested,
    required this.profileImageUrl,
    required this.serviceType,
    this.coachId,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: int.parse(json['id']),
      studentName: json['student_name'],
      dateRequested: json['date_requested'],
      timeRequested: json['time_requested'],
      profileImageUrl:
          json['profile_image_url'] ?? 'https://via.placeholder.com/150',
      serviceType: json['service_type'] ?? 'Unknown Service',
      coachId:
          json['coach_id'] != null ? int.parse(json['coach_id']) : null,
    );
  }

  get studentId => null;

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "student_name": studentName,
      "date_requested": dateRequested,
      "time_requested": timeRequested,
      "profile_image_url": profileImageUrl,
      "service_type": serviceType,
      "coach_id": coachId?.toString(),
    };
  }
}
