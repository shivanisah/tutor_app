import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tutor_app/app_urls/app_urls.dart';

import '../models/user_models/enrolledStudentsmodel.dart';
import 'package:http/http.dart' as http;


class EnrollmentProvider with ChangeNotifier {
  List<Enrollment> enrollments = [];
  List<Enrollment> confirmedEnrollments = [];
  List<Enrollment> rejectedEnrollments = [];

  Future<void> fetchEnrollments(int teacherId) async {
    final url = Uri.parse(AppUrl.baseUrl+'/students/$teacherId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      enrollments = data.map((json) => Enrollment.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch enrollments');
    }
  }
  Future<void> fetchConfirmEnrollments(int teacherId) async {
    final url = Uri.parse(AppUrl.baseUrl+'/confirmstudents/$teacherId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      confirmedEnrollments = data.map((json) => Enrollment.fromJson(json)).toList();
      notifyListeners();

    } 
    else {
      throw Exception('Failed to fetch confirm enrollments');
    }
  }

    Future<void> fetchRejectedEnrollments(int? teacherId) async {
    final url = Uri.parse(AppUrl.baseUrl+'/rejectedstudents/$teacherId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      rejectedEnrollments = data.map((json) => Enrollment.fromJson(json)).toList();
      notifyListeners();

    } 
    else {
      throw Exception('Failed to fetch rejected enrollments');
    }
  }



}
