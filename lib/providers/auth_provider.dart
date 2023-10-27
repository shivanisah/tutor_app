

import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tutor_app/admin/adminMainpage.dart';
import 'package:tutor_app/screens/auth_screens/changepwdverify.dart';
import 'package:tutor_app/screens/auth_screens/resetpwdverify.dart';
// import 'package:tutor_app/tutor/tutorDashboard.dart';
import 'package:tutor_app/utils/colors.dart';
// import 'package:http/http.dart';

import '../FirstScreen/Home.dart';
import '../app_urls/app_urls.dart';
import 'dart:io';

import '../models/user_models/teacher_model.dart';
import '../screens/auth_screens/login.dart';
import 'package:http/http.dart' as http;

import '../shared_preferences.dart/user_preferences.dart';
import '../student/enrollmentMessage.dart';


class AuthProvider extends ChangeNotifier{
  bool _signUpLoading = false ;
  bool get signUpLoading => _signUpLoading ;
  bool _loading = false ;
  bool get loading => _loading ;


// setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }

  // setSignUpLoading(bool value) {
  //   _signUpLoading = value;
  //   notifyListeners();
  // }

  Map<String,String> headers = {                           
       "Content-Type": "application/json; charset=UTF-8" };  



  Future<void> studentSignup(BuildContext context,String email,
  String password,String confirmpassword) async{
    var body = jsonEncode({
      'email':email,
      'password':password,
      'password_confirmation':confirmpassword,
      
    });

    _signUpLoading = true;
    
    notifyListeners();
    try{
      http.Response response = await http.post(Uri.parse(AppUrl.studentregisterApiEndPoint),headers: headers,
    body: body
    );
    
      var responsebody = response.body;
      print(responsebody);
      var mssg = jsonDecode(responsebody);
      print(mssg['non_field_errors']);
      print(responsebody.contains("non_field_errors"));
      print(response.statusCode);
      if(response.statusCode ==400){
        // setSignUpLoading(false);
        // notifyListeners();
      //  final snackBar = SnackBar(content: Text('Account already exits'));
      //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
      }
        if(response.statusCode==201){
        // setSignUpLoading(false);
        
        // notifyListeners();
        final snackBar = SnackBar(content: Text('Verify your email before login'),backgroundColor: Palette.theme1,);
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                         Timer(Duration(seconds: 2), (){
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Login()),
              );
        });



        }



      
    } on SocketException{
      final snackBar = SnackBar(content: Text('No Internet Connection'));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // flushBarErrorMessage('NO Internet connection', context);
    }
    _signUpLoading = false;
    notifyListeners();
  }
