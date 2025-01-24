class Student1 {
  final String studentNo;
  final String name;
  final String department;
  final String course;
  final String level;
  final String address;
  final String contact;
  final String email;
  late final String password;

  Student1({
    required this.studentNo,
    required this.name,
    required this.department,
    required this.course,
    required this.level,
    required this.address,
    required this.contact,
    required this.email,
    required this.password,
  });

  factory Student1.fromJson(Map<String, dynamic> json) {
    return Student1(
      studentNo: json['student_no'],
      name: json['name'],
      department: json['department'],
      course: json['course'],
      level: json['level'],
      address: json['address'],
      contact: json['contact'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_no': studentNo,
      'name': name,
      'department': department,
      'course': course,
      'level': level,
      'address': address,
      'contact': contact,
      'email': email,
      'password': password,
    };
  }
}
