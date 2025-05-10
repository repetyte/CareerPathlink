class Coach {
  int? id;
  String? coachId;
  final String coachName;
  int? userId;
  int? profileId;

  Coach({this.id, this.coachId, required this.coachName, this.userId, this.profileId,});

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(id: json['id'], coachName: json['coach_name'], userId: json['user_id'], profileId: json['profile_id'],);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coach_name': coachName,
      'user_id': userId,
      'profile_id': profileId,
    };
  }
}

class CoachAccount extends Coach {
  String? accountId;
  final String username;
  final String password;

  CoachAccount({required super.id, required super.coachId, required super.coachName, super.userId, super.profileId, required this.accountId, required this.username, required this.password, });  

  factory CoachAccount.fromJson(Map<String, dynamic> json) {
  return CoachAccount(
    id: json['id'] ?? 0,
    coachId: json['coach_id'] ?? '',
    coachName: json['coach_name'] ?? '',
    accountId: json['account_id'] ?? '',
    username: json['username'] ?? '',
    password: json['password'] ?? '',
    
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
