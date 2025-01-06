class CompletedAppointment {
  final int completedId;
  final String name;
  final String programRequest;
  final String dateRequest;
  final String timeRequest;
  final String email;
  final String phoneNo;
  final String studentNo;
  final String gender;
  final String yearLevel;
  final String department;

  CompletedAppointment({
    required this.completedId,
    required this.name,
    required this.programRequest,
    required this.dateRequest,
    required this.timeRequest,
    required this.email,
    required this.phoneNo,
    required this.studentNo,
    required this.gender,
    required this.yearLevel,
    required this.department,
  });

  // fromJson constructor
  factory CompletedAppointment.fromJson(Map<String, dynamic> json) {
    return CompletedAppointment(
      completedId: json['completed_id'],
      name: json['name'],
      programRequest: json['program_request'],
      dateRequest: json['date_request'],
      timeRequest: json['time_request'],
      email: json['email'],
      phoneNo: json['phone_no'],
      studentNo: json['student_no'],
      gender: json['gender'],
      yearLevel: json['year_level'],
      department: json['department'],
    );
  }
}
