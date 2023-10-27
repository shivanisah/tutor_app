import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tutor_app/filteration/resultfilterlist.dart';
import 'package:tutor_app/models/user_models/classsubjectmodel.dart';

import '../app_urls/app_urls.dart';
import 'package:http/http.dart' as http;

class TeacherListProvider with ChangeNotifier{

  List<dynamic> teachers = [];
  List<dynamic> filteredteacherlist = [];
  List<dynamic> connectionstatus = [];
  Map<String,String> headers = {                           
       "Content-Type": "application/json; charset=UTF-8" };  

  Future<List<dynamic>> fetchTeachers(BuildContext context) async{

    try{
      final url = Uri.parse(AppUrl.teacherlists);
      final response = await http.get(url);

      if(response.statusCode == 200){
      List<dynamic> data = jsonDecode(response.body);
      
      return data;
      }
      else {
      throw Exception('Failed to fetch teachers. Status code: ${response.statusCode}');
            }
    }on SocketException catch (e) {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        
        message: 'No Internet connection',
      
        margin:EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(6),
        backgroundColor:Colors.grey,
        duration: Duration(seconds: 3),
        
      ).show(context);
      teachers =[];
      return teachers; 
    }
    catch (e) {
    throw Exception('Failed to fetch teachers. Error: $e');
    }
    finally {
      notifyListeners();
    }
    }

  Future<List<dynamic>> fetchfilteredTeachers(BuildContext context,String? teaching_experience,String? gender,String? teachinglocation) async{

    try{
    final url = AppUrl.baseUrl+'/filterteacher/';
    final Uri uri = Uri.parse(url);
    print(teaching_experience);
    final Map<String,String> queryParams = {
      'teaching_experience':teaching_experience?? '',
      'gender':gender?? '',
      'teaching_location':teachinglocation?? '',
      // 'education':qualification?? '',
    };
    queryParams.removeWhere((key, value) => value == null);
    final Uri finalUri = uri.replace(queryParameters:queryParams );

    final response = await http.get(finalUri);
  

      if(response.statusCode == 200){
      List<dynamic> data = jsonDecode(response.body);
        //   Timer(Duration(seconds: 2), (){
        //          Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) =>TeacherListFilterResult(data:data)),
        //       );
        // });

      print("ResponseData$data");
      
      return data;
      
      }
      else {
        filteredteacherlist = ['noresult'];
        return filteredteacherlist;
      // throw Exception('Failed to fetch filtered teachers. Status code: ${response.statusCode}');
      
            }
    }on SocketException catch (e) {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        
        message: 'No Internet connection',
      
        margin:EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(6),
        backgroundColor:Colors.grey,
        duration: Duration(seconds: 3),
        
      ).show(context);
      connectionstatus =[];
      return connectionstatus; 
    }
    catch (e) {
    throw Exception('Failed to fetch teachers. Error: $e');
    }
    finally {
      notifyListeners();
    }
    }

  }
