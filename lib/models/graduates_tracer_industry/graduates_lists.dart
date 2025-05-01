class GraduatesList {
  final String? studentNo;
  final String lastName;
  final String firstName;
  final String middleName;
  final String birthdate;
  final int age;
  final String homeAddress;
  final String uncEmail;
  final String personalEmail;
  final String facebookName;
  final String graduationDate;
  final String course;
  final String department;
  final String firstTargetEmployer;
  final String secondTargetEmployer;
  final String thirdTargetEmployer;

  // Constructor
  GraduatesList({
    required this.studentNo,
    required this.lastName,
    required this.firstName,
    required this.middleName,
    required this.birthdate,
    required this.age,
    required this.homeAddress,
    required this.uncEmail,
    required this.personalEmail,
    required this.facebookName,
    required this.graduationDate,
    required this.course,
    required this.department,
    required this.firstTargetEmployer,
    required this.secondTargetEmployer,
    required this.thirdTargetEmployer,
  });

  // Factory method for creating a GraduatesList object from JSON
  factory GraduatesList.fromJson(Map<String, dynamic> json) {
    return GraduatesList(
      studentNo: json['student_no'] ?? '',
      lastName: json['last_name'] ?? '',
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      birthdate: json['birthdate'] ?? '',
      age: json['age'] as int,
      homeAddress: json['home_address'] ?? '',
      uncEmail: json['unc_email'] ?? '',
      personalEmail: json['personal_email'] ?? '',
      facebookName: json['facebook_name'] ?? '',
      graduationDate: json['graduation_date'] ?? '',
      course: json['course'] ?? '',
      department: json['department'] ?? '',
      firstTargetEmployer: json['1st_target_employer'] ?? '',
      secondTargetEmployer: json['2nd_target_employer'] ?? '',
      thirdTargetEmployer: json['3rd_target_employer'] ?? '',
    );
  }

  // Method to convert GraduatesList object to JSON
  Map<String, dynamic> toJson() {
    return {
      'student_no': studentNo,
      'last_name': lastName,
      'first_name': firstName,
      'middle_name': middleName,
      'birthdate': birthdate,
      'age': age,
      'home_address': homeAddress,
      'unc_email': uncEmail,
      'personal_email': personalEmail,
      'facebook_name': facebookName,
      'graduation_date': graduationDate,
      'course': course,
      'department': department,
      '1st_target_employer': firstTargetEmployer,
      '2nd_target_employer': secondTargetEmployer,
      '3rd_target_employer': thirdTargetEmployer,
    };
  }
}