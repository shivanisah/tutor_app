import 'package:flutter/material.dart';
import 'package:tutor_app/FirstScreen/Home.dart';
import 'package:tutor_app/enrollmentConfirm/Confirmedstudentlist.dart';
import 'package:tutor_app/enrollments/enrollmentlist.dart';
import 'package:tutor_app/tutor/tutorprofiledetails.dart';
import 'package:tutor_app/utils/colors.dart';
// import 'package:tutor_app/widgets/timeslot1.dart';


import '../enrollmentCancel/enrollmentCancelList.dart';
import '../shared_preferences.dart/user_preferences.dart';
import '../tutor/tutorProfilePage.dart';
import '../widgets/finaltime.dart';
// import '../widgets/timeslot.dart';


class TutorDashboardDrawer extends StatefulWidget{
  @override
  State<TutorDashboardDrawer> createState() => _TutorDashboardDrawer();
}

class _TutorDashboardDrawer extends State<TutorDashboardDrawer> {
    final userPreferences = UserPreferences();
    String email = '';
    int? teacherId;
    String user_type = '';
    // String full_name='';
    // String? name ='';

  @override
  Widget build(BuildContext context) {
        userPreferences.getUser().then((teacher) {
      // ignore: unnecessary_null_comparison
      if (teacher != null) {
        setState(() {
          email = teacher.email?? '';
          user_type = teacher.user_type?? '';
          teacherId = teacher.id!;
          // full_name = teacher.full_name?? '';
          // print(user_type);
          // name = teacher.name;
          // print(name);
          // print(userId);
        });
      }
      else {
    // Handle the null scenario
    setState(() {
      email = '';
      user_type = '';
      teacherId = null;
      // full_name = '';
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
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => Home(),
                                            settings:RouteSettings(arguments: user_type)

                ));
              }
            ),
            ListTile(
              leading: Icon(Icons.person,color:Palette.theme1),
              title:Text("Profile"),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => TeacherProfilePage(),),
                // ModalRoute.withName('/'),
                );
              }
            ),
            Divider(),
             ListTile(
              leading: Icon(Icons.notifications,color:Palette.theme1),
              title:Text("Requests"),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => EnrollmentList(),
                            settings:RouteSettings(arguments: teacherId)

                ),
                );
              }
            ),
            ListTile(
              leading: Icon(Icons.people,color:Palette.theme1),
              title:Text("Enrolled Students"),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => ConfirmStudentList(),
                            settings:RouteSettings(arguments: teacherId)

                ),
                );
              }
            ),
            ListTile(
              leading: Icon(Icons.cancel,color:Palette.theme1),
              title:Text("Rejected"),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => RejectedStudentsList(),
                settings:RouteSettings(arguments: teacherId)

                ));
              }
            ),
            ListTile(
              leading: Icon(Icons.lock_clock,color:Palette.theme1),
              title:Text("Time Slot"),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => MultipleTimePick(),
                                settings:RouteSettings(arguments: teacherId)

                ),
                // ModalRoute.withName('/'),
                );
              }
            ),
            ListTile(
              leading: Icon(Icons.person,color:Palette.theme1),
              title:Text("Profile Detail"),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => TutorProfileDetailPage(),
                settings:RouteSettings(arguments: teacherId)

                ));
              }
            ),








          ],
      )
    );



    


  }

}
