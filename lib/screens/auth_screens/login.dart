import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/FirstScreen/appBar.dart';
import 'package:tutor_app/screens/auth_screens/teacherSignUpscreen.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../providers/auth_provider.dart';


class Login extends StatefulWidget{
  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {


  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


@override
void dispose(){
  emailController.dispose();
  passwordController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
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
            SizedBox(height:90),
            Text(
               'Log In',
               style:  GoogleFonts.poppins(

              fontSize:  25,
                  fontWeight:  FontWeight.w500,
                  height:  1.5,
                color:  Color(0xff000000),

                )
            ),
            SizedBox(height:6),
            Text(
               'Please enter your login details',
               style:  GoogleFonts.poppins(

              fontSize:  12,
                  // fontWeight:  FontWeight.w600,
                  height:  1.5,
                color:  Color(0xff000000),

                )
            ),           
           
                 SizedBox(height: 20),
                             Text(
               'Email Address ',
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  // fontWeight:  FontWeight.w600,
                  height:  1.5,
                color:  Colors.black,

                )
            ),           
              SizedBox(height:4),
                     TextFormField(              
                controller:emailController,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:"Email",
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
                    borderSide:BorderSide(color: Color.fromARGB(255, 234, 235, 236)), 
                  ),
                  focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                    borderSide:BorderSide(color: Palette.theme), 
                  )
                    
                ),
             
                validator: (value) {
                    if (value == null || value.isEmpty) {
                     return 'This field is required';
                    }else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
            return ("Please enter a valid email");
                    }
          
                    
                    return null;
                  },  
                 ),
               SizedBox(height: 15),
              Text(
               'Password ',
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  // fontWeight:  FontWeight.w600,
                  height:  1.5,
                color:  Colors.black,

                )
            ),   
            SizedBox(height:4) ,       

              TextFormField(    
                obscureText:_isObscure,          
                controller:passwordController,
                decoration:InputDecoration(   
                suffixIcon: IconButton(
                  icon:Icon(_isObscure?
                  Icons.visibility_off:Icons.visibility),
                  onPressed:(){
                    setState((){
                      _isObscure=!_isObscure2;
          
                    });
                  }
                  ),
          
                
                border:InputBorder.none,  
                hintText:"Password",
                hintStyle: TextStyle(color:Colors.black,fontWeight:FontWeight.w400),
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
                    borderSide:BorderSide(color: Color.fromARGB(255, 234, 235, 236)), 
                  ),
                  focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:BorderSide(color:Palette.theme)
                  )
                    
                ),
                             validator: (value) {
                              RegExp regex = new RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (!regex.hasMatch(value)) {
                                return ("please enter valid password min. 6 character");
                              } else {
                                return null;
                              }
                            },
            
                 ),

                 SizedBox(height:40),
                 Center(
                   child: RichText(
                     text: TextSpan(
                         style: TextStyle(color: Colors.black),
                         children: <TextSpan>[
                           TextSpan(text: 'Forgot Password? ',
                           style:GoogleFonts.poppins(

                          fontSize:  15,
                          fontWeight:  FontWeight.w400,
                          // height:  1.5,
                          color:  Color.fromARGB(255, 134, 148, 162),

                )
                           ),
                           TextSpan(text: 'Reset Password',
                           style:GoogleFonts.poppins(

                          fontSize:  15,
                          fontWeight:  FontWeight.w600,
                          // height:  1.5,
                          color:  Palette.theme1,

                              )
                            ),
                         ],
                     ),
                   ),
                 ),
                SizedBox(height:20),
                    GestureDetector(
                                      onTap: (){
                                  if(_formkey.currentState!.validate()){
                                      provider.userLogin(context,emailController.text.toString(), passwordController.text.toString());
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
                                        child:provider.loading?Center(child: CircularProgressIndicator()):            
                                            Center(child: Text('Continue',style:TextStyle(color:Colors.white,fontSize: 16))),                                       
                                      ),
                                    ),

              SizedBox(height:20),
                               Center(
                   child: RichText(
                     text: TextSpan(
                         style: TextStyle(color: Colors.black),
                         children: <TextSpan>[
                           TextSpan(text: "Don't have an account? ",
                           style:GoogleFonts.poppins(

                          fontSize:  15,
                          fontWeight:  FontWeight.w400,
                          // height:  1.5,
                          color:  Color.fromARGB(255, 134, 148, 162),

                )
                           ),
                           TextSpan(text: 'Signup',
                           recognizer:TapGestureRecognizer()..onTap = () =>
                           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>TutorRegistration(),)),
                           style:GoogleFonts.poppins(

                          fontSize:  15,
                          fontWeight:  FontWeight.w600,
                          // height:  1.5,
                          color:  Palette.theme1,

                )
                            ),
                         ],
                     ),
                   ),
                 ),


                    
            ],),
          ),
        ),
      )      
    );
  }

}
