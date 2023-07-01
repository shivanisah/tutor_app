import 'package:flutter/material.dart';
import 'package:tutor_app/screens/auth_screens/teacherSignUpscreen.dart';
import 'package:tutor_app/utils/colors.dart';


class AdminDrawer extends StatefulWidget{
  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {


    return Drawer(
      child:ListView(
        padding:EdgeInsets.zero,
          children: [
            Builder(
              builder: (BuildContext context) {
                return UserAccountsDrawerHeader(accountName: Text(""), accountEmail: Text("admin@gmail.com"),
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
              onTap:(){
                // Navigator.push(context,MaterialPageRoute(builder: (context) => Home(),
                //                             settings:RouteSettings(arguments: user_type)

                // ));
              }
            ),
            Divider(),
             ListTile(
              leading: Icon(Icons.person_add,color:Palette.theme1),
              title:Text("Add Teachers"),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => TutorRegistration(),

                ),
                );
              }
            ),







          ],
      )
    );



    


  }

}
