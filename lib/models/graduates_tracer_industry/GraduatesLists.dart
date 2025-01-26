// Define the GraduatesList class with properties corresponding to the database table
class GraduatesList {
  final int? studentNo;
  final String? lastName;
  final String? firstName;
  final String? middleName;
  final DateTime? birthdate;
  final int? age;
  final String? homeAddress;
  final String? uncEmail;
  final String? personalEmail;
  final String? facebookName;
  final String? course;
  final String? firstTargetEmployer;
  final String? secondTargetEmployer;
  final String? thirdTargetEmployer;
  final DateTime? graduationDate; // Added graduation date property

  // Constructor
  GraduatesList({
    this.studentNo,
    this.lastName,
    this.firstName,
    this.middleName,
    this.birthdate,
    this.age,
    this.homeAddress,
    this.uncEmail,
    this.personalEmail,
    this.facebookName,
    this.course,
    this.firstTargetEmployer,
    this.secondTargetEmployer,
    this.thirdTargetEmployer,
    this.graduationDate, // Include graduation date in the constructor
  });

  // Factory method for creating a GraduatesList object from JSON
  factory GraduatesList.fromJson(Map<String, dynamic> json) {
    return GraduatesList(
      studentNo: json['student_no'] as int?,
      lastName: json['last_name'] as String?,
      firstName: json['first_name'] as String?,
      middleName: json['middle_name'] as String?,
      birthdate: json['birthdate'] != null ? DateTime.parse(json['birthdate']) : null,
      age: json['age'] as int?,
      homeAddress: json['home_address'] as String?,
      uncEmail: json['unc_email'] as String?,
      personalEmail: json['personal_email'] as String?,
      facebookName: json['facebook_name'] as String?,
      course: json['course'] as String?,
      firstTargetEmployer: json['1st_target_employer'] as String?,
      secondTargetEmployer: json['2nd_target_employer'] as String?,
      thirdTargetEmployer: json['3rd_target_employer'] as String?,
      graduationDate: json['graduation_date'] != null ? DateTime.parse(json['graduation_date']) : null, // Parse graduation date
    );
  }

  // Method to convert GraduatesList object to JSON
  Map<String, dynamic> toJson() {
    return {
      'student_no': studentNo,
      'last_name': lastName,
      'first_name': firstName,
      'middle_name': middleName,
      'birthdate': birthdate?.toIso8601String(),
      'age': age,
      'home_address': homeAddress,
      'unc_email': uncEmail,
      'personal_email': personalEmail,
      'facebook_name': facebookName,
      'course': course,
      '1st_target_employer': firstTargetEmployer,
      '2nd_target_employer': secondTargetEmployer,
      '3rd_target_employer': thirdTargetEmployer,
      'graduation_date': graduationDate?.toIso8601String(), // Include graduation date in JSON
    };
  }
}
