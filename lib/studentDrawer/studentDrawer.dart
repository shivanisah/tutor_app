import 'package:flutter/material.dart';
import 'package:tutor_app/admin/adminMainpage.dart';
import 'package:tutor_app/utils/colors.dart';

import '../shared_preferences.dart/user_preferences.dart';


class StudentDrawer extends StatefulWidget{
  @override
  State<StudentDrawer> createState() => _StudentDrawer();
}

class _StudentDrawer extends State<StudentDrawer> {
  final userPreferences = UserPreferences();
    String email = '';



  @override
  Widget build(BuildContext context) {
    userPreferences.getUser().then((teacher) {
      setState(() {
        email = teacher.email!;
        // teacherId = teacher.id!;
      });
    });  


    return Drawer(
      child:ListView(
        padding:EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(accountName: Text(""), accountEmail: Text(email),
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
            
            ),
            ListTile(
              leading: Icon(Icons.person,color:Palette.theme1),
              title:Text("Profile"),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                // Navigator.push(context,MaterialPageRoute(builder: (context) => TutorDashboard(),),
                // // ModalRoute.withName('/'),
                // );
              }
            ),
            ListTile(
              leading: Icon(Icons.notifications,color:Palette.theme1),
              title:Text("Notification"),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                // Navigator.push(context,MaterialPageRoute(builder: (context) => TutorDetailScreen(),));
                // // ModalRoute.withName('/'),
                // );
              }
            ),
            ListTile(
              leading: Icon(Icons.history,color:Palette.theme1),
              title:Text("History"),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                // Navigator.push(context,MaterialPageRoute(builder: (context) => TutorDashboard(),),
                // // ModalRoute.withName('/'),
                // );
              }
            ),

            ListTile(
              leading: Icon(Icons.person,color:Palette.theme1),
              title:Text("Admin"),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => AdminMainPage(),),
                // // ModalRoute.withName('/'),
                );
              }
            ),

          ],
      )
    );



    


  }

}
