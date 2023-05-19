

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import '../FirstScreen/Home.dart';
import '../app_urls/app_urls.dart';
import 'dart:io';

import '../models/user_models/teacher_model.dart';
import '../screens/auth_screens/login.dart';
import '../screens/auth_screens/loginscreen.dart';
import 'package:http/http.dart' as http;


class AuthProvider extends ChangeNotifier{
  bool _signUpLoading = false ;
  bool get signUpLoading => _signUpLoading ;
  bool _loading = false ;
  bool get loading => _loading ;



  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }


  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  Map<String,String> headers = {                           
       "Content-Type": "application/json; charset=UTF-8" };  



  // Future<void> userSignup(BuildContext context,String name,String number,String email,String address,
  // String password,String confirmpassword,File? url) async{
  //   var body = jsonEncode({
  //     'full_name':name,
  //     'phone_number':number,
  //     'email':email,
  //     'password':password,
  //     'address':address,
  //     'password_confirmation':confirmpassword,
  //     'image':url
  //     // 'teaching_grades':selectedgrade,
  //     // 'subjects':selectedsubjects
  //   });

  //       setSignUpLoading(true);
    
  //   notifyListeners();
  //   try{
  //     Response response = await post(Uri.parse(AppUrl.teacherregisterApiEndPoint),headers: headers,
  //   body: body
  //   );
    
  //     var responsebody = response.body;
  //     print(responsebody);
  //     var mssg = jsonDecode(responsebody);
  //     print(mssg['non_field_errors']);
  //     print(responsebody.contains("non_field_errors"));
  //     print(response.statusCode);
  //     if(response.statusCode ==400){
  //       setSignUpLoading(false);
  //       notifyListeners();
  //      final snackBar = SnackBar(content: Text('Account already exits'));
  //      ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
  //     }
  //     // if(response.statusCode==200){
  //     //   setSignUpLoading(false);
        
  //     //   notifyListeners();
  //       // final snackBar = SnackBar(content: Text('Verify your email before login'));
  //       //  ScaffoldMessenger.of(context).showSnackBar(snackBar);

  //       // flushBarErrorMessage('Verify your email before login', context);


  //       // }
  //       if(response.statusCode==201){
  //       setSignUpLoading(false);
        
  //       notifyListeners();
  //       final snackBar = SnackBar(content: Text('Verify your email before login'));
  //        ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //                        Timer(Duration(seconds: 2), (){
  //                Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) =>LoginPage()),
  //             );
  //       });

  //       // flushBarErrorMessage('Verify your email before login', context);


  //       }



      
  //   } on SocketException{
  //     setSignUpLoading(false);
  //     final snackBar = SnackBar(content: Text('No Internet Connection'));
  //      ScaffoldMessenger.of(context).showSnackBar(snackBar);

  //     // flushBarErrorMessage('NO Internet connection', context);
  //   }
  // }


//tutor registration

Future<void> userSignup(
  BuildContext context,
  String name,
  String number,
  String email,
  String address,
  String password,
  String confirmpassword,
  File? image,
  String selectedGrade,
  List<String> selectedSubjects,
)async {
  var position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  var latitude = position.latitude;
  var longitude = position.longitude;
 


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
  request.fields['address'] = address;
  request.fields['password_confirmation'] = confirmpassword;
  request.fields['grade'] = selectedGrade;
  request.fields['subjects'] = selectedSubjects.join(',');


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

  setSignUpLoading(true);
  notifyListeners();

  try {
    var response = await request.send();

    var responsebody = await response.stream.bytesToString();
    print(responsebody);

    if (response.statusCode == 400) {
      setSignUpLoading(false);
      notifyListeners();
      final snackBar = SnackBar(content: Text('Account already exists'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (response.statusCode == 201) {
      setSignUpLoading(false);
      notifyListeners();
      final snackBar = SnackBar(content: Text('Verify your email before login'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Timer(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      });
    }
  } on SocketException {
    setSignUpLoading(false);
    final snackBar = SnackBar(content: Text('No Internet Connection'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}


  //Code for login
    Future<void> userLogin(BuildContext context,String email,String password) async{
    var body = jsonEncode({'email': email, 'password': password});
    setLoading(true);
    
    notifyListeners();
    try{
      Response  response = await post(Uri.parse(AppUrl.loginEndPint),body: body,headers: headers);
    // print(response.body );
    var verify = jsonDecode(response.body);
    print(verify);
    print(response.statusCode);

    if(response.statusCode ==400){
      setLoading(false);
      notifyListeners();
      final snackBar = SnackBar(content: Text('Incorrect password'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
    if(response.statusCode ==401){
      setLoading(false);
      notifyListeners();
      final snackBar = SnackBar(content: Text('email not verified'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
    if (response.statusCode==200){
      
      setLoading(false);
      var data = response.body;
      
      Teacher user = Teacher.fromReqBody(data);
      print(user.id);
      user.email = email;
      print(user.email);
      
      // UserPreferences().saveUser(user);
     
      notifyListeners();
      // if(user.isStaff!=true){
      final snackBar = SnackBar(content: Text('Login success'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);


       Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Home()),
              );

      
      
    }
   
    }catch (e){
      SnackBar(
      content: Text(e.toString()),
    ) ;                                   
    }
    
    
    
    
    
    
    

  }


}