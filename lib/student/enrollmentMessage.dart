import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../FirstScreen/Home.dart';
import '../shared_preferences.dart/user_preferences.dart';
import '../utils/colors.dart';


class EnrollmentMessage extends StatefulWidget{
  @override
  State<EnrollmentMessage> createState() => _EnrollmentMessage();
}

class _EnrollmentMessage extends State<EnrollmentMessage> {

  final userPreferences = UserPreferences();
  String user_type = "";


  @override
  Widget build(BuildContext context) {

    userPreferences.getUser().then((teacher){
          setState(() {
            user_type = teacher.user_type?? '';
          });
    });

    return Scaffold(
      appBar: AppBar(

        leading:IconButton(
          icon:Icon(Icons.arrow_back) ,
          onPressed:(){
            Navigator.pushReplacement(
              context,MaterialPageRoute(builder:(context)=>Home(),
              settings:RouteSettings(arguments: user_type)
              )
            );
          }
          )
      ),
      body:Container(
        color: Colors.white,
        // margin:EdgeInsets.only(top:160),
        child:Column(
          children: [
          
          Center(child: Container(
            margin:EdgeInsets.only(top:100),
            child: Image.asset('assets/images/enrollmentformsuccess.jpeg',))),

                        SizedBox(height:30),
            Text(
               'Thanks for Enrollment!',
               style:  GoogleFonts.poppins(

              fontSize:  25,
                  fontWeight:  FontWeight.w500,
                  height:  1.5,
                color:  Color(0xff000000),

                )
            ),
            SizedBox(height:6),
            Text(
               "We'll review your request and get back to you!",
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  height:  1.5,
                color:  Color(0xff000000),

                )
            ),           
                          SizedBox(height:20),
                    GestureDetector(

                                      onTap: (){
                                        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => Home(),
                                        
                                        settings: RouteSettings(arguments: user_type)
                                        ),);

                                      },
                                      child: Container(
                                        height:50,
                                        width:340,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        // border: Border.all(width: 0.7,color: Colors.black),
                                          color: Palette.theme1
                                        ),
                                        child:
                 Center(child: Text('Done',                
                 style:  GoogleFonts.poppins(

                  fontSize:  15,
                  height:  1.5,
                  color: Colors.white,

                )

                 )
                    ),
            ),
         )

                
              
            
 

        ],)
      )
    );
    



    


  }

}