//StudentEnrollment
  Future<void> studentEnrollment(BuildContext context,String parentsName,String ParentsNumber,
  String studentsName,String studentsNumber,String gender,String grade,String? teaching_location,List<String> subjects,
  String teacher_email,String teacher_name,
  
  int tutor,String student_email,int student,String finalselectedDate,
  // String selectedTimeSlot
  String selecctedStartTimeSlot,
  String selectedEndTimeSlot, String address, [selectedslotid]
  )async{
    var body = jsonEncode({
      'parents_name':parentsName,
      'parents_number':ParentsNumber,
      'students_name':studentsName,
      'students_number':studentsNumber,
      'gender':gender,
      'grade':grade,
      'preffered_teaching_location':teaching_location,
      'subjects':subjects.join(','),
      'tutor':tutor,
      'student':student,
      'selected_tuitionjoining_date':finalselectedDate,
      // 'teaching_time':selectedTimeSlot,
      'startTime':selecctedStartTimeSlot,
      'endTime':selectedEndTimeSlot,
      'teacher_name':teacher_name,
      'teacher_email':teacher_email,
      'student_email':student_email,
      'address':address,


    
      

      
    });

  _loading = true;    
    notifyListeners();
    try{
      http.Response response = await http.post(Uri.parse(AppUrl.baseUrl+'/enrollment/$selectedslotid'),headers: headers,
    body: body
    );
    
      var responsebody = response.body;
      print(responsebody);
      var mssg = jsonDecode(responsebody);
      print(mssg['non_field_errors']);
      print(responsebody.contains("non_field_errors"));
      print(response.statusCode);
      if(response.statusCode ==400){
        // setSignUpLoading(false);
        // notifyListeners();
       final snackBar = SnackBar(content: Text('Something went wrong'),backgroundColor: Colors.red,);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
      }
        if(response.statusCode==201){
        // setSignUpLoading(false);
        
        // notifyListeners();
        final snackBar = SnackBar(content: Text('Your enrollment form is submitted successfully'),backgroundColor: Palette.theme1,);
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Timer(Duration(seconds: 2), (){
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>EnrollmentMessage()),
              );
        });



        }



      
    } on SocketException{
      // setSignUpLoading(false);
      final snackBar = SnackBar(content: Text('No Internet Connection'));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // flushBarErrorMessage('NO Internet connection', context);
    }
    _loading = false;
    notifyListeners();
  }


    Future<void> studentEnrollmentrequest(BuildContext context,
  String requestfor,String grade,String? teaching_location,List<String> subjects,
  String teacher_email,String teacher_name,
  
  int tutor,String student_email,int student,String finalselectedDate,
  String selecctedStartTimeSlot,
  String selectedEndTimeSlot, String address, [selectedslotid]
  )async{
    var body = jsonEncode({
      'enrollment_for':requestfor,
      'grade':grade,
      'preffered_teaching_location':teaching_location,
      'subjects':subjects.join(','),
      'tutor':tutor,
      'student':student,
      'selected_tuitionjoining_date':finalselectedDate,
      // 'teaching_time':selectedTimeSlot,
      'startTime':selecctedStartTimeSlot,
      'endTime':selectedEndTimeSlot,
      'teacher_name':teacher_name,
      'teacher_email':teacher_email,
      'student_email':student_email,
      'address':address,

      
    });

  _loading = true;    
    notifyListeners();
    try{
      http.Response response = await http.post(Uri.parse(AppUrl.baseUrl+'/enrollment/$selectedslotid'),headers: headers,
    body: body
    );
    
      var responsebody = response.body;
      var mssg = jsonDecode(responsebody);
      if(response.statusCode ==400){
        // setSignUpLoading(false);
        // notifyListeners();
       final snackBar = SnackBar(content: Text('Something went wrong'),backgroundColor: Colors.red,);
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
      }
        if(response.statusCode==201){
        final snackBar = SnackBar(content: Text('Your enrollment form is submitted successfully'),backgroundColor: Palette.theme1,);
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Timer(Duration(seconds: 2), (){
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>EnrollmentMessage()),
              );
        });



        }



      
    } on SocketException{
      final snackBar = SnackBar(content: Text('No Internet Connection'));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
    _loading = false;
    notifyListeners();
  }

//tutor Details Adding
  Future<void> teacherDetails(BuildContext context,String address) async{
    var body = jsonEncode({
      'address':address,
     
    });

    //     setSignUpLoading(true);
    
    // notifyListeners();
    try{
      http.Response response = await http.post(Uri.parse(AppUrl.studentenrollmentApiEndPoint),headers: headers,
    body: body
    );
    
      var responsebody = response.body;
      print(responsebody);
      var mssg = jsonDecode(responsebody);
      print(mssg['non_field_errors']);
      print(responsebody.contains("non_field_errors"));
      print(response.statusCode);
      if(response.statusCode ==400){
       final snackBar = SnackBar(content: Text('Something went wrong'));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
      }
        if(response.statusCode==201){
        // setSignUpLoading(false);
        
        // notifyListeners();
        final snackBar = SnackBar(content: Text('Your enrollment form is submitted successfully'));
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Timer(Duration(seconds: 2), (){
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Login()),
              );
        });



        }



      
    } on SocketException{
      // setSignUpLoading(false);
      final snackBar = SnackBar(content: Text('No Internet Connection'));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // flushBarErrorMessage('NO Internet connection', context);
    }
  }


//tutor registration

