
// Define the InternshipApplication class with internship posting properties only
import 'package:intl/intl.dart';

class InternshipApplication {
  final int? applicationId;
  final String applicant;
  final int internship;
  final String resume;
  final String coverLetter;
  final String skills;
  final String certifications;
  final String applicationStatus;
  final String dateApplied;

  // Constructor for internship posting properties only
  InternshipApplication({
    this.applicationId,
    required this.applicant,
    required this.internship,
    required this.resume,
    required this.coverLetter,
    required this.skills,
    required this.certifications,
    this.applicationStatus = 'Pending',
    required this.dateApplied,
  });

  // Factory method for creating a Internship Application from JSON
  factory InternshipApplication.fromJson(Map<String, dynamic> json) {
    return InternshipApplication(
      applicationId: json['application_id'] as int?,
      applicant: json['applicant'] ?? '',
      internship: json['internship'] as int? ?? 0,
      resume: json['resume'] ?? '',
      coverLetter: json['cover_letter'] ?? '',
      skills: json['skills'] ?? '',
      certifications: json['certifications'] ?? '',
      applicationStatus: json['application_status'] ?? '',
      dateApplied: json['date_applied'] ?? '',
    );
  }

  // Method to convert InternshipApplication to JSON
  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'applicant': applicant,
      'internship': internship,
      'resume': resume,
      'cover_letter': coverLetter,
      'skills': skills,
      'certifications': certifications,
      'application_status': applicationStatus,
      'date_applied': dateApplied,
    };
  }
}

// Define InternshipApplicationComplete class, extending InternshipApplication
class InternshipApplicationComplete extends InternshipApplication {
  // Properties for graduates_tb
  final String? studentId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String course;
  final String department;
  final String contactNo;
  final DateTime bday;
  final String gender;
  final String age;
  final String address;
  final String userAccount;

  // Properties for internship_posting_tb
  final int? internshipId;
  final String displayPhoto;
  final String internshipTitle;
  final String hours;
  final String takehomePay;
  final String location;
  final String description;
  final String requiredSkills;
  final String qualifications;
  final int? industryPartner;

  // Constructor for internship posting with industry partner properties
  InternshipApplicationComplete({
    super.applicationId,
    required super.applicant,
    required super.internship,
    required super.resume,
    required super.coverLetter,
    required super.skills,
    required super.certifications,
    required super.applicationStatus,
    required super.dateApplied,

    // Graduates_tb properties
    this.studentId,
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
    required this.address,
    required this.userAccount,

    //Internship_posting_tb properties
    this.internshipId,
    required this.displayPhoto,
    required this.internshipTitle,
    required this.hours,
    required this.takehomePay,
    required this.location,
    required this.description,
    required this.requiredSkills,
    required this.qualifications,
    required this.industryPartner,
  });

  // Factory method for creating InternshipApplicationComplete from JSON
  factory InternshipApplicationComplete.fromJson(Map<String, dynamic> json) {
    return InternshipApplicationComplete(
      applicationId: json['application_id'] as int?,
      applicant: json['applicant'] ?? '',
      internship: json['internship'] ?? 0,
      resume: json['resume'] ?? '',
      coverLetter: json['cover_letter'] ?? '',
      skills: json['skills'] ?? '',
      certifications: json['certifications'] ?? '',
      applicationStatus: json['application_status'] ?? '',
      dateApplied: json['date_applied'] ?? '',

      // Graduates_tb properties
      studentId: json['student_id'] as String?,
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      course: json['course'] ?? '',
      department: json['department'] ?? '',
      contactNo: json['contact_no'] ?? '',
      bday: json['bday'] != null ? DateFormat('yyyy-MM-dd').parse(json['bday']) : DateFormat('yyyy-MM-dd').parse('2000-01-01'),
      gender: json['gender'],
      age: json['age'],
      address: json['address'],
      userAccount: json['user_account'],

      // Internship_posting_tb properties
      internshipId: json['internship_id'] as int?,
      displayPhoto: json['display_photo'],
      internshipTitle: json['internship_title'],
      hours: json['hours'],
      takehomePay: json['takehome_pay'],
      location: json['location'],
      description: json['description'],
      requiredSkills: json['required_skills'],
      qualifications: json['qualifications'],
      industryPartner: json['industry_partner'] as int,
    );
  }

  // Method to convert InternshipApplicationComplete to JSON
  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      // Graduates_tb properties
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
      'user_account': userAccount,

      // Internship_posting_tb properties
      'internship_id': internshipId,
      'display_photo': displayPhoto,
      'internship_title': internshipTitle,
      'hours': hours,
      'takehome_pay': takehomePay,
      'location': location,
      'description': description,
      'required_skills': requiredSkills,
      'qualifications': qualifications,
      'industry_partner': industryPartner,
    });
    return json;
  }
}
