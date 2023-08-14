// ignore_for_file: unnecessary_type_check

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_app/app_urls/app_urls.dart';

import '../models/user_models/timeSlotmodel.dart';
import '../utils/colors.dart';


class FinalTimeSlotProvider with ChangeNotifier{
  bool _loading = false;
  bool get loading =>_loading;

  List<TimeSlot> timeSlots = [];
  List<TimeSlot> timeSlotsoccupied = [];


Future<void> TimeSlots(int teacherId)async{
  final url = Uri.parse(AppUrl.baseUrl+'/timeslotListavailable/$teacherId');
  final response = await http.get(url);

  if(response.statusCode == 200){
    final List<dynamic> responseData = jsonDecode(response.body);
    timeSlots = responseData.map((data)=>TimeSlot.fromJson(data)).toList();   
    notifyListeners();

  }else{
    throw Exception('Failed to fetch the time slots.Status code:${response.statusCode}');
  }
}

Future<void> TimeSlotsOccupied(int teacherId)async{
  final url = Uri.parse(AppUrl.baseUrl+'/timeslotListoccupied/$teacherId');
  final response = await http.get(url);

  if(response.statusCode == 200){
    final List<dynamic> responseData = jsonDecode(response.body);
    timeSlotsoccupied = responseData.map((data)=>TimeSlot.fromJson(data)).toList();   
    notifyListeners();

  }else{
    throw Exception('Failed to fetch the time slots.Status code:${response.statusCode}');
  }
}


}