import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
List<Enrollment> enrollhistory = [];
  Future<void> enrollmentHistory(int? studentId) async{
    final url = Uri.parse(AppUrl.baseUrl+'/student-history/$studentId');
    final response = await http.get(url);

    if(response.statusCode == 200){
      final List<dynamic> data = json.decode(response.body);
      enrollhistory = data.map((json)=>Enrollment.fromJson(json)).toList();
      notifyListeners();

    }
    else{
      throw Exception("Failed to fetch enrollment history");
    }
  }

dynamic message;
Future<void> timeslotcheckenrollment(BuildContext context,int? studentId,int? slotid, String? requestfor) async
{
  final url = Uri.parse(AppUrl.baseUrl+'/studentrelatedslot/$studentId/$slotid/$requestfor');
  final response = await http.get(url);
  var responsebody = response.body;
  message = jsonDecode(responsebody);
  
  notifyListeners();
  // if(msg['sameslot']!=null){
  //   message = msg;
  //   print("hhhhhhhhhhhhh/.............");
  //   print(message);
  // }
  // if(msg['slotcount']!=null){
  //   message = msg;
  //   print("hhhhhhhhhhhhh/.............");
  //   print(message);
  // }
  // if(msg['sameslot']!=null){
  //                                       Flushbar(
  //                                           margin:EdgeInsets.all(15),
  //                                           borderRadius: BorderRadius.circular(8),
  //                                           flushbarPosition: FlushbarPosition.TOP,
  //                                           message: "Sorry, you have already done self-enrollment with this time slot.",
  //                                           backgroundColor: Colors.red,
  //                                           duration:Duration(seconds:3),                   
  //                                         ).show(context);

  // }
  // if(msg['slotcount']!=null){
  //                                       Flushbar(
  //                                           margin:EdgeInsets.all(15),
  //                                           borderRadius: BorderRadius.circular(8),
  //                                           flushbarPosition: FlushbarPosition.TOP,
  //                                           message:"You can't make more than 5 enrollment requests.",
  //                                           backgroundColor: Colors.red,
  //                                           duration:Duration(seconds:3),                   
  //                                         ).show(context);


  // }
}
}
