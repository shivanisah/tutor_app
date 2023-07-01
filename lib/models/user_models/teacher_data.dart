import 'dart:io';

import 'package:intl/intl.dart';
import 'package:tutor_app/models/user_models/timeSlot.dart';


class TeacherData {
  final String fullName;
  final String phoneNumber;
  final String? address;
  File? image;
  final String email;
  final int id;
  final String? teaching_location;
  final String? teaching_experience;
  final String? education;
  final String? about_me;
  final String? grade;
  final String? gender;
  final List<String>? subjects;
  List<TimeSlot>? timeSlots;
  late bool? verification_status;
  final DateTime? date_joined;
  late String? verification_date;
  // final String subjects;

  TeacherData({
    required this.fullName,
    required this.phoneNumber,
    this.address,
    this.image,
    required this.email,
    required this.id,
    this.teaching_location,
    this.teaching_experience,
    this.education,
    this.about_me,
    this.grade,
    this.gender,
    this.subjects,
    this.timeSlots,
     this.verification_status,
    this.date_joined,
    this.verification_date,
  });
  factory TeacherData.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    List<String>? subjectsList;
  dynamic subjectsData = json['subjects'];
  if (subjectsData is String) {
    subjectsList = [subjectsData];
  } else if (subjectsData is List<dynamic>) {
    subjectsList = List<String>.from(subjectsData);
  }
    return TeacherData(
      id: json['id'], 
      email: json['email'],
      phoneNumber: json['phone_number'],
      fullName: json['full_name'],
      teaching_location: json['teaching_location'],
      education:json['education'],
      teaching_experience: json['teaching_experience'],
      gender:json['gender'],
      address:json['address'],
      grade:json['grade'],
      verification_status:json['verification_status'] as bool,
      date_joined: dateFormat.parse(json['date_joined']),
      verification_date : json['verification_date'],
      subjects:subjectsList, 
        );
  }
void setVerification(bool value){
  verification_status = value;
}

void setVerificationDate(DateTime date){
      final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      verification_date = dateFormat.format(date);
}



}
