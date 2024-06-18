class IndustryPartner {
  final int? partnerId;
  final String? profilePic;
  final String partnerName;
  final String partnerLocation;
  final String contactNo;
  final String emailAdd;

  IndustryPartner({
    this.partnerId,
    required this.profilePic,
    required this.partnerName,
    required this.partnerLocation,
    required this.contactNo,
    required this.emailAdd,
  });

  factory IndustryPartner.fromJson(Map<String, dynamic> json) {
    return IndustryPartner(
      partnerId: json['partner_id'],
      profilePic: json['profile_pic'] ?? '',
      partnerName: json['partner_name'] ?? '',
      partnerLocation: json['partner_location'] ?? '',
      contactNo: json['contact_no'] ?? '',
      emailAdd: json['email_add'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'partner_id': partnerId,
      'profile_pic': profilePic,
      'partner_name': partnerName,
      'partner_location': partnerLocation,
      'contact_no': contactNo,
      'email_add': emailAdd,
    };
  }
}