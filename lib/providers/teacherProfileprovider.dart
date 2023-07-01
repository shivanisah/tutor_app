
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_app/app_urls/app_urls.dart';
import 'package:tutor_app/models/user_models/teacher_data.dart';

import '../models/user_models/teacherProfilemodel.dart';

class TeacherProfileProvider with ChangeNotifier{
  final String baseUrl = 'http://192.168.43.147:8000'; 

  Future<void> updateTeacher(BuildContext context,int teacherId, TeacherProfile teacher) async {
    final url = AppUrl.baseUrl+'/teachersUpdate/$teacherId/';

    final response = await http.put(Uri.parse(url), body: {
      'teaching_location': teacher.teaching_location,
      'teaching_experience': teacher.teaching_experience,
      'education': teacher.education,
      'grade':teacher.className,
      'subjects':teacher.subjects?.join(',') ,
    });

    if (response.statusCode == 200) {
             final snackBar = SnackBar(content: Text('Your Profile Updated Successfully'));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

    } else {
                   final snackBar = SnackBar(content: Text('Failed to Update Profile'));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

    
    }
  }
   TeacherData? teacherProfile;
    Future<void> fetchTeacherProfile(int teacherId) async {
    final url = Uri.parse(AppUrl.baseUrl+'/teacherProfileGet/$teacherId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
     final Map<String, dynamic> data = json.decode(response.body);
    teacherProfile = TeacherData.fromJson(data);      
    notifyListeners();
    // onUpdateProfileData();

    } 
    else {
      throw Exception('Failed to fetch confirm enrollments');
    }
  }
// admin
List<TeacherData> registeredTeacher = [];
Future<void> fetchRegisteredTeacherList() async{
  final url = Uri.parse(AppUrl.baseUrl+'/registeredTeacherList/');
  final response = await http.get(url);

  if(response.statusCode == 200){
    final List<dynamic> responseData = jsonDecode(response.body);
    registeredTeacher = responseData.map((data)=>TeacherData.fromJson(data)).toList();
  }
}

List<TeacherData> verifiedTeacher = [];
Future<void> fetchVerifiedTeacherList() async{
  final url = Uri.parse(AppUrl.baseUrl+'/verifiedTeacherList/');
  final response = await http.get(url);

  if(response.statusCode == 200){
    final List<dynamic> responseData = jsonDecode(response.body);
    verifiedTeacher = responseData.map((data)=>TeacherData.fromJson(data)).toList();
  }
}


}
