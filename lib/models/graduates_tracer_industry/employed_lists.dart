// Define the EmployedLists class with properties corresponding to the database table
class EmployedLists {
  final int? employedGradId;
  final String graduate;
  final String jobTitle;
  final String companyName;
  final String companyAddress;
  final String position;
  final DateTime startDate; // Start date field
  final String basicSalary; // End date field

  // Constructor
  EmployedLists({
    this.employedGradId,
    required this.graduate,
    required this.jobTitle,
    required this.companyName,
    required this.companyAddress,
    required this.position,
    required this.startDate,
    required this.basicSalary,
  });

  // Factory method for creating an EmployedLists object from JSON
  factory EmployedLists.fromJson(Map<String, dynamic> json) {
    return EmployedLists(
      employedGradId: json['employed_grad_id'],
      graduate: json['graduate'],
      jobTitle: json['job_title'],
      companyName: json['company_name'],
      companyAddress: json['company_address'],
      position: json['position'],
      startDate: DateTime.parse(json['start_date']),
      basicSalary: json['basic_salary'],
    );
  }

  // Method to convert EmployedLists object to JSON
  Map<String, dynamic> toJson() {
    return {
      'employed_grad_id': employedGradId,
      'graduate': graduate,
      'job_title': jobTitle,
      'company_name': companyName,
      'company_address': companyAddress,
      'position': position,
      'start_date': startDate.toIso8601String(),
      'basic_salary': basicSalary,
    };
  }
}

class EmployedListWithGraduate extends EmployedLists{
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

  EmployedListWithGraduate({
    super.employedGradId,
    required super.graduate,
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
    required super.jobTitle,
    required super.companyName,
    required super.companyAddress,
    required super.position,
    required super.startDate,
    required super.basicSalary,
  });

  factory EmployedListWithGraduate.fromJson(Map<String, dynamic> json) {
    return EmployedListWithGraduate(
      employedGradId: json['employed_grad_id'],
      graduate: json['graduate'],
      studentNo: json['student_no'],
      lastName: json['last_name'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      birthdate: json['birthdate'],
      age: json['age'],
      homeAddress: json['home_address'],
      uncEmail: json['unc_email'],
      personalEmail: json['personal_email'],
      facebookName: json['facebook_name'],
      graduationDate: json['graduation_date'],
      course: json['course'],
      department: json['department'],
      firstTargetEmployer: json['1st_target_employer'],
      secondTargetEmployer: json['2nd_target_employer'],
      thirdTargetEmployer: json['3rd_target_employer'],
      jobTitle: json['job_title'],
      companyName: json['company_name'],
      companyAddress: json['company_address'],
      position: json['position'],
      startDate: DateTime.parse(json['start_date']),
      basicSalary: json['basic_salary'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
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
    });
    return json;
  }
}
