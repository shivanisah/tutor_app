import 'package:flutter/material.dart';
import 'package:tutor_app/tutorDrawer/tutorDashboardDrawer.dart';



class TutorDashboard extends StatefulWidget{
  @override
  State<TutorDashboard> createState() => _TutorDashboard();
}

class _TutorDashboard extends State<TutorDashboard> {





  @override
  Widget build(BuildContext context) {


    return Scaffold(
      drawer:TutorDashboardDrawer(),
      appBar:AppBar(

          title:Center(child: Text("Dashboard",style:TextStyle(fontStyle:FontStyle.italic))),
      ),

      body:Container(
        // child:TeacherProfilePage(),
      )

    );



    


  }

}
