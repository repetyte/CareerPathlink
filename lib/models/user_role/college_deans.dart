class CollegeDean {
  String? deanId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String uncEmail;
  final String department;
  final String userAccount;

  CollegeDean({
    this.deanId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.uncEmail,
    required this.department,
    required this.userAccount,
  });

  factory CollegeDean.fromJson(Map<String, dynamic> json) {
    return CollegeDean(
      deanId: json['dean_id'] as String?,
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      uncEmail: json['unc_email'] ?? '',
      department: json['department'] ?? '',
      userAccount: json['user_account'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dean_id': deanId,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'department': department,
      'user_account': userAccount,
    };
  }
}

class CollegeDeanAccount extends CollegeDean {
  String? accountId;
  String username;
  String password;

  CollegeDeanAccount(
      {super.deanId,
      required super.firstName,
      required super.middleName,
      required super.lastName,
      required super.uncEmail,
      required super.department,
      required super.userAccount,
      this.accountId,
      required this.username,
      required this.password});

  // Factory method for creating CollegeDeanAccount from JSON
  factory CollegeDeanAccount.fromJson(Map<String, dynamic> json) {
    return CollegeDeanAccount(
      deanId: json['dean_id'] as String?,
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      uncEmail: json['unc_email'] ?? '',
      department: json['department'] ?? '',
      userAccount: json['user_account'] ?? '',
      accountId: json['account_id'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
    );
  }

  // Method to convert CollegeDeanAccount to JSON
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
