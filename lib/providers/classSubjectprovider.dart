import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tutor_app/app_urls/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_app/utils/colors.dart';

import '../tutor/tutorprofiledetails.dart';
class ClassSubjectProvider extends ChangeNotifier{

  bool _loading = false;
  bool get loading =>_loading;
  Map<String,String> headers = {                           
       "Content-Type": "application/json; charset=UTF-8" };  

  Future<void> teachingclasssubject(BuildContext context,String? className,String? subject,int teacherid) async{
        var body = jsonEncode({
      'classname':className,
      'subject':subject,
      'teacherid':teacherid,

    });

// print("sfdddddddddddddddddd$teacherid");
// print("classs$className");
// print("subject$subject");
    
    final response = await http.post(Uri.parse(AppUrl.addclassandsubjectByteacher),headers: headers,body:body
    );
//     print(response.body);
// print("mmmmmmmmmmmmmmmmmm");
// print(teacherid);
      _loading= true;
      notifyListeners();
      try{
      if(response.statusCode == 201){
        Flushbar(backgroundColor: Palette.theme1,
                message:"Successfully Added data",
                duration:Duration(seconds: 3),
                flushbarPosition:FlushbarPosition.TOP,
        );
        Timer(Duration(seconds:2),(){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>TutorProfileDetailPage(),
          settings: RouteSettings(arguments: teacherid)
          ));
        });
      }
      else{
                Flushbar(backgroundColor: Palette.theme1,
                message:"Something went wrong",
                duration:Duration(seconds: 3),
                flushbarPosition:FlushbarPosition.TOP,
        );

      }

      }catch(e){
        print("exception is $e");
      }
      _loading = false;
      notifyListeners();


  }

}