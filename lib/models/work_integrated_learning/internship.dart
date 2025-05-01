// ignore_for_file: public_member_api_docs, sort_constructors_first
class Internship {
  final int? internshipId;
  final String displayPhoto;
  final String internshipTitle;
  final String takehomePay;
  final String location;
  final String description;
  final String requiredSkills;
  final String qualifications;
  final String hours;
  final int? industryPartner;

  Internship( {
    this.internshipId,
    required this.displayPhoto,
    required this.internshipTitle,
    required this.takehomePay, 
    required this.location,
    required this.description,
    required this.requiredSkills,
    required this.qualifications,
    required this.hours,
    this.industryPartner,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      internshipId: json['internship_id'] as int?,
      displayPhoto: json['display_photo'],
      internshipTitle: json['internship_title'] ?? '',
      takehomePay: json['takehome_pay'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      requiredSkills: json['required_skills'] ?? '',
      qualifications: json['qualifications'] ?? '',
      hours: json['hours'] ?? '',
      industryPartner: json['industry_partner'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'internship_id': internshipId,
      'display_photo': displayPhoto,
      'internship_title': internshipTitle,
      'takehome_pay': takehomePay,
      'location': location,
      'description': description,
      'required_skills': requiredSkills,
      'qualifications': qualifications,
      'hours': hours,
      'industry_partner': industryPartner,
    };
  }
}

class InternshipWithPartner extends Internship {
  final int? partnerId;
  final String? profilePic;
  final String partnerName;
  final String partnerLocation;
  final String contactNo;
  final String emailAdd;

  InternshipWithPartner({
    super.internshipId,
    required super.displayPhoto,
    required super.internshipTitle,
    required super.takehomePay,
    required super.location,
    required super.description,
    required super.requiredSkills,
    required super.qualifications,
    required super.hours,
    super.industryPartner,
    this.partnerId,
    this.profilePic,
    required this.partnerName,
    required this.partnerLocation,
    required this.contactNo,
    required this.emailAdd,
  });

  factory InternshipWithPartner.fromJson(Map<String, dynamic> json) {
    return InternshipWithPartner(
      internshipId: json['internship_id'] as int?,
      displayPhoto: json['display_photo'],
      internshipTitle: json['internship_title'] ?? '',
      takehomePay: json['takehome_pay'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      requiredSkills: json['required_skills'] ?? '',
      qualifications: json['qualifications'] ?? '',
      hours: json['hours'] ?? '',
      industryPartner: json['industry_partner'] as int?,
      partnerId: json['partner_id'] as int?,
      profilePic: json['profile_pic'],
      partnerName: json['partner_name'] ?? '',
      partnerLocation: json['partner_location'] ?? '',
      contactNo: json['contact_no'] ?? '',
      emailAdd: json['email_add'] ?? '',
    );
  }

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
