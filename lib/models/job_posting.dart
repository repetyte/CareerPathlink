import 'package:flutter_app/models/industry_partner.dart';

class JobPosting {
  final int? jobId;
  final String jobTitle;
  final String status;
  final String fieldIndustry;
  final String jobLevel;
  final String yrsOfExperienceNeeded;
  final String contractualStatus;
  final String salary;
  final String jobLocation;
  final String jobDescription;
  final String requirements;
  final String jobResponsibilities;
  final String? coverPhoto;
  final IndustryPartner industryPartner;

  JobPosting({
    this.jobId,
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
    this.coverPhoto,
    required this.industryPartner,
  });

  factory JobPosting.fromJson(Map<String, dynamic> json) {
    return JobPosting(
      jobId: json['job_id'],
      jobTitle: json['job_title'] ?? '',
      status: json['status'] ?? '',
      fieldIndustry: json['field_industry'] ?? '',
      jobLevel: json['job_level'] ?? '',
      yrsOfExperienceNeeded: json['yrs_of_experience_needed'] ?? '',
      contractualStatus: json['contractual_status'] ?? '',
      salary: json['salary'] ?? '',
      jobLocation: json['job_location'] ?? '',
      jobDescription: json['job_description'] ?? '',
      requirements: json['requirements'] ?? '',
      jobResponsibilities: json['job_responsibilities'] ?? '',
      coverPhoto: json['cover_photo'],
      industryPartner: IndustryPartner.fromJson({
        'partner_id': json['partner_id'],
        'profile_pic': json['profile_pic'],
        'partner_name': json['partner_name'],
        'partner_location': json['partner_location'],
        'contact_no': json['contact_no'],
        'email_add': json['email_add'],
      }),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
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
      'cover_photo': coverPhoto,
      'industry_partner': industryPartner
    };
  }
}
