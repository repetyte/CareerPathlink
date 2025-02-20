// Define the UnemployedLists class with properties corresponding to the database table
class UnemployedLists {
  final int? studentNo;
  final String? lastName;
  final String? firstName;
  final String? middleName;
  final DateTime? birthdate;
  final int? age;
  final String? homeAddress;
  final String? personalEmail;
  final String? facebookName;
  final String? course;
  final DateTime? graduationDate;
  final String? yourJobBefore; // Previous job field
  final String? reasonOfUnemployment; // Reason for unemployment field
  final bool? boardPasser; // Board passer field
  final String? targetNextJobTitle; // Target next job title field
  final double? targetSalary; // Target salary field

  // Constructor
  UnemployedLists({
    this.studentNo,
    this.lastName,
    this.firstName,
    this.middleName,
    this.birthdate,
    this.age,
    this.homeAddress,
    this.personalEmail,
    this.facebookName,
    this.course,
    this.graduationDate,
    this.yourJobBefore,
    this.reasonOfUnemployment,
    this.boardPasser,
    this.targetNextJobTitle,
    this.targetSalary,
  });

  // Factory method for creating an UnemployedLists object from JSON
  factory UnemployedLists.fromJson(Map<String, dynamic> json) {
    return UnemployedLists(
      studentNo: json['student_no'] as int?,
      lastName: json['last_name'] as String?,
      firstName: json['first_name'] as String?,
      middleName: json['middle_name'] as String?,
      birthdate: json['birthdate'] != null ? DateTime.parse(json['birthdate']) : null,
      age: json['age'] as int?,
      homeAddress: json['home_address'] as String?,
      personalEmail: json['personal_email'] as String?,
      facebookName: json['facebook_name'] as String?,
      course: json['course'] as String?,
      graduationDate: json['graduation_date'] != null ? DateTime.parse(json['graduation_date']) : null,
      yourJobBefore: json['your_job_before'] as String?,
      reasonOfUnemployment: json['reason_of_unemployment'] as String?,
      boardPasser: json['board_passer?'] == 1,
      targetNextJobTitle: json['target_next_jobtitle'] as String?,
      targetSalary: json['target_salary'] != null ? double.parse(json['target_salary']) : null,
    );
  }

  // Method to convert UnemployedLists object to JSON
  Map<String, dynamic> toJson() {
    return {
      'student_no': studentNo,
      'last_name': lastName,
      'first_name': firstName,
      'middle_name': middleName,
      'birthdate': birthdate?.toIso8601String(),
      'age': age,
      'home_address': homeAddress,
      'personal_email': personalEmail,
      'facebook_name': facebookName,
      'course': course,
      'graduation_date': graduationDate?.toIso8601String(),
      'your_job_before': yourJobBefore,
      'reason_of_unemployment': reasonOfUnemployment,
      'board_passer?': boardPasser == true ? 1 : 0,
      'target_next_jobtitle': targetNextJobTitle,
      'target_salary': targetSalary,
    };
  }
}
