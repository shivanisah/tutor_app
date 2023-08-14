
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_app/app_urls/app_urls.dart';
import 'package:tutor_app/models/user_models/teacher_data.dart';
import 'package:tutor_app/tutor/tutorprofiledetails.dart';
import 'package:tutor_app/utils/colors.dart';

import '../models/user_models/teacherProfilemodel.dart';
import '../models/user_models/teachernotification.dart';

class TeacherProfileProvider with ChangeNotifier{

  bool _loading = false;
  bool get loading => _loading;

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
    _loading = true;
    notifyListeners();
    if (response.statusCode == 200) {
             final snackBar = SnackBar(content: Text('Your Profile Updated Successfully'),backgroundColor: Palette.theme1,);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => TutorProfileDetailPage(),
       settings:RouteSettings(arguments: teacherId)

       ));

    } else {
                   final snackBar = SnackBar(content: Text('Failed to Update Profile'));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

    
    }
    _loading = false;
    notifyListeners();
  }

    Future<void> teacherprofileUpdate(BuildContext context,String phoneNumber,int teacherId,File? image,double latitude,double longitude,String address) async {
    
    final url = AppUrl.baseUrl+'/teacherprofileUpdate/$teacherId';
    String latitudeString = latitude.toStringAsFixed(12).replaceAll(RegExp(r"0*$"), "");
    String longitudeString = longitude.toStringAsFixed(12).replaceAll(RegExp(r"0*$"), "");
    final request = http.MultipartRequest('PUT',Uri.parse(url));
    request.fields['phone_number'] = phoneNumber;
    request.fields['latitude'] =latitudeString;
    request.fields['longitude'] = longitudeString;
    request.fields['address'] = address;
    
    if(image!=null){
      String fileName = image.path.split('/').last;
      request.files.add(await http.MultipartFile.fromPath('image',image.path,
      filename: fileName
      ));
    }

    // final response = await http.put(Uri.parse(url), body: {
    //   'phone_number':phoneNumber
    // });
    _loading = true;
    notifyListeners();
    try{
      final response = await http.Response.fromStream(await request.send());
debugPrint("Response Status Code: ${response.statusCode}");
debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200) {
            debugPrint("Latitude: $latitude");
  debugPrint("Longitude: $longitude");

             final snackBar = SnackBar(content: Text('Your Profile Updated Successfully'),backgroundColor: Palette.theme1,);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.push(context,MaterialPageRoute(builder:(context) => TutorProfileDetailPage(),
                       settings:RouteSettings(arguments: teacherId)));


    } else {
                   final snackBar = SnackBar(content: Text('Failed to Update Profile'),backgroundColor:Colors.red,);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

    
    }
    }catch(error){
      final snackBar = SnackBar(content: Text('Error occured while updating profile'),backgroundColor:Colors.red,);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> teacherteachingInfoUpdate(BuildContext context,String teaching_location,String education,String teaching_experience,
                                          String grade,List subjects,int teacherId) 
  
  async {
    final url = AppUrl.baseUrl+'/teacherprofileUpdate/$teacherId';

    final response = await http.put(Uri.parse(url), body: {
      'teaching_location':teaching_location,
      'teaching_experience': teaching_experience,
      'education': education,
      'grade':grade,
      'subjects':subjects.join(',') ,

    });
    _loading = true;
    notifyListeners();
    if (response.statusCode == 200) {
      
             final snackBar = SnackBar(content: Text('Your Profile Updated Successfully'),backgroundColor: Palette.theme1,);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
       Navigator.push(context,MaterialPageRoute(builder:(context) => TutorProfileDetailPage(),
                       settings:RouteSettings(arguments: teacherId)

       ));


      

    
    } else {
                   final snackBar = SnackBar(content: Text('Failed to Update Profile'),backgroundColor:Colors.red,);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

    
    }
    _loading = false;
    notifyListeners();
  }
Completer<void>? _uploadCompleter;

Future<void> teachercertificateUpdate(BuildContext context,int teacherId,File? certificate) async {
    
    if (_uploadCompleter != null && !_uploadCompleter!.isCompleted) {
      _uploadCompleter!.completeError("Cancelled");
      _uploadCompleter = null;
    }
    final url = AppUrl.baseUrl+'/teachercertificateUpdate/$teacherId';
    final request = http.MultipartRequest('PUT',Uri.parse(url));
    
    if(certificate!=null){
      String fileName = certificate.path.split('/').last;
      request.files.add(await http.MultipartFile.fromPath('certificate',certificate.path,
      filename: fileName
      ));
    }

    // final response = await http.put(Uri.parse(url), body: {
    //   'phone_number':phoneNumber
    // });
    _loading = true;
    notifyListeners();
    try{
      final response = await http.Response.fromStream(await request.send());
debugPrint("Response Status Code: ${response.statusCode}");
debugPrint("Response Body: ${response.body}");

    if (response.statusCode == 200) {
if (context != null && ScaffoldMessenger.of(context).mounted)    {
             final snackBar = SnackBar(content: Text('Your Certificate Uploaded Successfully'),backgroundColor: Palette.theme1,);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(context,MaterialPageRoute(builder:(context) => TutorProfileDetailPage(),
                       settings:RouteSettings(arguments: teacherId)

       ));

}


    } else {
if (context != null && ScaffoldMessenger.of(context).mounted)      {
          final snackBar = SnackBar(content: Text('Failed to Upload certificate'),backgroundColor:Colors.red,);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }

    
    }
    }catch(error){
if (context != null && ScaffoldMessenger.of(context).mounted)      {
      final snackBar = SnackBar(content: Text('Error occured while uploading certificate'),backgroundColor:Colors.red,);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      
    }
    _loading = false;
    notifyListeners();
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
      throw Exception('Failed to fetch teacher profile');
    }
  }
// admin
List<TeacherData> registeredTeacher = [];
Future<void> fetchRegisteredTeacherList() async{
  final url = Uri.parse(AppUrl.baseUrl+'/registeredTeacherList/');
  final response = await http.get(url);

  if(response.statusCode == 200){
    final List<dynamic> responseData = json.decode(response.body);
    registeredTeacher = responseData.map((data)=>TeacherData.fromJson(data)).toList();
    notifyListeners();
  }
}

List<TeacherData> verifiedTeacher = [];
Future<void> fetchVerifiedTeacherList() async{
  final url = Uri.parse(AppUrl.baseUrl+'/verifiedTeacherList/');
  final response = await http.get(url);

  if(response.statusCode == 200){
    final List<dynamic> responseData = jsonDecode(response.body);
    verifiedTeacher = responseData.map((data)=>TeacherData.fromJson(data)).toList();
    notifyListeners();
  }
}

//teacher notification
List<TeacherNotification> notificationlist = [];
Future<void> fetchnotificationList(int teacherId) async{
  final url = Uri.parse(AppUrl.baseUrl+'/teacher-notification/$teacherId');
  final response = await http.get(url);

  if(response.statusCode == 200){
      final List<dynamic> data = json.decode(response.body);

      
      notificationlist = data.map((json)=>TeacherNotification.fromJson(json)).toList();
      notifyListeners();
    
  }    
  else{
      throw Exception("Failed to fetch notification list");
    }


}

int notification_count = 0;
int get notificationcount => notification_count;
Future<void> notificationCount(int teacherId) async{
  final url = Uri.parse(AppUrl.baseUrl+'/teacherseen-notification/$teacherId');
  final response = await http.get(url);

  if(response.statusCode == 200){
    
    final responseData = json.decode(response.body);
    int count = responseData['notification_count']; 
    notification_count = count;     
      notifyListeners();
    
    
  }    
  else{
      throw Exception("Failed to fetch notification list");
    }


}


}
