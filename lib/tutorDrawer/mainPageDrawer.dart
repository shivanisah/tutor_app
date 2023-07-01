import 'package:flutter/material.dart';
import 'package:tutor_app/tutor/tutorDashboard.dart';
import 'package:tutor_app/utils/colors.dart';

import '../shared_preferences.dart/user_preferences.dart';


class TutorMainPageDrawer extends StatefulWidget{
  @override
  State<TutorMainPageDrawer> createState() => _TutorMainPageDrawer();
}

class _TutorMainPageDrawer extends State<TutorMainPageDrawer> {
    final userPreferences = UserPreferences();
    String email = '';


  @override
  Widget build(BuildContext context) {
            userPreferences.getUser().then((teacher) {
      setState(() {
        email = teacher.email?? '';
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
              leading: Icon(Icons.dashboard,color:Palette.theme1),
              title:Text("Dashboard"),
              trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => TutorDashboard(),),
                // ModalRoute.withName('/'),
                );
              }
            ),

          ],
      )
    );



    


  }

}
