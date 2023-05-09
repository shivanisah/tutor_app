import "package:flutter/material.dart";

import "../location/enablelocation.dart";
import "../location/map.dart";
import "../screens/auth_screens/login.dart";
import "../screens/auth_screens/loginscreen.dart";
import "../screens/auth_screens/teacherSignUpscreen.dart";


class AppB extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return       AppBar(
        backgroundColor: Colors.blueAccent,
        iconTheme: IconThemeData(color:Colors.black),
        title:Center(child: Text("Tutor App",style:TextStyle(
          fontWeight:FontWeight.w500,
          fontStyle:FontStyle.italic,
          color:Colors.black,
        ))),
        actions: [
          IconButton(
              icon:Icon(Icons.settings),
              tooltip:"Setting Icon",
              onPressed:(){

              }

          ),
        ],
        // elevation:200,
        leading:IconButton(
            icon:Icon(Icons.menu),
            onPressed:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>TutorRegistration()),
              );

            }

        )
    );

  }

}