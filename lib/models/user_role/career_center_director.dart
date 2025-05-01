class CareerCenterDirector {
  String? directorId;
  final String uncEmail;
  final String firstName;
  final String middleName;
  final String lastName;
  final String userAccount;

  CareerCenterDirector(
      {this.directorId,
      required this.uncEmail,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.userAccount});

  factory CareerCenterDirector.fromJson(Map<String, dynamic> json) {
    return CareerCenterDirector(
      directorId: json['director_id'],
      uncEmail: json['unc_email'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      userAccount: json['user_account'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'director_id': directorId,
      'unc_email': uncEmail,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'user_account': userAccount,
    };
  }
}

class CareerCenterDirectorAccount extends CareerCenterDirector {
  String? accountId;
  final String username;
  final String password;

  CareerCenterDirectorAccount({
    super.directorId,
    required super.uncEmail,
    required super.firstName,
    required super.middleName,
    required super.lastName,
    required super.userAccount,
    this.accountId,
    required this.username,
    required this.password,
  });

  factory CareerCenterDirectorAccount.fromJson(Map<String, dynamic> json) {
    return CareerCenterDirectorAccount(
      directorId: json['director_id'],
      uncEmail: json['unc_email'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      userAccount: json['user_account'],
      accountId: json['account_id'],
      username: json['username'],
      password: json['password'],
    );
  }

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
