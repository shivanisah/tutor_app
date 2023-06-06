import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/FirstScreen/appBar.dart';
import 'package:tutor_app/screens/auth_screens/login.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../providers/auth_provider.dart';
import '../models/user_models/teacher_data.dart';
import '../models/user_models/teacher_model.dart';
import '../shared_preferences.dart/user_preferences.dart';


class StudentEnrollment extends StatefulWidget{
  @override
  State<StudentEnrollment> createState() => _StudentEnrollment();
}

class _StudentEnrollment extends State<StudentEnrollment> {


  TextEditingController pnameController=TextEditingController();
  TextEditingController pnumberController = TextEditingController();
  TextEditingController snameController = TextEditingController();
  TextEditingController snumberController = TextEditingController();
  TextEditingController sgenderController = TextEditingController();



  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


@override
void dispose(){
  pnameController.dispose();
  pnumberController.dispose();
  snameController.dispose();
  snumberController.dispose();

  super.dispose();
}
  @override
  Widget build(BuildContext context) {
  final userPreferences = UserPreferences();
    int? userId;

    // Retrieve the id value from UserPreferences
    userPreferences.getUser().then((teacher) {
      if (teacher != null) {
        setState(() {
          userId = teacher.id;
          print(userId);
        });
      }
    });  
final TeacherData teacher = ModalRoute.of(context)!.settings.arguments as TeacherData;
  print(".........................");
  
  print(teacher.id);
  final provider = Provider.of<AuthProvider>(context,listen: false);


double width = MediaQuery.of(context).size.width;
double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar:AppBar(),
      // appBar:PreferredSize(
      //   preferredSize:const Size.fromHeight(60),
      //   child:AppB(),
      // ),
      body:Container(  
      
        height:height,
        width:width,    
        margin:EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [            
              SizedBox(height:40),

              Text("Personal Info", 
              // textAlign: TextAlign.right,
              style:  GoogleFonts.poppins(

              fontSize:  25,
                fontWeight:  FontWeight.w500,
                height:  1.5,
              color:  Color(0xff000000),

              )                
              ),
            SizedBox(height:6),
              Text("Please enter your personal details ",style:  GoogleFonts.poppins(

              fontSize:  12,
                  // fontWeight:  FontWeight.w600,
                  height:  1.5,
                color:  Color(0xff000000),

                )),
              // Text("we can know you better.",style:  GoogleFonts.poppins(

              // fontSize:  12,
              //     // fontWeight:  FontWeight.w600,
              //     height:  1.5,
              //   color:  Color(0xff000000),

              //   )),         


                 SizedBox(height: 20),
                             Text(
               'Parents Name',
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  // fontWeight:  FontWeight.w600,
                  height:  1.5,
                color:  Colors.black,

                )
            ),           
              SizedBox(height:4),
                     TextFormField(              
                controller:pnameController,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:"Parent's Name",
                hintStyle: TextStyle(color:Colors.black,fontWeight:FontWeight.w400 
                ),
                fillColor: Color.fromARGB(255, 234, 235, 236),
                filled: true,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red,),
                  borderRadius:BorderRadius.circular(6),
                ),
                focusedErrorBorder: OutlineInputBorder
                (borderSide:BorderSide(color:Colors.red),
                borderRadius:BorderRadius.circular(6),
                ),
                enabledBorder:OutlineInputBorder(                 
                    borderRadius:BorderRadius.circular(6),
                    borderSide:BorderSide(color: Palette.fillcolor), 
                  ),
                  focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:BorderSide(color:Palette.theme1)
                  )
                    
                ),
             
                validator: (value) {
                    if (value == null || value.isEmpty) {
                     return 'This field is required';
                    }
                    return null;
                  },  
                    
                 ),

                                  SizedBox(height: 20),
                             Text(
               'Parents Number',
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  // fontWeight:  FontWeight.w600,
                  height:  1.5,
                color:  Colors.black,

                )
            ),           
              SizedBox(height:4),
                     TextFormField(  
                      keyboardType: TextInputType.number,            
                controller:pnumberController,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:"Parent's Number",
                hintStyle: TextStyle(color:Colors.black,fontWeight:FontWeight.w400 
                ),
                fillColor: Color.fromARGB(255, 234, 235, 236),
                filled: true,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red,),
                  borderRadius:BorderRadius.circular(6),
                ),
                focusedErrorBorder: OutlineInputBorder
                (borderSide:BorderSide(color:Colors.red),
                borderRadius:BorderRadius.circular(6),
                ),
                enabledBorder:OutlineInputBorder(                 
                    borderRadius:BorderRadius.circular(6),
                    borderSide:BorderSide(color: Palette.fillcolor), 
                  ),
                  focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:BorderSide(color:Palette.theme1)
                  )
                    
                ),
             
                validator: (value) {
                    if (value == null || value.isEmpty) {
                     return 'This field is required';
                    }
                    else if(!RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$').hasMatch(value)){
                              return "Please Enter a Valid Phone Number";
                    }
                    else 
                    return null;
                  },  
                    
                 ),
                 SizedBox(height: 20),
                             Text(
               "Student's Name",
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  // fontWeight:  FontWeight.w600,
                  height:  1.5,
                color:  Colors.black,

                )
            ),           
              SizedBox(height:4),
                     TextFormField(              
                controller:snameController,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:"Student's Name",
                hintStyle: TextStyle(color:Colors.black,fontWeight:FontWeight.w400 
                ),
                fillColor: Color.fromARGB(255, 234, 235, 236),
                filled: true,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red,),
                  borderRadius:BorderRadius.circular(6),
                ),
                focusedErrorBorder: OutlineInputBorder
                (borderSide:BorderSide(color:Colors.red),
                borderRadius:BorderRadius.circular(6),
                ),
                enabledBorder:OutlineInputBorder(                 
                    borderRadius:BorderRadius.circular(6),
                    borderSide:BorderSide(color: Palette.fillcolor), 
                  ),
                  focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:BorderSide(color:Palette.theme1)
                  )
                    
                ),
             
                validator: (value) {
                    if (value == null || value.isEmpty) {
                     return 'This field is required';
                    }
                    return null;
                  },  
                    
                 ),
                 SizedBox(height: 20),
                             Text(
               "Student's Number",
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  // fontWeight:  FontWeight.w600,
                  height:  1.5,
                color:  Colors.black,

                )
            ),           
              SizedBox(height:4),
                     TextFormField(   
                      keyboardType: TextInputType.number,           
                controller:snumberController,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:"Student's Number",
                hintStyle: TextStyle(color:Colors.black,fontWeight:FontWeight.w400 
                ),
                fillColor: Color.fromARGB(255, 234, 235, 236),
                filled: true,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red,),
                  borderRadius:BorderRadius.circular(6),
                ),
                focusedErrorBorder: OutlineInputBorder
                (borderSide:BorderSide(color:Colors.red),
                borderRadius:BorderRadius.circular(6),
                ),
                enabledBorder:OutlineInputBorder(                 
                    borderRadius:BorderRadius.circular(6),
                    borderSide:BorderSide(color: Palette.fillcolor), 
                  ),
                  focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:BorderSide(color:Palette.theme1)
                  )
                    
                ),
             
                validator: (value) {
                    if (value == null || value.isEmpty) {
                     return 'This field is required';
                    }
                    else if(!RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$').hasMatch(value)){
                              return "Please Enter a Valid Phone Number";
                    }
                    else 
                    return null;
                  },  
                    
                 ),



                          SizedBox(height:20),
                    GestureDetector(
                                      onTap: ()  {
                                  if (_formkey.currentState!.validate()) {
                                     // Set the loading state to true

                                    
                                      provider.studentEnrollment(
                                        context,
                                        pnameController.text.toString(),
                                        pnumberController.text.toString(),
                                        snameController.text.toString(),
                                        snumberController.text.toString(),
                                        teacher.id,
                                        userId!
                                      

                                      );
                                  }
                                    },
                                      child: Container(
                                        height:50,
                                        width:350,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        // border: Border.all(width: 0.7,color: Colors.black),
                                          color: Palette.theme1
                                        ),
                                        child:provider.loading?Visibility(
                                     maintainSize: true,
                                     maintainAnimation: true,
                                     maintainState: true,
                                     visible: true,

                                          child: CircularProgressIndicator(color:Colors.white)):            
                                            Center(child: Text('Proceed', style:  GoogleFonts.poppins(

                                                                fontSize:  15,
                                                                    // fontWeight:  FontWeight.w600,
                                                                    height:  1.5,
                                                                  color:  Colors.white,

                                                                  ))),                                       
                                      ),
                                    ),




                    
            ],),
          ),
        ),
      )      
    );
  }

}
