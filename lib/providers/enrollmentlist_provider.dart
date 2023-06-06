import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/user_models/enrolledStudentsmodel.dart';
import 'package:http/http.dart' as http;


class EnrollmentProvider with ChangeNotifier {
  List<Enrollment> enrollments = [];

  Future<void> fetchEnrollments(int teacherId) async {
    // print("########################################################");
    // print(teacherId);
    final url = Uri.parse('http://192.168.1.71:8000/students/$teacherId');
    final response = await http.get(url);
    // print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> data = json.decode(response.body);
      enrollments = data.map((json) => Enrollment.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch enrollments');
    }
  }
}
