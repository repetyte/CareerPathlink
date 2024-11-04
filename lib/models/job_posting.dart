
class JobPosting {
  // Job Posting
  final int? jobId;
  final String? coverPhoto;
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

  // Referenced Industry Partner
  final int? partnerId;
  final String? profilePic;
  final String partnerName;
  final String partnerLocation;
  final String contactNo;
  final String emailAdd;

  JobPosting({
    // Job Posting
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

    // Referenced Industry Partner
    required this.partnerId, 
    required this.profilePic, 
    required this.partnerName, 
    required this.partnerLocation, 
    required this.contactNo, 
    required this.emailAdd,
  });

  factory JobPosting.fromJson(Map<String, dynamic> json) {
    return JobPosting(
      // Job Posting
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

      // Referenced Industry Partner
      partnerId: json['partner_id'] as int?,
      profilePic: json['profile_pic'],
      partnerName: json['partner_name'] ?? '',
      partnerLocation: json['partner_location'] ?? '',
      contactNo: json['contact_no'] ?? '',
      emailAdd: json['email_add'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // Job Posting
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

      // Referenced Industry Partner
      'partner_id': partnerId,
      'profile_pic': profilePic,
      'partner_name': partnerName,
      'partner_location': partnerLocation,
      'contact_no': contactNo,
      'email_add': emailAdd,
    };
  }
}
