class Coach {
  int? id;
  final String name;
  final String role;
  final String userAccount;

  Coach({this.id, required this.name, required this.role, required this.userAccount});

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(id: json['id'], name: json['name'], role: json['role'], userAccount: json['user_account']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'user_account': userAccount
    };
  }
}

class CoachAccount extends Coach {
  String? accountId;
  final String username;
  final String password;

  CoachAccount({required super.id, required super.name, required super.role, required super.userAccount, required this.accountId, required this.username, required this.password, });  

  factory CoachAccount.fromJson(Map<String, dynamic> json) {
    return CoachAccount(accountId: json['account_id'], username: json['username'], password: json['password'], id: json['id'], name: json['name'], role: json['role'], userAccount: json['user_account']); 
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
