class IndustryPartner {
  int? partnerId;
  final String? profilePic;
  final String partnerName;
  final String partnerLocation;
  final String contactNo;
  final String emailAdd;

  IndustryPartner({
    this.partnerId,
    this.profilePic,
    required this.partnerName,
    required this.partnerLocation,
    required this.contactNo,
    required this.emailAdd,
  });

  factory IndustryPartner.fromJson(Map<String, dynamic> json) {
    return IndustryPartner(
      partnerId: json['partner_id'] as int?,
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

class IndustryPartnerAccount extends IndustryPartner {
  String? accountId;
  String username;
  String password;

  IndustryPartnerAccount(
      {super.partnerId,
      super.profilePic,
      required super.partnerName,
      required super.partnerLocation,
      required super.contactNo,
      required super.emailAdd,
      this.accountId,
      required this.username,
      required this.password});

  // Factory method for creating IndustryPartnerAccount from JSON
  factory IndustryPartnerAccount.fromJson(Map<String, dynamic> json) {
    return IndustryPartnerAccount(
      partnerId: json['partner_id'] as int?,
      profilePic: json['profile_pic'],
      partnerName: json['partner_name'] ?? '',
      partnerLocation: json['partner_location'] ?? '',
      contactNo: json['contact_no'] ?? '',
      emailAdd: json['email_add'] ?? '',
      accountId: json['account_id'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
    );
  }

  // Method to convert IndustryPartnerAccount to JSON
  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'account_id': accountId,
      'username': username,
      'password': password,
    });
    return json;
  }
}
