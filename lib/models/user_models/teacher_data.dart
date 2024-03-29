import 'dart:io';

import 'package:intl/intl.dart';
import 'package:tutor_app/models/user_models/mapclasssubject.dart';
import 'package:tutor_app/models/user_models/timeSlot.dart';

import 'classsubjectmodel.dart';


class TeacherData {
  final String fullName;
  final String phoneNumber;
  final String? address;
  final String? image;
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
  late bool? preview_certificate;

  final DateTime? date_joined;
  late String? verification_date;
  late String? preview_certificateDate;

  String? latitude;
  String? longitude;
  final String? certificate;
  List<GradeSubjectsModel>? classSubjectlist;
  List<GradeSubjectsModel>? classSubjectfinallist;

  dynamic mapclasssubject;
  late bool? block;

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
    this.preview_certificate,
    this.date_joined,
    this.verification_date,
    this.preview_certificateDate,
    this.latitude,
    this.longitude,
    this.certificate,
    this.classSubjectlist,
    this.classSubjectfinallist,
    this.mapclasssubject,
    this.block,
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

  final classSubject;
  final classSubjectListData = json['classlist'] as List<dynamic>?;
    if (classSubjectListData != null) {
      classSubject = classSubjectListData
          .map((classData) => GradeSubjectsModel.fromJson(classData))
          .toList();
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
      preview_certificateDate : json['preview_certificateDate'],

      subjects:subjectsList, 
      image:json['image'],
      latitude:json['latitude'],
      longitude:json['longitude'],
      certificate:json['certificate'],
      classSubjectfinallist: List<GradeSubjectsModel>.from(json['classlist'].map((classData)=>GradeSubjectsModel.fromJson(classData))),
      block:json['block'] as bool,

        );
  }
void setVerification(bool value){
  verification_status = value;
}

void setpreviewCertificate(bool value){
  preview_certificate = value;
}


void setVerificationDate(DateTime date){
      final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      verification_date = dateFormat.format(date);
}

void setpreviewCertificateDate(DateTime date){
      final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      preview_certificateDate = dateFormat.format(date);
}

  void setBlockedUser(bool value) {
    block= value;
  }
  void setUnBlockedUser(bool value) {
    block= value;
  }


}
