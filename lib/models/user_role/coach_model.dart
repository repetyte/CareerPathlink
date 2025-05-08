class Coach {
  int? id;
  final String coachName;
  final String role;
  final String userAccount;

  Coach({this.id, required this.coachName, required this.role, required this.userAccount});

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(id: json['id'], coachName: json['coach_name'], role: json['role'], userAccount: json['user_account']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coach_name': coachName,
      'role': role,
      'user_account': userAccount
    };
  }
}

class CoachAccount extends Coach {
  String? accountId;
  final String username;
  final String password;

  CoachAccount({required super.id, required super.coachName, required super.role, required super.userAccount, required this.accountId, required this.username, required this.password, });  

  factory CoachAccount.fromJson(Map<String, dynamic> json) {
  return CoachAccount(
    accountId: json['account_id'] ?? '',
    username: json['username'] ?? '',
    password: json['password'] ?? '',
    id: json['id'] ?? 0,
    coachName: json['coach_name'] ?? '',
    role: json['role'] ?? '',
    userAccount: json['user_account'] ?? '',
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
