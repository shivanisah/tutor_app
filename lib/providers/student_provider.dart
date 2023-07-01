import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutor_app/app_urls/app_urls.dart';
import 'package:http/http.dart' as http;

import '../models/user_models/studentmodel.dart';

class StudentProvider with ChangeNotifier{


List<Student> registeredStudent = [];
Future<void> fetchRegisteredStudentList()async{
  
  final url = Uri.parse(AppUrl.baseUrl+'/registeredStudentList/');
  final response = await http.get(url);

  if(response.statusCode == 200){
    final List<dynamic> responseData = jsonDecode(response.body);
    registeredStudent = responseData.map((data)=>Student.fromJson(data)).toList();
  }

}

}

