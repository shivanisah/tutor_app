import 'package:flutter/material.dart';
import 'package:tutor_app/admin/addTeacher.dart';
import 'package:tutor_app/admin/adminMainpage.dart';
import 'package:tutor_app/screens/auth_screens/changepassword.dart';
import 'package:tutor_app/screens/auth_screens/login.dart';
import 'package:tutor_app/screens/auth_screens/teacherSignUpscreen.dart';
import 'package:tutor_app/utils/colors.dart';

import '../FirstScreen/Home.dart';
import '../shared_preferences.dart/user_preferences.dart';


class AdminDrawer extends StatefulWidget{
  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
    final userPreferences = UserPreferences();
    String email = '';
    String user_type = '';

  @override
  Widget build(BuildContext context) {
    userPreferences.getUser().then((admin) {
      setState(() {
        email = admin.email!;
        user_type= admin.user_type!;
      });
    });  



    return Drawer(
      child:ListView(
        padding:EdgeInsets.zero,
          children: [
            Builder(
              builder: (BuildContext context) {
                return UserAccountsDrawerHeader(accountName: Text(""), accountEmail: Text(email),
                currentAccountPicture: CircleAvatar(
                  child:ClipOval(child: Image.asset("assets/images/blankimage.png",
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
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => Home(),
                                            settings:RouteSettings(arguments: user_type)

                ));
              }
            ),

            ListTile(
              leading: Icon(Icons.dashboard,color:Palette.theme1),
              title:Text("Dashboard"),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => AdminMainPage(),
                                            settings:RouteSettings(arguments: user_type)

                ));
              }
            ),
            ListTile(
              leading: Icon(Icons.key,color:Palette.theme1),
              title:Text("Change Password"),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => ChangePassword(),

                ));
              }
            ),


            Divider(),
             ListTile(
              leading: Icon(Icons.person_add,color:Palette.theme1),
              title:Text("Add Teachers"),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => AddTeacher(),

                ),
                );
              }
            ),
             ListTile(
              leading: Icon(Icons.logout,color:Palette.theme1),
              title:Text("Logout"),
              onTap:(){
                UserPreferences().removeUser();
                popallScreens(context);

                // Navigator.push(context,MaterialPageRoute(builder: (context) => Login(),

                // ),
                // );
              }
            ),








          ],
      )
    );



    


  }
    void popallScreens(BuildContext context) {

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>Login()), (route) => false);

  
  }


}
