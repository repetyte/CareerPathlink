import 'dart:typed_data';

// Define the JobPosting class with job posting properties only
class JobPosting {
  final int? jobId;
  final Uint8List? coverPhoto;
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

  // Constructor for job posting properties only
  JobPosting({
    this.jobId,
    this.coverPhoto,
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
  });

  // Factory method for creating a JobPosting from JSON
  factory JobPosting.fromJson(Map<String, dynamic> json) {
    return JobPosting(
      jobId: json['job_id'] as int?,
      coverPhoto: json['cover_photo'],
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
    );
  }

  // Method to convert JobPosting to JSON
  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}

// Define JobPostingWithPartner class, extending JobPosting
class JobPostingWithPartner extends JobPosting {
  final int? partnerId;
  final Uint8List? profilePic;
  final String? partnerName;
  final String? partnerLocation;
  final String? contactNo;
  final String? emailAdd;

  // Constructor for job posting with industry partner properties
  JobPostingWithPartner({
    int? jobId,
    Uint8List? coverPhoto,
    required String jobTitle,
    required String status,
    required String fieldIndustry,
    required String jobLevel,
    required String yrsOfExperienceNeeded,
    required String contractualStatus,
    required String salary,
    required String jobLocation,
    required String jobDescription,
    required String requirements,
    required String jobResponsibilities,
    this.partnerId,
    this.profilePic,
    this.partnerName,
    this.partnerLocation,
    this.contactNo,
    this.emailAdd,
  }) : super(
          jobId: jobId,
          coverPhoto: coverPhoto,
          jobTitle: jobTitle,
          status: status,
          fieldIndustry: fieldIndustry,
          jobLevel: jobLevel,
          yrsOfExperienceNeeded: yrsOfExperienceNeeded,
          contractualStatus: contractualStatus,
          salary: salary,
          jobLocation: jobLocation,
          jobDescription: jobDescription,
          requirements: requirements,
          jobResponsibilities: jobResponsibilities,
        );

  // Factory method for creating JobPostingWithPartner from JSON
  factory JobPostingWithPartner.fromJson(Map<String, dynamic> json) {
    return JobPostingWithPartner(
      jobId: json['job_id'] as int?,
      coverPhoto: json['cover_photo'],
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
      partnerId: json['partner_id'] as int?,
      profilePic: json['profile_pic'],
      partnerName: json['partner_name'] ?? '',
      partnerLocation: json['partner_location'] ?? '',
      contactNo: json['contact_no'] ?? '',
      emailAdd: json['email_add'] ?? '',
    );
  }

  // Method to convert JobPostingWithPartner to JSON
  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'partner_id': partnerId,
      'profile_pic': profilePic,
      'partner_name': partnerName,
      'partner_location': partnerLocation,
      'contact_no': contactNo,
      'email_add': emailAdd,
    });
    return json;
  }
}
