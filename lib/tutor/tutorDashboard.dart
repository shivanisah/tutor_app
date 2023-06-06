import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/tutor/tutorProfilePage.dart';
import 'package:tutor_app/tutorDrawer/tutorDashboardDrawer.dart';

import '../providers/auth_provider.dart';
import '../utils/colors.dart';


class TutorDashboard extends StatefulWidget{
  @override
  State<TutorDashboard> createState() => _TutorDashboard();
}

class _TutorDashboard extends State<TutorDashboard> {
    TextEditingController addressController=TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


@override
void dispose(){
  addressController.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
      final provider = Provider.of<AuthProvider>(context,listen: false);


double width = MediaQuery.of(context).size.width;
double height = MediaQuery.of(context).size.height;


    return Scaffold(
      drawer:TutorDashboardDrawer(),
      appBar:AppBar(

          // title:Center(child: Text("Welcome ")),
      ),

      body:Container(
        // child:TeacherProfilePage(),
      )

    );



    


  }

}
