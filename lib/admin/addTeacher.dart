import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../providers/auth_provider.dart';


class AddTeacher extends StatefulWidget{
  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {




  TextEditingController name=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController address=TextEditingController(); 


  String gender = "Male";

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool loading = false;
@override
void dispose(){
  name.dispose();
  number.dispose();
  email.dispose();
  address.dispose();
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
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [            
              SizedBox(height:20),
              Text("Sign up", 
              // textAlign: TextAlign.right,
              style:TextStyle(fontSize:25 )),
              SizedBox(height:10),

              SizedBox(height:6),
              Text("Create Teacher Account."),
              SizedBox(height: 20,),
              Text("Name *"),
              SizedBox(height:5),
              TextFormField(              
                controller:name,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:"Full Name",
                hintStyle: TextStyle(color:Colors.black),
                fillColor:Color.fromARGB(255, 234, 235, 236),
                filled:true,
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
                 Text("Email Address*"),
                 SizedBox(height:5),
                     TextFormField(              
                controller:email,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:"Email",
                hintStyle: TextStyle(color:Colors.black),
                fillColor: Palette.fillcolor,
                filled:true,
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
               Text("Number *"),
               SizedBox(height:5),
               TextFormField( 
                keyboardType:TextInputType.number,             
                controller:number,
                decoration:InputDecoration( 
                  alignLabelWithHint: true,            
                border:InputBorder.none,  
                hintText:"Phone number",
                hintStyle: TextStyle(color:Colors.black),
                fillColor: Palette.fillcolor,
                filled:true,
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
               "Gender",
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  height:  1.5,
                color:  Colors.black,

                )
            ),  
            SizedBox(height:4),
            Row(children: [
              Radio(
                groupValue: gender,
              value:"Male",
              
              onChanged: (value){
                setState(() {
                  gender = value.toString();
                });
              },
            
              ),
              Text("Male"),
              SizedBox(width:30),
            Radio(
              groupValue: gender,
              value:"Female",
              onChanged: (value){
                setState(() {
                  gender = value.toString();
                });
              },

              ),
              Text("Female")

            ],),
 
                


                       SizedBox(height:30),
                        Container(
                          width:350,
                          child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6))),
                                  // elevation: 5.0,
                                  
                                  height: 50,
                                  onPressed: (){
                                  try{
                          

                                      if(_formKey.currentState!.validate()){
                                       provider.addteacher(context,email.text.toString(),name.text.toString(),number.text.toString(), 
                                       
                                       gender
                                       );
                          
                                    }

                                    }catch (e){
                                           SnackBar( content: Text(e.toString()), ) ;}
                        
                                  },        
                                      
                                  child:
                                  Consumer<AuthProvider>(
                                        builder: (context, provider,child) {
                                          if (provider.signUpLoading) {
                                            return Center(child: CircularProgressIndicator(color: Colors.white));
                                          } else {
                                            return Center(child: Text('Create', style: TextStyle(color: Colors.white, fontSize: 16)));
                                          }
                                        },
                                      ),

                                  //  provider.signUpLoading?Visibility(
                                  //   maintainSize: true,
                                  //   maintainAnimation: true,
                                  //   maintainState: true,
                                  //   visible:true,
                                    
                                  //   child: CircularProgressIndicator(color: Colors.white,)):
                                  // Text(
                                  //   "Sign Up",
                                  //   style: TextStyle(
                                  //     fontSize: 15,
                                  //     color:Colors.white,
                                  //   ),
                                  // ),
                                  color:Palette.theme1,
                                ),
                        ),

                    
            ],),
          ),
        ),
      )      
    );
  }




}