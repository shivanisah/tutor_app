import 'package:flutter/material.dart';

import '../shared_preferences.dart/user_preferences.dart';
import 'enrollmentlist.dart';


class FetchButtonEnrollment extends StatefulWidget{
  @override
  State<FetchButtonEnrollment> createState() => _FetchButtonEnrollmentState();
}

class _FetchButtonEnrollmentState extends State<FetchButtonEnrollment> {


  @override
  Widget build(BuildContext context) {
  final userPreferences = UserPreferences();
    int? userId;

    // Retrieve the id value from UserPreferences
    userPreferences.getUser().then((teacher) {
      if (teacher != null) {
        setState(() {
          userId = teacher.id;
          print(userId);
        });
      }
    });  

    return Scaffold(
      body:Container(
        margin: EdgeInsets.only(top:200),
        child:ElevatedButton(child: Text("enrolled students"),
        onPressed:(){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => EnrollmentList(),
          settings:RouteSettings(arguments: userId)
          ));
        }
        )

      )
    );



    


  }

}
