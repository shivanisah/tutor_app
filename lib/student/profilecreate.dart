import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/providers/student_provider.dart';
import 'package:tutor_app/student/addressmap.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../providers/auth_provider.dart';
import '../shared_preferences.dart/user_preferences.dart';


class StudentProfileCreate extends StatefulWidget{
  @override
  State<StudentProfileCreate> createState() => _StudentProfileCreateState();
}

class _StudentProfileCreateState extends State<StudentProfileCreate> {



  TextEditingController pnameController=TextEditingController();
  TextEditingController pnumberController = TextEditingController();
  TextEditingController snameController = TextEditingController();
  TextEditingController snumberController = TextEditingController();
  TextEditingController sgenderController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String gender = "Male";


  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


@override
void dispose(){
  pnameController.dispose();
  pnumberController.dispose();
  snameController.dispose();
  snumberController.dispose();
  sgenderController.dispose();
  addressController.dispose();

  super.dispose();
}
double? latitude;
double? longitude;
void _onMapPage() async{
  final selectedLocation = await Navigator.push(context,
  MaterialPageRoute(builder: (context) => StudentAddressMapPage(),)
  );
  if(selectedLocation!=null){
    setState(() {
      addressController.text = selectedLocation['address'];
       latitude = selectedLocation['latitude'];
       longitude = selectedLocation['longitude'];
    });
  }
}
  @override
  Widget build(BuildContext context) {
  final userPreferences = UserPreferences();
    int? userId;
    // ignore: unused_local_variable
    String? student_email;

    // Retrieve the id value from UserPreferences
    userPreferences.getUser().then((teacher) {
      // ignore: unnecessary_null_comparison
      if (teacher != null) {
        setState(() {
          userId = teacher.id;
          student_email = teacher.email;
        });
      }
    });  

  final provider = Provider.of<StudentProvider>(context,listen: false);

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
                 SizedBox(height: 20),
                             Text(
               "Your Name",
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
                hintText:"Your Name",
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
               "Your Number",
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
                hintText:"Your Number",
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
                    else if(!RegExp(r'^\d{10}$').hasMatch(value)){
                              return "Please Enter a Valid 10-Digit Phone Number";
                    }else{
                      List<String> validStartingNumbers = ['98','97','96','95','94'];
                      String startingDigits = value.substring(0,2);
                      if(!validStartingNumbers.contains(startingDigits)){
                        return 'Enter valid number';
                      }
                    }
                    
                    return null;
                  },  
                    
                 ),
                SizedBox(height: 20),
                             Text(
               "Your Gender",
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
          Text(
               "Address",
               style:  GoogleFonts.poppins(

              fontSize:  15,
                  // fontWeight:  FontWeight.w600,
                  height:  1.5,
                color:  Colors.black,

                )
            ),           

            SizedBox(height:4),
                TextFormField(              
                controller:addressController,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:"Address",
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
                 onTap:_onMapPage,   
                 ),

                  SizedBox(height:20),
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
                    else if(!RegExp(r'^\d{10}$').hasMatch(value)){
                              return "Please Enter a Valid 10-Digit Phone Number";
                    }else{
                      List<String> validStartingNumbers = ['98','97','96','95','94'];
                      String startingDigits = value.substring(0,2);
                      if(!validStartingNumbers.contains(startingDigits)){
                        return 'Enter valid number';
                      }
                    }
                    
                    return null;
                  },  
                    
                 ),

 
            SizedBox(height:20),
                    GestureDetector(
                                      onTap: ()  {
                                  if (_formkey.currentState!.validate()) {
                                      provider.createstudentProfile(
                                        context,
                                        userId!,
                                        snameController.text.toString(),
                                        snumberController.text.toString(),
                                        pnameController.text.toString(),
                                        pnumberController.text.toString(),
                                        gender,
                                        latitude,
                                        longitude,
                                        addressController.text.toString(),
                                        
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
                                                if (provider.loading) {
                                                  return Center(child: CircularProgressIndicator(color: Colors.white));
                                                } else {
                                                  return Center(child: Text('Proceed', style: TextStyle(color: Colors.white, fontSize: 16)));
                                                }
                                              },
                                            ),                                      ),
                                    ),
                    
            ],),
          ),
        ),
      )      
    );
  }

}
