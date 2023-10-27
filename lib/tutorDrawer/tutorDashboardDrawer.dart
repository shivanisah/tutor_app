import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/enrollmentConfirm/Confirmedstudentlist.dart';
import 'package:tutor_app/enrollments/enrollmentlist.dart';
import 'package:tutor_app/filteration/teacherlistfilter.dart';
import 'package:tutor_app/providers/teacherlistprovider.dart';
import 'package:tutor_app/screens/auth_screens/changepassword.dart';
import 'package:tutor_app/tutor/notificationList.dart';
import 'package:tutor_app/tutor/tutorWidgets/classsubject.dart';
import 'package:tutor_app/tutor/tutorprofiledetails.dart';
import 'package:tutor_app/tutor/update/registrationcompletepage.dart';
import 'package:tutor_app/utils/colors.dart';
import 'package:tutor_app/widgets/teachingtime.dart';


import '../Apis/teacherList.dart';
import '../app_urls/app_urls.dart';
import '../enrollmentCancel/enrollmentCancelList.dart';
import '../providers/teacherProfileprovider.dart';
import '../shared_preferences.dart/user_preferences.dart';
import '../widgets/finalTimeSlot.dart';
import '../widgets/finaltime.dart';


class TutorDashboardDrawer extends StatefulWidget{
  @override
  State<TutorDashboardDrawer> createState() => _TutorDashboardDrawerState();
}

class _TutorDashboardDrawerState extends State<TutorDashboardDrawer> {
    final userPreferences = UserPreferences();
    String email = '';
    int? teacherId;
    String user_type = '';
    bool loading = true;
  TeacherList teacherlist = TeacherList();

 @override
 void initState(){
  super.initState();

  fetchData();
 }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   fetchData();
  // }

