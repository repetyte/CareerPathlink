
// Define the JobApplication class with job posting properties only

class JobApplication {
  final int? applicationId;
  final int job;
  final String applicantFirstName;
  final String applicantLastName;
  final String applicantLocation;
  final String applicantContactNo;
  final String applicantEmail;
  final String resume;
  final String coverLetter;
  final String skills;
  final String certifications;
  final String applicationStatus;
  final String dateApplied;

  // Constructor for job posting properties only
  JobApplication({
    this.applicationId,
    required this.job,
    required this.applicantFirstName,
    required this.applicantLastName,
    required this.applicantLocation,
    required this.applicantContactNo,
    required this.applicantEmail,
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
      job: json['job'] as int? ?? 0,
      applicantFirstName: json['applicant_first_name'] ?? '',
      applicantLastName: json['applicant_last_name'] ?? '',
      applicantLocation: json['applicant_location'] ?? '',
      applicantContactNo: json['applicant_contact_no'] ?? '',
      applicantEmail: json['applicant_email'] ?? '',
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
      'job': job,
      'applicant_first_name': applicantFirstName,
      'applicant_last_name': applicantLastName,
      'applicant_location': applicantLocation,
      'applicant_contact_no': applicantContactNo,
      'applicant_email': applicantEmail,
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
    required super.job,
    required super.applicantFirstName,
    required super.applicantLastName,
    required super.applicantLocation,
    required super.applicantContactNo,
    required super.applicantEmail,
    required super.resume,
    required super.coverLetter,
    required super.skills,
    required super.certifications,
    required super.applicationStatus,
    required super.dateApplied,

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
      job: json['job'] ?? 0,
      applicantFirstName: json['applicant_first_name'] ?? '',
      applicantLastName: json['applicant_last_name'] ?? '',
      applicantLocation: json['applicant_location'] ?? '',
      applicantContactNo: json['applicant_contact_no'] ?? '',
      applicantEmail: json['applicant_email'] ?? '',
      resume: json['resume'] ?? '',
      coverLetter: json['cover_letter'] ?? '',
      skills: json['skills'] ?? '',
      certifications: json['certifications'] ?? '',
      applicationStatus: json['application_status'] ?? '',
      dateApplied: json['date_applied'] ?? '',

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
