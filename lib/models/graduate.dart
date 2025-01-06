// ignore_for_file: public_member_api_docs, sort_constructors_first
class Graduate {
  String? graduateId;
  final String email;
  final String firstName;
  final String middleName;
  final String lastName;
  final String course;
  final String department;
  final String bday;
  final String gender;
  final int age;
  final String address;
  final String contactNo;
  final String dateGrad;
  final String empStat;
  final String userAccount;

  Graduate( {
    this.graduateId,
    required this.email,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.course,
    required this.department,
    required this.bday,
    required this.gender,
    required this.age,
    required this.address,
    required this.contactNo,
    required this.dateGrad,
    required this.empStat,
    required this.userAccount,
  });

  factory Graduate.fromJson(Map<String, dynamic> json) {
    return Graduate(
      graduateId: json['graduate_id'],
      email: json['email'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      course: json['course'],
      department: json['department'],
      bday: json['bday'],
      gender: json['gender'],
      age: json['age'],
      address: json['address'],
      contactNo: json['contact_no'],
      dateGrad: json['date_grad'],
      empStat: json['emp_stat'],
      userAccount: json['user_account'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'graduate_id': graduateId,
      'email': email,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'course': course,
      'department': department,
      'bday': bday,
      'gender': gender,
      'age': age,
      'address': address,
      'contact_no': contactNo,
      'date_grad': dateGrad,
      'emp_stat': empStat,
      'user_account': userAccount,
    };
  }
}

class GraduateAccount extends Graduate {
  String? accountId;
  final String username;
  final String password;
  
  GraduateAccount({
    super.graduateId,
    required super.email,
    required super.firstName,
    required super.middleName,
    required super.lastName,
    required super.course,
    required super.department,
    required super.bday,
    required super.gender,
    required super.age,
    required super.address,
    required super.contactNo,
    required super.dateGrad,
    required super.empStat,
    required super.userAccount,
    required this.accountId,
    required this.username,
    required this.password,
  });

  factory GraduateAccount.fromJson(Map<String, dynamic> json) {
    return GraduateAccount(
      graduateId: json['graduate_id'],
      email: json['email'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      course: json['course'],
      department: json['department'],
      bday: json['bday'],
      gender: json['gender'],
      age: json['age'],
      address: json['address'],
      contactNo: json['contact_no'],
      dateGrad: json['date_grad'],
      empStat: json['emp_stat'],
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