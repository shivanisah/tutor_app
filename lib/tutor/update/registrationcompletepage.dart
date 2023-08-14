import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_app/tutor/tutorProfilePage.dart';
import 'package:tutor_app/utils/colors.dart';


class CompleteRegistrationPage extends StatefulWidget{


  @override
  State<CompleteRegistrationPage> createState() => _CompleteRegistrationPageState();
}

class _CompleteRegistrationPageState extends State<CompleteRegistrationPage> {


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    // double width =  MediaQuery.of(context).size.width;
    

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
      ),
      body:Container(
        margin:EdgeInsets.only(left:20,right:20),
        child:Column(children: [
              SizedBox(height:height*0.4),
              Center(child: Text("Complete your",
                style:  GoogleFonts.poppins(
                fontSize:  26,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color:  Color(0xff000000),
                  ),

              )),
                Center(child: Text("registration!",
                style:  GoogleFonts.poppins(
                fontSize:  26,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color:  Color(0xff000000),
                  ),

              )),

            SizedBox(height:height*0.24),
            GestureDetector(
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => TeacherProfilePage(),
                
                ));
              },
              child:Container(
                height:50,
                width:350,
                margin:EdgeInsets.all(5),
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color:Palette.theme1
                ),
                child:
                    
                Center(child: Text("Complete Signup",
                style:  GoogleFonts.poppins(
                fontSize:  20,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.white,
                  ),

                ))            
                
              )
            )

        ],)
      )
      
        );

  }

}
