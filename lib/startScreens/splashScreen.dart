import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_app/admin/adminMainpage.dart';
import 'package:tutor_app/startScreens/startPage.dart';

import '../FirstScreen/Home.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
    @override
  void initState(){
    Timer(Duration(seconds: 1),()=>getUser());
    super.initState();
  }
    getUser()async{
    

    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    var email = preferences.getString('email');
    var user_type = preferences.getString('user_type');
    // bool? is_staff = preferences.getBool('is_staff');
    if(email!=null && user_type!='admin'){
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Home(),
                     settings: RouteSettings(arguments:user_type )

     ));
     
    }
    else if(email!=null && user_type == 'admin'){
           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => AdminMainPage(),
                     settings: RouteSettings(arguments:user_type )));

    }
    else{
           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => AccountPage(),));

    }
    
  } 



  @override
  Widget build(BuildContext context) {

    return Scaffold();



    


  }

}