  Future<void>  fetchData()async{
    try{
          final teacherProfileProvider = Provider.of<TeacherProfileProvider>(context,listen:false);
          final teacher = await userPreferences.getUser();
    if (teacher != null) {
      setState(() {
        teacherId = teacher.id!;
        print(teacherId);
      });
      } else {
      setState(() {
        teacherId = null;
      });
    }

          await teacherProfileProvider.fetchTeacherProfile(teacherId!);

    }catch(error){

    }finally{
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

  //   userPreferences.getUser().then((teacher) {
    
  //       setState(() {
  //         email = teacher.email?? '';
  //         user_type = teacher.user_type?? '';
  //         teacherId = teacher.id;
  //       });
      
    
  //  });  
   

  final teacherProfileProvider = Provider.of<TeacherProfileProvider>(context,listen:false);
  // teacherProfileProvider.fetchTeacherProfile(teacherId!);
  final profile = teacherProfileProvider.teacherProfile;
  final provider = Provider.of<TeacherProfileProvider>(context,listen:false);
  provider.notificationCount(teacherId!);
  final enrollprovider = Provider.of<TeacherProfileProvider>(context);
  enrollprovider.enrollnotificationCount(teacherId!);

  String imageUrl = '';
  if(profile!=null){
       imageUrl = profile.image?? "assets/images/d1.jpg";

  }else{
    print('image error');
  }




    return profile==null?SizedBox.shrink():Drawer(
      child:ListView(
        padding:EdgeInsets.zero,
          children: [
            Builder(
              builder: (BuildContext context) {
                if(loading){
                  return SizedBox.shrink();
                }else{

                return UserAccountsDrawerHeader(accountName: Text(profile.fullName,
                style:  GoogleFonts.poppins(
                fontSize:  20,
                fontWeight:  FontWeight.w400,
                height:  1.5,
                // color:  ,
                  ),
               ), 
                accountEmail: Text(profile.phoneNumber,style:  GoogleFonts.poppins(
                fontSize:  14,
                fontWeight:  FontWeight.w400,
                // height:  1.5,
                color:  Color.fromARGB(255, 238, 231, 231),
                  ),
                 ),
                currentAccountPicture: CircleAvatar(
                  radius:60,
                  child:ClipOval(child: 
                profile.image!=null?
                Image.network(AppUrl.baseUrl+imageUrl,
                width:150,
                height:120,
                fit:BoxFit.cover,
                alignment: Alignment.topCenter,
                  
                ):
                Image.asset("assets/images/teacherimg.png",
                width:150,
                height:120,
                fit:BoxFit.cover,
                ),
                  
                  )
                ),
                // decoration:BoxDecoration(

                // )
                
                );
                }
              }
            ),
            // ListTile(
            //   leading: Icon(Icons.home,color:Palette.theme1),
            //   title:Text("Home"),
            //   // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
            //   onTap:(){
            //     Navigator.push(context,MaterialPageRoute(builder: (context) => Home(),
            //                                 settings:RouteSettings(arguments: user_type)

            //     ));
            //   }
            // ),
            profile.teaching_location==null?
            ListTile(
              leading: Icon(Icons.person,color:Palette.theme1),
              title:Text("Profile",
                style:  GoogleFonts.poppins(
                fontSize:  15,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                // color:  ,
                  ),

              ),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => CompleteRegistrationPage(),),
                // ModalRoute.withName('/'),
                );
              }
            ):ListTile(
              leading: Icon(Icons.person_rounded,color:Palette.theme1),
              title:Text("Profile",
                style:  GoogleFonts.poppins(
                fontSize:  15,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                  ),

              ),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => TutorProfileDetailPage(),
                settings:RouteSettings(arguments: teacherId)

                ));
              }
            ),
            Consumer<TeacherProfileProvider>(
              builder: (context,provider,_){
                int notificationcount = provider.notification_count;
                  return  ListTile(
              leading: Badge(
                label:Text('$notificationcount',style:TextStyle(color:Colors.white)),
                child:Icon(Icons.notifications,color:Palette.theme1),
                isLabelVisible: notificationcount == 0?false:true,
                
              ),
              // Icon(Icons.notifications,color:Palette.theme1),
              title: Text("Notifications",
                style:  GoogleFonts.poppins(
                fontSize:  15,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                  ),

              ),
                
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>TeacherNotificationList(profile),
                settings: RouteSettings(arguments:teacherId)
                
                ),
                
                );
              }
            );

              }
            ),
            // ListTile(
            //   leading: Icon(Icons.notifications,color:Palette.theme1),
            //   title:Text("Notifications",
            //     style:  GoogleFonts.poppins(
            //     fontSize:  15,
            //     fontWeight:  FontWeight.w500,
            //     height:  1.5,
            //       ),

            //   ),
            //   // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
            //   onTap:(){
            //     Navigator.push(context,MaterialPageRoute(builder: (context) => TeacherUpdateCertificate(profile),),
            //     // ModalRoute.withName('/'),
            //     );
            //   }
            // ),
             ListTile(
              leading: Icon(Icons.key,color:Palette.theme1),
              title:Text("Change Password",
                style:  GoogleFonts.poppins(
                fontSize:  15,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                  ),

              ),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => ChangePassword(),

                ),
                );
              }
            ),

            Divider(),

            Consumer<TeacherProfileProvider>(
              builder: (context,provider,_){
                int enrollnotificationcount = enrollprovider.enrollnotification_count;
                  return  ListTile(
              leading: Badge(
                label:Text('$enrollnotificationcount',style:TextStyle(color:Colors.white)),
                child:Icon(Icons.notifications,color:Palette.theme1),
                isLabelVisible: enrollnotificationcount == 0?false:true,
                
              ),
              // Icon(Icons.notifications,color:Palette.theme1),
              title: Text("Enrollment Requests",
                style:  GoogleFonts.poppins(
                fontSize:  15,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                  ),

              ),
                
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => EnrollmentList(),
                            settings:RouteSettings(arguments: teacherId)
                
                ),
                
                );
              }
            );

              }
            ),


            //  ListTile(
            //   leading: Icon(Icons.notifications,color:Palette.theme1),
            //   title:Text("Enrollment Requests",
            //     style:  GoogleFonts.poppins(
            //     fontSize:  15,
            //     fontWeight:  FontWeight.w500,
            //     height:  1.5,
            //       ),

            //   ),
            //   // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
            //   onTap:(){
            //     Navigator.push(context,MaterialPageRoute(builder: (context) => EnrollmentList(),
            //                 settings:RouteSettings(arguments: teacherId)

            //     ),
            //     );
            //   }
            // ),
            ListTile(
              leading: Icon(Icons.people,color:Palette.theme1),
              title:Text("Enrolled Students",
                style:  GoogleFonts.poppins(
                fontSize:  15,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                  ),

              ),
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
              title:Text("Rejected Enrollments",
                style:  GoogleFonts.poppins(
                fontSize:  15,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                  ),

              ),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => RejectedStudentsList(),
                settings:RouteSettings(arguments: teacherId)

                ));
              }
            ),
            // ListTile(
            //   leading: Icon(Icons.access_time,color:Palette.theme1),
            //   title:Text("Time Slots",
            //     style:  GoogleFonts.poppins(
            //     fontSize:  15,
            //     fontWeight:  FontWeight.w500,
            //       ),

            //   ),
            //   // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
            //   onTap:(){
            //     Navigator.push(context,MaterialPageRoute(builder: (context) => TeachingTime(),
            //                     settings:RouteSettings(arguments: teacherId)

            //     ),
            //     // ModalRoute.withName('/'),
            //     );
            //   }
            // ),

            ListTile(
              leading: Icon(Icons.access_time,color:Palette.theme1),
              title:Text("Time Slots",
                style:  GoogleFonts.poppins(
                fontSize:  15,
                fontWeight:  FontWeight.w500,
                  ),

              ),
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
              leading: Icon(Icons.note_add,color:Palette.theme1),
              title:Text("Class and Subjects",
                style:  GoogleFonts.poppins(
                fontSize:  15,
                fontWeight:  FontWeight.w500,
                  ),

              ),
              // trailing:Icon(Icons.arrow_forward,color:Palette.theme1),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => RetrieveClassSubject(),
                                settings:RouteSettings(arguments: teacherId)

                ),
                // ModalRoute.withName('/'),
                );
              }
            ),

            ListTile(
              leading: Icon(Icons.filter_list_rounded,color:Palette.theme1),
              title:Text("Filter",
                style:  GoogleFonts.poppins(
                fontSize:  15,
                fontWeight:  FontWeight.w500,
                  ),

              ),
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => TeacherListFilter(),

                ),
                );
              }
            ),








          ],
      )
    );



    


  }

}
