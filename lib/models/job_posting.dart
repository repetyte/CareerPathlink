class JobPosting {
  final int? jobId;
  final String jobTitle;
  final String jobStatus;
  final String fieldIndustry;
  final String jobLevel;
  final String yrsOfExperienceNeeded;
  final String contractualStatus;
  final String salary;
  final String jobLocation;
  final String jobDescription;
  final String requirements;
  final String jobResponsibilities;
  final String industryPartner;

  JobPosting({
    this.jobId,
    required this.jobTitle,
    required this.jobStatus,
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

  factory JobPosting.fromJson(Map<String, dynamic> json) {
    return JobPosting(
      jobId: json['job_id'],
      jobTitle: json['job_title'],
      jobStatus: json['status'],
      fieldIndustry: json['field_industry'],
      jobLevel: json['job_level'],
      yrsOfExperienceNeeded: json['yrs_of_experience_needed'],
      contractualStatus: json['contractual_status'],
      salary: json['salary'],
      jobLocation: json['job_location'],
      jobDescription: json['job_description'],
      requirements: json['requirements'],
      jobResponsibilities: json['job_responsibilities'],
      industryPartner: json['industry_partner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
      'job_title': jobTitle,
      'status': jobStatus,
      'field_industry': fieldIndustry,
      'job_level': jobLevel,
      'yrs_of_experience_needed': yrsOfExperienceNeeded,
      'contractual_status': contractualStatus,
      'salary': salary,
      'job_location': jobLocation,
      'job_description': jobDescription,
      'requirements': requirements,
      'job_responsibilities': jobResponsibilities,
      'industry_partner': industryPartner
    };
  }
}

// 1. Naming Conventions: Use camelCase for variable names.

