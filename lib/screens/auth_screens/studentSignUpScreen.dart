import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/screens/auth_screens/login.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../providers/auth_provider.dart';


class StudentSignUp extends StatefulWidget{
  @override
  State<StudentSignUp> createState() => _StudentSignUp();
}

class _StudentSignUp extends State<StudentSignUp> {


  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


@override
void dispose(){
  emailController.dispose();
  passwordController.dispose();
  confirmpasswordController.dispose();
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

              Text("Sign Up", 
              // textAlign: TextAlign.right,
              style:  GoogleFonts.poppins(

              fontSize:  25,
                fontWeight:  FontWeight.w500,
                height:  1.5,
              color:  Color(0xff000000),

              )                
              ),
            SizedBox(height:6),
              Text("Please enter the register details ",style:  GoogleFonts.poppins(

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
                    }else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
            return ("Please enter a valid email");
                    }
          
                    
                    return null;
                  },  
                 ),
                 SizedBox(height: 20),
                             Text(
               'Password',
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  // fontWeight:  FontWeight.w600,
                  height:  1.5,
                color:  Colors.black,

                )
            ),           
              SizedBox(height:4),
              TextFormField(    
                obscureText:_isObscure,          
                controller:passwordController,
                decoration:InputDecoration(   
                suffixIcon: IconButton(
                  icon:Icon(_isObscure?
                  Icons.visibility_off:Icons.visibility),
                  onPressed:(){
                    setState((){
                      _isObscure=!_isObscure;
          
                    });
                  }
                  ),
          
                
                border:InputBorder.none,  
                hintText:"Password",
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
                 SizedBox(height: 20),
                             Text(
               'Confirm Password',
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  // fontWeight:  FontWeight.w600,
                height:  1.5,
                color:  Colors.black,

                )
            ),           
              SizedBox(height:4),
                TextFormField(    
                obscureText:_isObscure2,          
                controller:confirmpasswordController,
                decoration:InputDecoration(   
                suffixIcon: IconButton(
                  icon:Icon(_isObscure2?
                  Icons.visibility_off:Icons.visibility),
                  onPressed:(){
                    setState((){
                      _isObscure2=!_isObscure2;
          
                    });
                  }
                  ),
          
                
                border:InputBorder.none,  
                hintText:"Confirm Password",
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
                              if (confirmpasswordController.text !=
                                  passwordController.text) {
                                return "Password did not match";
                              } else {
                                return null;
                              }
                            },
            
                 ),
                          SizedBox(height:20),
                    GestureDetector(
                                      onTap: ()  {
                                  if (_formkey.currentState!.validate()) {
                                     // Set the loading state to true

                                    
                                      provider.studentSignup(
                                        context,
                                        emailController.text.toString(),
                                        passwordController.text.toString(),
                                        confirmpasswordController.text.toString(),
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
                                        child:
                                  Consumer<AuthProvider>(
                                                builder: (context, provider,child) {
                                                  if (provider.signUpLoading) {
                                                    return Center(child: CircularProgressIndicator(color: Colors.white));
                                                  } else {
                                                    return Center(child: Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 16)));
                                                  }
                                                },
                                              ),                                      ),
                                    ),

              SizedBox(height:20),
                               Center(
                   child: RichText(
                     text: TextSpan(
                         style: TextStyle(color: Colors.black),
                         children: <TextSpan>[
                           TextSpan(text: "Already have an account? ",
                           style:GoogleFonts.poppins(

                          fontSize:  15,
                          fontWeight:  FontWeight.w400,
                          // height:  1.5,
                          color:  Color.fromARGB(255, 134, 148, 162),

                )
                           ),
                           TextSpan(text: 'LogIn',
                           recognizer:TapGestureRecognizer()..onTap = () =>
                           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>Login(),)),
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



                //  SizedBox(height:20),
                //         Center(
                //   child:      MaterialButton(
                //                 shape: RoundedRectangleBorder(
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(20.0))),
                //                 elevation: 5.0,
                //                 height: 40,
                //                 onPressed: () async {
                //                   if (_formkey.currentState!.validate()) {
                //                     provider.setSignUpLoading(true); // Set the loading state to true

                //                     try {
                //                       await provider.studentSignup(
                //                         context,
                //                         emailController.text.toString(),
                //                         passwordController.text.toString(),
                //                         confirmpasswordController.text.toString(),
                //                       );
                //                     } finally {
                //                       provider.setSignUpLoading(false); // Set the loading state to false after the API call
                //                     }
                //                   }
                //                     },

                //                 child: provider.signUpLoading?Visibility(child: CircularProgressIndicator(color: Colors.white,)):Text(
                //                   "SignUp",
                //                   style: TextStyle(
                //                     fontSize: 20,
                //                   ),
                //                 ),
                //                 color: Colors.white,
                //               ),
                //         ),

                    
            ],),
          ),
        ),
      )      
    );
  }

}
