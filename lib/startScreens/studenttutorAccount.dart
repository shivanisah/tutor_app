import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_app/screens/auth_screens/studentSignUpScreen.dart';
import 'package:tutor_app/screens/auth_screens/teacherSignUpscreen.dart';

import '../utils/colors.dart';


class StudentTutorAccount extends StatefulWidget{
  @override
  State<StudentTutorAccount> createState() => _StudentTutorAccount();
}

class _StudentTutorAccount extends State<StudentTutorAccount> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:AppBar(),
        body:Container(
          margin: EdgeInsets.only(top:200,left:20),
          child:Row(children: [

                    GestureDetector(
                                            onTap: (){
                                              Navigator.push(context,MaterialPageRoute(builder: (context) => TutorRegistration(),));
                                                                          
        
                                            },
                                            child: Container(
                                              height:50,
                                              width:140,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              // border: Border.all(width: 0.7,color: Colors.black),
                                                color: Palette.theme1
                                              ),
                                              
                                                child:           
                                                  Center(child: Text('Tutor',style:  GoogleFonts.poppins(

                                                        fontSize:  20,
                                                            fontWeight:  FontWeight.w500,
                                                            height:  1.5,
                                                          color: Colors.white,

                                                            )
                                                            )
                                                            ),                                       
                                            ),
                                          ),
                                          (SizedBox(width:20)),
                                                              GestureDetector(
                                            onTap: (){
                                              Navigator.push(context,MaterialPageRoute(builder: (context) => StudentSignUp(),));
                                                                          
        
                                            },
                                            child: Container(
                                              height:50,
                                              width:140,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              // border: Border.all(width: 0.7,color: Colors.black),
                                                color: Palette.theme1
                                              ),
                                              
                                                child:           
                                                  Center(child: Text('Student',style:  GoogleFonts.poppins(

                                                        fontSize:  20,
                                                            fontWeight:  FontWeight.w500,
                                                            height:  1.5,
                                                          color: Colors.white,

                                                            )
                                                            )
                                                            ),                                       
                                            ),
                                          ),



          ],)
        ),

    );



    


  }

}
