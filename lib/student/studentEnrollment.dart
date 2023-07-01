import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../../providers/auth_provider.dart';
import '../models/user_models/teacher_data.dart';
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
  String gender = "Male";
  DateTime currentDate = DateTime.now();
  String? finalselectedDate;
  DateTime? userSelectedDate;

    datePicker(context) async{
       userSelectedDate = await 
      showDatePicker(context: context, 
      initialDate: currentDate, 
      firstDate: DateTime.now(),
      lastDate: DateTime(2025)
      );
      if(userSelectedDate == null){
        return;

      }
      else{
        setState(() {
          currentDate = userSelectedDate!;
          finalselectedDate = 
          "${currentDate.year}-${currentDate.month}-${currentDate.day}";
          // print("Date...............................................................................");
          print(finalselectedDate);
          // onSelect(userSelectedDate);
        });
      }
    }


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
        });
      }
    });  

  final arguments = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
  final teacher = arguments['teacher'] as TeacherData;
  // final selectedTimeSlot = arguments['selectedTimeSlot'] as String?;
  final selectedStartTimeSlot = arguments['selectedstartTimeSlot'] as String?;
  final selectedEndTimeSlot = arguments['selectedendTimeSlot'] as String?;
  // print("tttttttttttttt...............................");
  // print(selectedStartTimeSlot);
  // print(selectedEndTimeSlot);
// final TeacherData teacher = ModalRoute.of(context)!.settings.arguments as TeacherData;
  // print(".........................");
  
  // print(teacher.id);
  // print('subjects${teacher.subjects}');
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
                SizedBox(height: 20),
                             Text(
               "Student's Gender",
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
            //DatePicker
                SizedBox(height: 16), 
                Text("To Join Tuition",
                style:  GoogleFonts.poppins(

                fontSize:  15,
                height:  1.5,
                color:  Colors.black,

                )
                ),
                SizedBox(height:5),
                TextFormField(  
                readOnly: true,
                onTap:(){
                 datePicker(context);
                } ,
                decoration:InputDecoration(             
                border:InputBorder.none,  
                hintText:userSelectedDate!= null? finalselectedDate:
                // "${currentDate.year}-${currentDate.month}-${currentDate.day}":
                
                "Pick Date",
                hintStyle: TextStyle(color:Colors.black),
                fillColor: Palette.fillcolor,
                filled: true,
                suffixIcon: IconButton(icon: Icon(Icons.calendar_month),onPressed:(){datePicker(context);}),
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
                                        gender,
                                        teacher.grade.toString(),
                                        teacher.teaching_location?? ''.toString(),
                                        teacher.subjects!,
                                        teacher.id,
                                        userId!,
                                        finalselectedDate!,
                                        // selectedTimeSlot!,
                                        selectedStartTimeSlot?? '',
                                        selectedEndTimeSlot?? '',
                                      

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
