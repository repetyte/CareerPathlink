// Define the GraduatesList class with properties corresponding to the database table
class GraduatesList {
  final String? studentNo;
  final String lastName;
  final String firstName;
  final String middleName;
  final DateTime birthdate;
  final int age;
  final String homeAddress;
  final String uncEmail;
  final String personalEmail;
  final String facebookName;
  final DateTime graduationDate; // Added graduation date property
  final String course;
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
    required this.graduationDate, // Include graduation date in the constructor
    required this.course,
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
      birthdate: json['birthdate'] != null
          ? DateTime.parse(json['birthdate'])
          : DateTime.now(),
      age: json['age'] as int,
      homeAddress: json['home_address'] ?? '',
      uncEmail: json['unc_email'] ?? '',
      personalEmail: json['personal_email'] ?? '',
      facebookName: json['facebook_name'] ?? '',
      graduationDate: json['graduation_date'] != null
          ? DateTime.parse(json['graduation_date'])
          : DateTime.now(), // Parse graduation date
      course: json['course'] ?? '',
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
      'birthdate':
          birthdate.toIso8601String().split('T')[0], // Convert to 'YYYY-MM-DD'
      'age': age,
      'home_address': homeAddress,
      'unc_email': uncEmail,
      'personal_email': personalEmail,
      'facebook_name': facebookName,
      'graduation_date': graduationDate
          .toIso8601String()
          .split('T')[0], // Convert to 'YYYY-MM-DD'
      'course': course,
      '1st_target_employer': firstTargetEmployer,
      '2nd_target_employer': secondTargetEmployer,
      '3rd_target_employer': thirdTargetEmployer,
    };
  }
}
