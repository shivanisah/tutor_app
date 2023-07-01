import 'dart:convert';

class Teacher{
  int? id;
  String? full_name;
  String? email;
  num? phone;
  String? password;
  String? token;
  bool? emailVerified;
  bool? isStaff;
  String? user_type;



Teacher({this.full_name, this.id,this.email, this.password,this.token,this.phone,this.emailVerified,this.isStaff,this.user_type});


factory Teacher.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return Teacher(
      id: json['user_id'],
      email: json['email'],
      full_name: json['full_name'],
      phone: json['phone_number'],
      token: json['access'],
      emailVerified: json['email_verified'],
      isStaff: json['is_staff'],
      user_type:json['user_type']
    );

  }
}