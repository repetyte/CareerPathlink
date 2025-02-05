
// Define the JobApplication class with job posting properties only
import 'package:intl/intl.dart';

class JobApplication {
  final int? applicationId;
  final String applicant;
  final int job;
  final String resume;
  final String coverLetter;
  final String skills;
  final String certifications;
  final String applicationStatus;
  final String dateApplied;

  // Constructor for job posting properties only
  JobApplication({
    this.applicationId,
    required this.applicant,
    required this.job,
    required this.resume,
    required this.coverLetter,
    required this.skills,
    required this.certifications,
    required this.applicationStatus,
    required this.dateApplied,
  });

  // Factory method for creating a Job Application from JSON
  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
      applicationId: json['application_id'] as int?,
      applicant: json['applicant'] ?? '',
      job: json['job'] as int? ?? 0,
      resume: json['resume'] ?? '',
      coverLetter: json['cover_letter'] ?? '',
      skills: json['skills'] ?? '',
      certifications: json['certifications'] ?? '',
      applicationStatus: json['application_status'] ?? '',
      dateApplied: json['date_applied'] ?? '',
    );
  }

  // Method to convert JobApplication to JSON
  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'applicant': applicant,
      'job': job,
      'resume': resume,
      'cover_letter': coverLetter,
      'skills': skills,
      'certifications': certifications,
      'application_status': applicationStatus,
      'date_applied': dateApplied,
    };
  }
}

// Define JobApplicationComplete class, extending JobApplication
class JobApplicationComplete extends JobApplication {
  // Properties for graduates_tb
  final String? graduateId;
  final String email;
  final String firstName;
  final String middleName;
  final String lastName;
  final String course;
  final String department;
  final DateTime bday;
  final String gender;
  final String age;
  final String address;
  final String contactNo;
  final DateTime dateGrad;
  final String empStat;
  final String userAccount;

  // Properties for job_posting_tb
  final int? jobId;
  final String coverPhoto;
  final String jobTitle;
  final String status;
  final String fieldIndustry;
  final String jobLevel;
  final String yrsOfExperienceNeeded;
  final String contractualStatus;
  final String salary;
  final String jobLocation;
  final String jobDescription;
  late final String requirements;
  late final String jobResponsibilities;
  final int industryPartner;

  // Constructor for job posting with industry partner properties
  JobApplicationComplete({
    // JobApplication properties
    super.applicationId,
    required super.applicant,
    required super.job,
    required super.resume,
    required super.coverLetter,
    required super.skills,
    required super.certifications,
    required super.applicationStatus,
    required super.dateApplied,

    // Graduates_tb properties
    this.graduateId,
    required this.email,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.course,
    required this.department,
    required this.bday,
    required this.gender,
    required this.age,
    required this.address,
    required this.contactNo,
    required this.dateGrad,
    required this.empStat,
    required this.userAccount,

    // Job_posting_tb properties
    this.jobId,
    required this.coverPhoto,
    required this.jobTitle,
    required this.status,
    required this.fieldIndustry,
    required this.jobLevel,
    required this.yrsOfExperienceNeeded,
    required this.contractualStatus,
    required this.salary,
    required this.jobLocation,
    required this.jobDescription,
    required this.requirements,
    required this.jobResponsibilities,
    required this.industryPartner,
  });

  // Factory method for creating JobApplicationComplete from JSON
  factory JobApplicationComplete.fromJson(Map<String, dynamic> json) {
    return JobApplicationComplete(
      // JobApplication properties
      applicationId: json['application_id'] as int?,
      applicant: json['applicant'] ?? '',
      job: json['job'] ?? 0,
      resume: json['resume'] ?? '',
      coverLetter: json['cover_letter'] ?? '',
      skills: json['skills'] ?? '',
      certifications: json['certifications'] ?? '',
      applicationStatus: json['application_status'] ?? '',
      dateApplied: json['date_applied'] ?? '',

      // Graduates_tb properties
      graduateId: json['graduate_id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      course: json['course'] ?? '',
      department: json['department'] ?? '',
      bday: json['bday'] != null ? DateFormat('yyyy-MM-dd').parse(json['bday']) : DateFormat('yyyy-MM-dd').parse('2000-01-01'),
      gender: json['gender'] ?? '',
      age: json['age'] ?? '',
      address: json['address'] ?? '',
      contactNo: json['contact_no'] ?? '',
      dateGrad: json['graduation_date'] != null ? DateTime.parse(json['graduation_date']) : DateTime.parse('2000-01-01'),
      empStat: json['employment_status'] ?? '',
      userAccount: json['user_account'] ?? '',

      // Job_posting_tb properties
      jobId: json['job_id'] as int? ?? 0,
      coverPhoto: json['cover_photo'] ?? '',
      jobTitle: json['job_title'] ?? '',
      status: json['status'] ?? '',
      fieldIndustry: json['field_industry'] ?? '',
      jobLevel: json['job_level'] ?? '',
      yrsOfExperienceNeeded: json['yrs_of_experience_needed'] ?? '',
      contractualStatus: json['contractual_status'],
      salary: json['salary'] ?? '',
      jobLocation: json['job_location'] ?? '',
      jobDescription: json['job_description'] ?? '',
      requirements: json['requirements'] ?? '',
      jobResponsibilities: json['job_responsibilities'] ?? '',
      industryPartner: json['industry_partner'] as int,
    );
  }

  // Method to convert JobApplicationComplete to JSON
  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      // Graduates_tb properties
      'graduate_id': graduateId,
      'email': email,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'course': course,
      'department': department,
      'bday': bday,
      'gender': gender,
      'age': age,
      'address': address,
      'contact_no': contactNo,
      'date_grad': dateGrad,
      'emp_stat': empStat,
      'user_account': userAccount,

      // Job_posting_tb properties
      'job_id': jobId,
      'cover_photo': coverPhoto,
      'job_title': jobTitle,
      'status': status,
      'field_industry': fieldIndustry,
      'job_level': jobLevel,
      'yrs_of_experience_needed': yrsOfExperienceNeeded,
      'contractual_status': contractualStatus,
      'salary': salary,
      'job_location': jobLocation,
      'job_description': jobDescription,
      'requirements': requirements,
      'job_responsibilities': jobResponsibilities,
      'industry_partner': industryPartner,
    });
    return json;
  }
}
