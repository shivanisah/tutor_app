import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../providers/auth_provider.dart';
import '../../shared_preferences.dart/user_preferences.dart';

class ChangePassword extends StatefulWidget{

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
      
    final userPreferences = UserPreferences();
    String email = '';


TextEditingController oldpasswordcontroller = TextEditingController();
TextEditingController newpasswordcontroller = TextEditingController();
TextEditingController newconfirmpasswordcontroller = TextEditingController();

bool _isObscure = true;
bool _isObscure2 = true;
bool _isObscure3 = true;

@override
  void dispose(){
    oldpasswordcontroller.dispose();
    newpasswordcontroller.dispose();
    newconfirmpasswordcontroller.dispose();
    super.dispose();

  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context,listen:false);

    double height = MediaQuery.of(context).size.height;
    double width =  MediaQuery.of(context).size.width;

    userPreferences.getUser().then((user) {
      setState(() {
        email = user.email!;
      });
    });  


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color:Palette.theme1),
      ),
      body:Container(
        margin:EdgeInsets.all(20),
        height:height,
        width:width,
        child:Form(key: formkey,
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height:height*0.09),
            Text(
              "Change Password",
                style:  GoogleFonts.poppins(
                fontSize:  30,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color:  Color(0xff000000),
                  ),
            ),
            SizedBox(height:10), 
            Text("Please enter the details to Change password",
            style:GoogleFonts.poppins(
              fontSize: 12,
              color:Colors.black,
            ),
            ),
          SizedBox(height:30),
                Text(
                 'Current Password ',
                 style:  GoogleFonts.poppins(
                fontSize:  15,        
                height:  1.5,
                color:  Colors.black,
        
                  )
              ),   
              SizedBox(height:4) ,       
        
        
                TextFormField(    
                  obscureText:_isObscure,          
                  controller:oldpasswordcontroller,
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
                  hintText:"Current Password",
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
                                 SizedBox(height: 15),
                Text(
                 'New Password ',
                 style:  GoogleFonts.poppins(
                fontSize:  15,        
                height:  1.5,
                color:  Colors.black,
        
                  )
              ),   
              SizedBox(height:4) ,       
        
        
                TextFormField(    
                  obscureText:_isObscure2,          
                  controller:newpasswordcontroller,
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
                  hintText:"New Password",
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
                 SizedBox(height:15),
                Text(
                 'Confirm Your Password ',
                 style:  GoogleFonts.poppins(
                fontSize:  15,        
                height:  1.5,
                color:  Colors.black,
        
                  )
              ),   
              SizedBox(height:4) ,       
                 TextFormField(    
                 obscureText:_isObscure3,          
                 controller:newconfirmpasswordcontroller,
                decoration:InputDecoration(   
                suffixIcon: IconButton(
                  icon:Icon(_isObscure3?
                  Icons.visibility_off:Icons.visibility),
                  onPressed:(){
                    setState((){
                      _isObscure3=!_isObscure3;
          
                    });
                  }
                  ),
          
                
                border:InputBorder.none,  
                hintText:"New Confirm Password",
                hintStyle: TextStyle(color:Colors.black),
                fillColor: Palette.fillcolor,
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
                              if (newconfirmpasswordcontroller.text !=
                                  newpasswordcontroller.text) {
                                return "Password did not match";
                              } else {
                                return null;
                              }
                            },
            
                 ),


            SizedBox(height:height*0.1),
            GestureDetector(
              onTap:(){
                if(formkey.currentState!.validate()){
                  provider.changePassword(context,email,oldpasswordcontroller.text.toString(),newpasswordcontroller.text.toString());
        
                }
              },
              child:Container(
                height:50,
                width:350,
                margin:EdgeInsets.all(5),
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color:Palette.theme1
                ),
                child:Consumer<AuthProvider>(
                  builder:(context,provider,child){
                    if(provider.loading){
                    return  Center(child: CircularProgressIndicator(color:Colors.white),);
                    }
                    else{
               return Center(child: Text("Change Password",style: TextStyle(color:Colors.white,fontSize:16),));
        
                    }
                  }
                )
                
              )
            )
          ],),
        )
        ),

      )

    );



    


  }

}
