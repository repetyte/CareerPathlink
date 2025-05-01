class Student {
  String? studentId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String course;
  final String department;
  final String contactNo;
  final String bday;
  final String gender;
  final int age;
  final String address;

  Student(
      {this.studentId,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.email,
      required this.course,
      required this.department,
      required this.contactNo,
      required this.bday,
      required this.gender,
      required this.age,
      required this.address});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['student_id'] ?? '',
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      course: json['course'] ?? '',
      department: json['department'] ?? '',
      contactNo: json['contact_no'] ?? '',
      bday: json['bday'] ?? '',
      gender: json['gender'] ?? '',
      age: json['age'] as int,
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'email': email,
      'course': course,
      'department': department,
      'contact_no': contactNo,
      'bday': bday,
      'gender': gender,
      'age': age,
      'address': address,
    };
  }
}

class StudentAccount extends Student {
  String? accountId;
  final String username;
  final String password;
  String? resume;
  String? skills;
  String? certifications;

  StudentAccount({
    super.studentId,
    required super.firstName,
    required super.middleName,
    required super.lastName,
    required super.email,
    required super.course,
    required super.department,
    required super.contactNo,
    required super.bday,
    required super.gender,
    required super.age,
    required super.address,
    this.accountId,
    required this.username,
    required this.password,
    this.resume,
    this.skills,
    this.certifications,
  });

  factory StudentAccount.fromJson(Map<String, dynamic> json) {
    return StudentAccount(
      studentId: json['student_id'] ?? '',
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      course: json['course'] ?? '',
      department: json['department'] ?? '',
      contactNo: json['contact_no'] ?? '',
      bday: json['bday'] ?? '',
      gender: json['gender'] ?? '',
      age: json['age'] as int,
      address: json['address'] ?? '',
      accountId: json['account_id'] ?? '',
      username: json['username'] ?? '', 
      password: json['password'] ?? '',
      resume: json['resume'] ?? '',
      skills: json['skills'] ?? '',
      certifications: json['certifications'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'account_id': accountId,
      'username': username,
      'password': password,
      'resume': resume,
      'skills': skills,
      'certifications': certifications,
    });
    return json;
  }
}
