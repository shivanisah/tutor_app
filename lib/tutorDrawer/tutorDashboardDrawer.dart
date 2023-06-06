import 'package:flutter/material.dart';
import 'package:tutor_app/FirstScreen/Home.dart';
import 'package:tutor_app/enrollments/fetchbutton.dart';
import 'package:tutor_app/tutor/tutorDashboard.dart';
import 'package:tutor_app/utils/colors.dart';

import '../shared_preferences.dart/user_preferences.dart';
import '../tutor/tutorProfilePage.dart';


class TutorDashboardDrawer extends StatefulWidget{
  @override
  State<TutorDashboardDrawer> createState() => _TutorDashboardDrawer();
}

class _TutorDashboardDrawer extends State<TutorDashboardDrawer> {


  @override
  Widget build(BuildContext context) {
    final userPreferences = UserPreferences();
    // String? name;
    String email = '';

    // Retrieve the id value from UserPreferences
    userPreferences.getUser().then((teacher) {
      if (teacher != null) {
        setState(() {
          email = teacher.email!;
          print(email);
          // print(userId);
        });
      }
    });  
    return Drawer(
      child:ListView(
        padding:EdgeInsets.zero,
          children: [
            Builder(
              builder: (BuildContext context) {
                return UserAccountsDrawerHeader(accountName: Text(""), accountEmail: Text(email),
                currentAccountPicture: CircleAvatar(
                  child:ClipOval(child: Image.asset("assets/images/d1.jpg",
                  width:90,
                  height:90,
                  fit:BoxFit.cover,
                  ),
                  
                  )
                ),
                // decoration:BoxDecoration(

                // )
                
                );
              }
            ),
            ListTile(
              leading: Icon(Icons.home,color:Palette.theme1),
              title:Text("Home"),
              trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Home(),));
              }
            ),
            ListTile(
              leading: Icon(Icons.person,color:Palette.theme1),
              title:Text("Profile"),
              trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => TeacherProfilePage(),));
              }
            ),
            Divider(),
             ListTile(
              leading: Icon(Icons.notifications,color:Palette.theme1),
              title:Text("Requests"),
              trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => FetchButtonEnrollment(),));
              }
            ),
            ListTile(
              leading: Icon(Icons.people,color:Palette.theme1),
              title:Text("Enrolled Students"),
              trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => FetchButtonEnrollment(),));
              }
            ),
            ListTile(
              leading: Icon(Icons.cancel,color:Palette.theme1),
              title:Text("Rejected"),
              trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => FetchButtonEnrollment(),));
              }
            )




          ],
      )
    );



    


  }

}
