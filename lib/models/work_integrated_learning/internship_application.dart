
// Define the InternshipApplication class with internship posting properties only

class InternshipApplication {
  int? applicationId;
  final int internship;
  final String applicantFirstName;
  final String applicantLastName;
  final String course;
  final String applicantLocation;
  final String applicantContactNo;
  final String applicantEmail;
  String? resume;
  String? coverLetter;
  String? skills;
  String? certifications;
  final String applicationStatus;
  final String dateApplied;

  // Constructor for internship posting properties only
  InternshipApplication({
    this.applicationId,
    required this.internship,
    required this.applicantFirstName,
    required this.applicantLastName,
    required this.course,
    required this.applicantLocation,
    required this.applicantContactNo,
    required this.applicantEmail,
    this.resume,
    this.coverLetter,
    this.skills,
    this.certifications,
    this.applicationStatus = 'Pending',
    required this.dateApplied,
  });

  // Factory method for creating a WIL Opportunity Application from JSON
  factory InternshipApplication.fromJson(Map<String, dynamic> json) {
    return InternshipApplication(
      applicationId: json['application_id'] as int?,
      internship: json['internship'] as int? ?? 0,
      applicantFirstName: json['applicant_first_name'] ?? '',
      applicantLastName: json['applicant_last_name'] ?? '',
      course: json['course'] ?? '',
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

  // Method to convert InternshipApplication to JSON
  Map<String, dynamic> toJson() {
    return {
      'application_id': applicationId,
      'internship': internship,
      'applicant_first_name': applicantFirstName,
      'applicant_last_name': applicantLastName,
      'course': course,
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

// Define InternshipApplicationComplete class, extending InternshipApplication
class InternshipApplicationComplete extends InternshipApplication {
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
    required super.internship,
    required super.applicantFirstName,
    required super.applicantLastName,
    required super.course,
    required super.applicantLocation,
    required super.applicantContactNo,
    required super.applicantEmail,
    required super.resume,
    required super.coverLetter,
    required super.skills,
    required super.certifications,
    required super.applicationStatus,
    required super.dateApplied,

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
      internship: json['internship'] ?? 0,
      applicantFirstName: json['applicant_first_name'] ?? '',
      applicantLastName: json['applicant_last_name'] ?? '',
      course: json['course'] ?? '',
      applicantLocation: json['applicant_location'] ?? '',
      applicantContactNo: json['applicant_contact_no'] ?? '',
      applicantEmail: json['applicant_email'] ?? '',
      resume: json['resume'] ?? '',
      coverLetter: json['cover_letter'] ?? '',
      skills: json['skills'] ?? '',
      certifications: json['certifications'] ?? '',
      applicationStatus: json['application_status'] ?? '',
      dateApplied: json['date_applied'] ?? '',

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
