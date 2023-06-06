import 'dart:io';

import 'package:flutter/material.dart';

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
    this.gender
  });
}
