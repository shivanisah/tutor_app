import "package:flutter/material.dart";

import "../location/enablelocation.dart";
import "../location/map.dart";
import "../screens/auth_screens/login.dart";
import "../screens/auth_screens/teacherSignUpscreen.dart";


class AppB extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;

    return    AppBar(
      // toolbarHeight: size.height*0.6, // Increase the height of the AppBar
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.vertical(
      //         bottom: Radius.circular(30), // Make the AppBar curved
      //       ),
      //     ),
        // backgroundColor: Colors.blueAccent,
        elevation:0,
        iconTheme: IconThemeData(color:Colors.white),
        title:Center(child: Text("Tutor App",
        style:TextStyle(
          fontWeight:FontWeight.w500,
          fontStyle:FontStyle.italic,
          color:Colors.white,
        )
        )),
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