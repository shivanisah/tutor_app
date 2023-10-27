import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/screens/auth_screens/changepassword.dart';
import 'package:tutor_app/student/completeregistrationPage.dart';
import 'package:tutor_app/student/enrollmentHistory.dart';
import 'package:tutor_app/student/notificationList.dart';
import 'package:tutor_app/student/profiledetail.dart';
import 'package:tutor_app/utils/colors.dart';

import '../providers/student_provider.dart';
import '../shared_preferences.dart/user_preferences.dart';


class StudentDrawer extends StatefulWidget{
  @override
  State<StudentDrawer> createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer> {
  final userPreferences = UserPreferences();
    String email = '';
    int? studentId;
    bool loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  Future<void>  fetchData()async{
    try{
          final studentProfileProvider = Provider.of<StudentProvider>(context);
          final student = await userPreferences.getUser();
    // ignore: unnecessary_null_comparison
    if (student != null) {
      setState(() {
        studentId = student.id!;
      });
      } else {
      setState(() {
        studentId = null;
      });
    }

          await studentProfileProvider.fetchStudentProfile(studentId!);

    }catch(error){

    }finally{
      setState(() {
        loading = false;
      });
    }
  }

    

  @override
  Widget build(BuildContext context) {
    userPreferences.getUser().then((student) {
      setState(() {
        email = student.email!;
        studentId = student.id!;
      });
    }); 
    final studentProfileProvider = Provider.of<StudentProvider>(context);
    final profile = studentProfileProvider.studentProfile;
   
 final provider = Provider.of<StudentProvider>(context,listen:false);
 provider.notificationCount(studentId!);

    return profile==null?SizedBox.shrink():Drawer(
      child:ListView(
        padding:EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(accountName: Text(""), accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              child:ClipOval(child: Image.asset("assets/images/teacherimg.png",
              width:90,
              height:90,
              fit:BoxFit.cover,
              ),
              
              )
            ),
            // decoration:BoxDecoration(

            // )
            
            ),
            profile.name == null?
            ListTile(
              leading: Icon(Icons.person,color:Palette.theme1),
              title:Text("Profile"),
              
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => StudentCompleteRegistrationPage(),),
                // ModalRoute.withName('/'),
                );
              }
              
            ):
          ListTile(
              leading: Icon(Icons.person,color:Palette.theme1),
              title:Text("Profile"),
              
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => StudentProfileDetailPage(),
                settings: RouteSettings(arguments: studentId)
                ),
                // ModalRoute.withName('/'),
                );
              }
              
            ),

            Consumer<StudentProvider>(
              builder: (context,provider,_){
                int notificationcount =provider.notification_count;
                  return  ListTile(
              leading: Badge(
                label:Text('$notificationcount',style:TextStyle(color:Colors.white)),
                child:Icon(Icons.notifications,color:Palette.theme1),
                isLabelVisible: notificationcount == 0?false:true,
                
              ),
              // Icon(Icons.notifications,color:Palette.theme1),
              title: Text("Notification"),
                
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationList(),
                settings: RouteSettings(arguments:studentId)
                
                ),
                
                );
              }
            );

              }
            ),
            // ListTile(
            //   leading: Icon(Icons.notifications,color:Palette.theme1),
            //   title:
            //   Badge(
            //     badgeContent:Consumer<StudentProvider>(
            //       builder:(context,provider,_){
            //   int notificationcount = provider.notification_count;
            //   return Text('$notificationcount',style:TextStyle(color:Colors.white));
            //       }
            //     ),
            //     badgeColor:Colors.red,
            //     child:Text("Notification"),
            //   ),
              
              
            //   // Text("Notification"),
            //   onTap:(){
            //     Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationList(),
            //     settings: RouteSettings(arguments:studentId)
                
            //     ),
                
            //     );
            //   }
            // ),
            ListTile(
              leading: Icon(Icons.history,color:Palette.theme1),
              title:Text("History"),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => EnrollmentHistory(),
                settings: RouteSettings(arguments: studentId)
                ),
                );
              }
            ),
            ListTile(
              leading: Icon(Icons.key,color:Palette.theme1),
              title:Text("Change Password"),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => ChangePassword(),
                ),
                );
              }
            ),


          ],
      )
    );



    


  }

}
