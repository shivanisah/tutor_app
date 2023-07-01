// ignore_for_file: unnecessary_type_check

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_app/app_urls/app_urls.dart';

import '../models/user_models/timeSlotmodel.dart';
import '../utils/colors.dart';


class TimeSlotProvider with ChangeNotifier{
  bool _loading = false;
  bool get loading =>_loading;

  List<TimeSlot> timeSlots = [];


Future<void> saveTimeSlots(BuildContext context,List<Map<String,dynamic>> timeSlots) async{

  final url = Uri.parse(AppUrl.baseUrl+'/timeslot/');

  _loading = true;
  notifyListeners();

  try{
    for(final timeSlot in timeSlots){

      final response = await http.post(url,body:timeSlot);
      if(response.statusCode == 201){
      print('Time slot saved successfully: ${response.body}');
      final snackBar = SnackBar(content: Text('Time slots saved successfully'),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);


      }else{
        print('Failed to save the time slot:${response.statusCode}');
      }

    }
  }catch(error){
    print('Error saving the time Slots: $error');

  }
  _loading = false;
  notifyListeners();

}

Future<void> TimeSlots(int teacherId)async{
  final url = Uri.parse(AppUrl.baseUrl+'/timeslotList/$teacherId');
  final response = await http.get(url);

  if(response.statusCode == 200){
    final List<dynamic> responseData = jsonDecode(response.body);
    timeSlots = responseData.map((data)=>TimeSlot.fromJson(data)).toList();   
    notifyListeners();

  }else{
    throw Exception('Failed to fetch the time slots.Status code:${response.statusCode}');
  }
}


Future<List<TimeSlot>> fetchTimeSlots(int teacherId) async {
  final url = Uri.parse(AppUrl.baseUrl+'/timeslotList/$teacherId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);

    if (responseData is List) {
      final List<TimeSlot> timeSlots = responseData.map((data) => TimeSlot.fromJson(data)).toList();
      return timeSlots;
    } else if (responseData is Map<String, dynamic>) {
      final List<TimeSlot> timeSlots = [TimeSlot.fromJson(responseData as Map<String, dynamic>)];
      return timeSlots;
    } else {
      throw Exception('Invalid response data format');
    }
  } else {
    throw Exception('Failed to fetch the time slots. Status code: ${response.statusCode}');
  }
}
}