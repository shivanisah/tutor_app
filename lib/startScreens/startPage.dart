import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_app/screens/auth_screens/login.dart';
import 'package:tutor_app/startScreens/studenttutorAccount.dart';

import '../utils/colors.dart';


class AccountPage extends StatefulWidget{
  @override
  State<AccountPage> createState() => _AccountPage();
}

class _AccountPage extends State<AccountPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 520),
                                 child: Column(
            
                                children: [
                                  GestureDetector(
                                            onTap: (){
                                              Navigator.push(context,MaterialPageRoute(builder: (context) => StudentTutorAccount(),));
                                                                          
        
                                            },
                                            child: Container(
                                             margin:EdgeInsets.only(left: 18,right: 18),

                                              height:50,
                                              width:340,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              // border: Border.all(width: 0.7,color: Colors.black),
                                                color: Palette.theme1
                                              ),
                                              
                                                child:           
                                                  Center(child: Text('Create Account',style:  GoogleFonts.poppins(

                                                        fontSize:  20,
                                                            fontWeight:  FontWeight.w500,
                                                            height:  1.5,
                                                          color: Colors.white,

                                                            )
                                                            )
                                                            ),                                       
                                            ),
                                          ),
                                          SizedBox(height:20),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context,MaterialPageRoute(builder: (context) => Login(),));
                                                                          
        
                                            },
                                            child: Container(
                                              margin:EdgeInsets.only(left: 18,right: 18),
                                              height:50,
                                              width:340,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                            
                                              border: Border.all(color: Palette.theme1),
                                                color: Colors.white
                                              ),
                                              
                                                child:           
                                                  Center(child: Text('LogIn',style:  GoogleFonts.poppins(

                                                        fontSize:  20,
                                                            fontWeight:  FontWeight.w500,
                                                            height:  1.5,
                                                          color: Palette.theme1,

                                                            )
                                                            )
                                                            ),                                       
                                            ),
                                          ),

            ],
          ),
        ),


    );



    


  }

}
