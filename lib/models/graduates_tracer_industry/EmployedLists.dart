// Define the EmployedLists class with properties corresponding to the database table
class EmployedLists {
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
  final String? employerName; // Employer name field
  final String? position; // Job position field
  final DateTime? startDate; // Start date field

  // Constructor
  EmployedLists({
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
    this.employerName,
    this.position,
    this.startDate,
  });

  // Factory method for creating an EmployedLists object from JSON
  factory EmployedLists.fromJson(Map<String, dynamic> json) {
    return EmployedLists(
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
      employerName: json['employer_name'] as String?, // Parse employer name
      position: json['position'] as String?, // Parse job position
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : null, // Parse start date
    );
  }

  // Method to convert EmployedLists object to JSON
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
      'employer_name': employerName, // Include employer name in JSON
      'position': position, // Include job position in JSON
      'start_date': startDate?.toIso8601String(), // Include start date in JSON
    };
  }
}