Future<void> teacherSignup(
  BuildContext context,
  String name,
  String number,
  String email,
  // String address,
  String password,
  String confirmpassword,
  File? image,
  File? certificateFile, 
  String gender,
  // String selectedGrade,
  // List<String> selectedSubjects,
)async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Location permission is denied, request it

      showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Location Permission Denied'),
      content: Text('Please enable location permission in your device settings to use this feature.'),
      actions: [
        ElevatedButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
    }
  var position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  var latitude = position.latitude;
  var longitude = position.longitude;
  String? address = '';
 
                  try{
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      latitude,longitude
                  );
                  if(placemarks!=null && placemarks.isNotEmpty){
                    Placemark placemark = placemarks[0];
                    print(placemark);
                    if(placemark.subLocality!=null && placemark.subLocality!.trim().isNotEmpty){
                     address ='${placemark.subLocality}, ${placemark.locality}';

                    }else{
                    address = placemark.locality;
                    }
                  }else{
                    print("Address not found");
                  }
                }catch(e){
                  print("Error fetching address: $e");
                }


  var request = http.MultipartRequest(
    'POST',
    Uri.parse(AppUrl.teacherregisterApiEndPoint),
  );
  request.fields['latitude'] = latitude.toString();
  request.fields['longitude'] = longitude.toString();
  request.fields['full_name'] = name;
  request.fields['phone_number'] = number;
  request.fields['email'] = email;
  request.fields['password'] = password;
  request.fields['address'] = address?? '';
  request.fields['password_confirmation'] = confirmpassword;
  request.fields['gender'] = gender;
  // request.fields['grade'] = selectedGrade;
  // request.fields['subjects'] = selectedSubjects.join(',');


  if (image != null) {
    var stream = http.ByteStream(image.openRead());
    var length = await image.length();
    var multipartFile = http.MultipartFile(
      'image',
      stream,
      length,
      filename: image.path,
    );
    request.files.add(multipartFile);
  }
 if (certificateFile != null) {
    var certificate = await http.MultipartFile.fromPath('certificate', certificateFile.path);
    request.files.add(certificate);
  }
  _signUpLoading = true;
  notifyListeners();
  // setSignUpLoading(true);
  // notifyListeners();

  try {
    var response = await request.send();

    var responsebody = await response.stream.bytesToString();
    print(responsebody);

    if (response.statusCode == 400) {
      // final snackBar = SnackBar(content: Text('Account already exists'),backgroundColor: Colors.red,);
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (response.statusCode == 201) {
      final snackBar = SnackBar(content: Text('Verify your email before login'),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Timer(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      });
    }
    if (response.statusCode == 400) {
      final Map<String, dynamic> responseBodyMap = json.decode(responsebody);
      if (responseBodyMap.containsKey('email')) {
        final errorMessage = responseBodyMap['email'][0];
        
        final snackBar = SnackBar(content: Text(errorMessage), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

  } on SocketException {
    // setSignUpLoading(false);
    // notifyListeners();
    final snackBar = SnackBar(content: Text('No Internet Connection'),backgroundColor: Colors.red,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  _signUpLoading = false;
  notifyListeners();
}

// Add Teacher
  Future<void> addteacher(BuildContext context,String email,String name,
  String number,String gender) async{
    var body = jsonEncode({
      
      'email':email,
      'full_name':name,
      'phone_number':number,
      'gender':gender
      
    });

    _signUpLoading = true;
    
    notifyListeners();
    try{
      http.Response response = await http.post(Uri.parse(AppUrl.addteacherApiEndPoint),headers: headers,
    body: body
    );
    
      if(response.statusCode ==400){
        
      }
        if(response.statusCode==201){
        final snackBar = SnackBar(content: Text('Account created successfully and mail sent to ${email}'),backgroundColor: Palette.theme1,);
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                         Timer(Duration(seconds: 2), (){
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>AdminMainPage()),
              );
        });



        }



      
    } on SocketException{
      final snackBar = SnackBar(content: Text('No Internet Connection'));
       ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // flushBarErrorMessage('NO Internet connection', context);
    }
    _signUpLoading = false;
    notifyListeners();
  }


  //Code for login
    Future<void> userLogin(BuildContext context,String email,String password) async{
    var body = jsonEncode({'email': email, 'password': password});
    _loading = true;
    
    notifyListeners();
    try{
      http.Response  response = await http.post(Uri.parse(AppUrl.loginEndPoint),body: body,headers: headers);
    print(response.body );
    var verify = jsonDecode(response.body);
    print(verify);
    print(response.statusCode);

    if(response.statusCode ==400){
      notifyListeners();
      final snackBar = SnackBar(content: Text('Invalid credentials'),backgroundColor: Colors.red,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
    if(response.statusCode ==401){
      notifyListeners();
      final snackBar = SnackBar(content: Text('email not verified'),backgroundColor:Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
    if (response.statusCode==200){
      
      var data = response.body;
      
      Teacher user = Teacher.fromReqBody(data);
      print(user.id);
      user.email = email;
      print(user.email);
      
      UserPreferences().saveUser(user);
     
      notifyListeners();
      // if(user.isStaff!=true){
      final snackBar = SnackBar(content: Text('Login success'),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      if(user.user_type =='admin'){
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>AdminMainPage(),
                // settings: RouteSettings(arguments:user.user_type )
                ),
              );


      }else{
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Home(),
                settings: RouteSettings(arguments:user.user_type )
                ),
              );

      }

      
      
    }
   
    }
    catch (e){
      SnackBar(
      content: Text(e.toString()),
    ) ;                                   
    }

    _loading = false;   

  }
// Forgot Password
Future<void> forgotPassword(BuildContext context,String email) async{

  var body = jsonEncode(
    {'email':email}
  );
  _loading = true;
  notifyListeners();
  try{
    http.Response response = await http.post(Uri.parse(AppUrl.resetpassword),body:body,headers:headers);
    print(response.statusCode);
    if(response.statusCode == 201){
      final snackbar = SnackBar(content:Text("Reset code has been sent to your email"),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Timer(Duration(seconds:3),(){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>PasswordVerify()));
      });

    }
    if(response.statusCode == 404){
      Flushbar(backgroundColor: Colors.red,
      message:"User with this email doesn't exist. Provide your email correctly ",
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(6),
      borderRadius: BorderRadius.circular(6),
      ).show(context);
    }
  }on SocketException {
    final snackBar = SnackBar(content: Text('No Internet Connection'),backgroundColor: Colors.red,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  _loading = false;
  notifyListeners();
}

Future<void> resetPasswordVerify(BuildContext context,String password,code) async{

  var body = jsonEncode(
    {'reset_code':code,
    'new_password':password
    }
  );
  _loading = true;
  notifyListeners();
  try{
    http.Response response = await http.post(Uri.parse(AppUrl.passwordverify),body:body,headers:headers);
print(response.body);
    if(response.statusCode == 200){
      final snackbar = SnackBar(content: Text("Password reset successfully, Login to continue"),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Timer(Duration(seconds:2),(){
        Navigator.push(context,MaterialPageRoute(builder:(context) => Login(),));
      });
      

    }
  }on SocketException {
    final snackBar = SnackBar(content: Text('No Internet Connection'),backgroundColor: Colors.red,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
    catch (e){
      SnackBar(
      content: Text(e.toString()),
    ) ;                                   
    }
  _loading = false;
  notifyListeners();
}

// Change Password
Future<void> changePassword(BuildContext context,String email,String oldpassword,String newpassword) async{

  var body = jsonEncode(
    {'email':email,
      'old_password':oldpassword,
      'new_password':newpassword
    
    }
  );
  _loading = true;
  notifyListeners();
  try{
    http.Response response = await http.post(Uri.parse(AppUrl.changepassword),body:body,headers:headers);

    if(response.statusCode == 201){
      final snackbar = SnackBar(content:Text("Password Change code has been sent to your email"),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Timer(Duration(seconds:3),(){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ChangePasswordVerify()));
      });

    }
    if(response.statusCode == 400){
      final snackbar = SnackBar(content:Text("Give your current password correctly"),backgroundColor:Colors.red,);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

    }
  }on SocketException {
    final snackBar = SnackBar(content: Text('No Internet Connection'),backgroundColor: Colors.red,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  _loading = false;
  notifyListeners();
}

Future<void> changePasswordVerify(BuildContext context,code) async{

  var body = jsonEncode(
    {'reset_code':code,
    
    }
  );
  _loading = true;
  notifyListeners();
  try{
    http.Response response = await http.post(Uri.parse(AppUrl.changepasswordverify),body:body,headers:headers);
print(response.body);
    if(response.statusCode == 200){
      final snackbar = SnackBar(content: Text("Password changed successfully"),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Timer(Duration(seconds:2),(){
        Navigator.push(context,MaterialPageRoute(builder:(context) => Login(),));
      });
      

    }
    else if(response.statusCode == 404){
      final snackbar = SnackBar(content: Text("Please re-check your email and enter correct code"),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      

    }

    
  }on SocketException {
    final snackBar = SnackBar(content: Text('No Internet Connection'),backgroundColor: Colors.red,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
    catch (e){
      SnackBar(
      content: Text(e.toString()),
    ) ;                                   
    }
  _loading = false;
  notifyListeners();
}


}