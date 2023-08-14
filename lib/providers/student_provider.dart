import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutor_app/app_urls/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_app/student/profiledetail.dart';
import 'package:tutor_app/utils/colors.dart';

import '../models/user_models/studentmodel.dart';
import '../models/user_models/studentnotificationmodel.dart';

class StudentProvider with ChangeNotifier{

  bool _loading = false;
  bool get loading => _loading;


List<Student> registeredStudent = [];
Future<void> fetchRegisteredStudentList()async{
  
  final url = Uri.parse(AppUrl.baseUrl+'/registeredStudentList/');
  final response = await http.get(url);

  if(response.statusCode == 200){
    final List<dynamic> responseData = jsonDecode(response.body);
    registeredStudent = responseData.map((data)=>Student.fromJson(data)).toList();
    notifyListeners();
  }

}
  Future<void> createstudentProfile(BuildContext context,int studentId, String name,String number,String parents_name,String parents_number,
                                      String gender,double? latitude,double? longitude ,String address
  )
   async {
    final url = AppUrl.baseUrl+'/studentprofile/$studentId/';
    String latitudeString = latitude!.toStringAsFixed(12).replaceAll(RegExp(r"0*$"), "");
    String longitudeString = longitude!.toStringAsFixed(12).replaceAll(RegExp(r"0*$"), "");

    final response = await http.put(Uri.parse(url), body: {

      'name':name,
      'number':number,
      'parents_name':parents_name,
      'parents_number':parents_number,
      'gender':gender,
      'latitude':latitudeString,
      'longitude':longitudeString,
      'address':address,

    });
    _loading = true;
    notifyListeners();
    if (response.statusCode == 200) {
      print(response.body);
             final snackBar = SnackBar(content: Text('Your Profile Created Successfully'),backgroundColor: Palette.theme1,);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => StudentProfileDetailPage(),
       settings: RouteSettings(arguments: studentId)

       ));

    } else {
                   final snackBar = SnackBar(content: Text('Failed to create Profile'));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

    
    }
    _loading = false;
    notifyListeners();
  }

   Student? studentProfile;
    Future<void> fetchStudentProfile(int studentId) async {
    final url = Uri.parse(AppUrl.baseUrl+'/studentProfileGet/$studentId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
     final Map<String, dynamic> data = json.decode(response.body);
    studentProfile = Student.fromJson(data);      
    notifyListeners();
    // onUpdateProfileData();

    } 
    else {
      throw Exception('Failed to fetch student profile');
    }
  }


List<StudentNotification> notificationlist = [];
Future<void> fetchnotificationList(int studentId) async{
  final url = Uri.parse(AppUrl.baseUrl+'/student-notification/$studentId');
  final response = await http.get(url);

  if(response.statusCode == 200){
      final List<dynamic> data = json.decode(response.body);

      
      notificationlist = data.map((json)=>StudentNotification.fromJson(json)).toList();
      notifyListeners();
    
  }    
  else{
      throw Exception("Failed to fetch notification list");
    }


}

void deleteNotification(int notificationId){
  notificationlist.removeWhere((notification)=>notification.id == notificationId);
  print("Deleted notification: $notificationId");
  notifyListeners();
}


int notification_count = 0;
int get notificationcount => notification_count;
Future<void> notificationCount(int studentId) async{
  final url = Uri.parse(AppUrl.baseUrl+'/seen-notification/$studentId');
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

    Future<void> studentprofileUpdate(BuildContext context,String pname,String pnumber,String name,String number,String gender,int studentId,
        double? latitude,double? longitude,String address
        ) async {
        String latitudeString = latitude!.toStringAsFixed(12).replaceAll(RegExp(r"0*$"), "");
        String longitudeString = longitude!.toStringAsFixed(12).replaceAll(RegExp(r"0*$"), "");

    final url = AppUrl.baseUrl+'/studentprofileUpdate/$studentId';
    final request = http.MultipartRequest('PUT',Uri.parse(url));
    request.fields['name'] = name;
    request.fields['number'] = number;
    request.fields['parents_name'] = pname;
    request.fields['parents_number'] = pnumber;
    request.fields['gender'] = gender;
    request.fields['latitude']=latitudeString;
    request.fields['longitude']=longitudeString;
    request.fields['address']=address;


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
             final snackBar = SnackBar(content: Text('Your Profile Updated Successfully'),backgroundColor: Palette.theme1,);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.push(context,MaterialPageRoute(builder:(context) => StudentProfileDetailPage(),
                       settings:RouteSettings(arguments: studentId)));


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


}

