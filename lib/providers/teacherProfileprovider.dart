
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_models/teacherProfilemodel.dart';

class TeacherProfileProvider with ChangeNotifier{
  final String baseUrl = 'http://192.168.1.71:8000'; 

  Future<void> updateTeacher(BuildContext context,int teacherId, TeacherProfile teacher) async {
    final url = 'http://192.168.1.71:8000/teachersUpdate/$teacherId/';

    final response = await http.put(Uri.parse(url), body: {
      'teaching_location': teacher.teachingLocation,
      'teaching_experience': teacher.teachingExperience,
      'education': teacher.education,
      'grade':teacher.className,
      'subjects':teacher.subjects.join(','),
    });

    if (response.statusCode == 200) {
             final snackBar = SnackBar(content: Text('Your Profile Updated Successfully'));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

    } else {
                   final snackBar = SnackBar(content: Text('Failed to Update Profile'));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

    
    }
  }
}
