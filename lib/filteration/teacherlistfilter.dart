
import 'package:another_flushbar/flushbar.dart';
import 'package:chips_choice/chips_choice.dart';
// import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/filteration/resultfilterlist.dart';
import 'package:tutor_app/providers/teacherlistprovider.dart';

import '../utils/colors.dart';
import 'filterresult.dart';

class TeacherListFilter extends StatefulWidget {
  const TeacherListFilter({super.key});

  @override
  State<TeacherListFilter> createState() => _TeacherListFilterState();
}

class _TeacherListFilterState extends State<TeacherListFilter> {
  int experience = -1;
  int gender = -1;
  int qualification = -1;
  int teachingloaction = -1;
  List<String> genderoption = [
    'Male',
    'Female'
  ];

  List<String> qualificationoption = [
    'Secondary level',
    'Higher Secondary level(Pursuing)',
    'Higher Secondary level(Completed)',
    'Bachelors Degree(Pursuing)',
    'Bachelors Degree(Completed)',
    'Masters Degree(Pursuing)',
    'Masters Degree(Completed)'
  ];

  List<String> teaching_experience = [
    
    '1 Year',
    '2 Years',
    '3 Years',
    '4 Years',
    '5 Years',
    '6 Years',
    '7 Years',
    '8 Years',
    '9 Years',
    '10 Years',
    '10+ Years',
    

  ];

  List<String> teaching_location = [
    'Student Home',
    'Tutor Place',
    'Both'

  ];

String getExperienceText(int value) {
  
    if (value >= 0 && value < teaching_experience.length) {
      return teaching_experience[value];
    }
    return '';
  }
String getGenderText(int value) {
    if (value >= 0 && value < genderoption.length) {
      return genderoption[value];
    }
    return '';
  }

String getQualificationText(int value){
  if(value>=0 && value< qualificationoption.length){
    return qualificationoption[value];
  }
  return '';
}  

String getLocationText(int value){
  if(value>=0 && value< teaching_location.length){
    return teaching_location[value];
  }
  return '';
}

  @override
  Widget build(BuildContext context) {
      // final provider = Provider.of<TeacherListProvider>(context,listen: false);

    return Scaffold(
     backgroundColor: Color(0xFFF5F7F9),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Palette.theme1),
        // title:Center(child: Text("Search Filter",style:GoogleFonts.poppins(color:Colors.black,fontSize:18,fontWeight: FontWeight.w500))),
        
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
            
            Padding(
              padding: const EdgeInsets.only(left:12.0),
              child: Text("Teaching Experience",style:GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color:Palette.theme1
              )),
            ),
            ChipsChoice.single(
              value: experience,
               onChanged: (val)=>setState(() {
                 experience = val;
               }), 
               choiceItems: C2Choice.listFrom(source: teaching_experience, value: (i,v)=>i, label:(i,v)=>v), 
                wrapped:true,
                choiceStyle: C2ChipStyle(
                  backgroundColor: Color.fromARGB(255, 220, 183, 183),
                  foregroundStyle: GoogleFonts.poppins(),
                
                ),
                choiceCheckmark: true,
                
               ),
               

               GestureDetector(
                
                onTap:(){
                  setState(() {
              experience = -1;
            });
            
                },
                child:Container(
                  margin:EdgeInsets.only(left:40),
                  height:28,
                  width:92,
                  decoration:BoxDecoration(
                    color:Color.fromARGB(255, 244, 226, 226),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left:6),
                    child: Row(
                      children: [
                        Icon(Icons.cancel,size:20),
                        SizedBox(width:6),
                        Text("Clear",style:GoogleFonts.poppins(color:Palette.theme1,fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
               ),
              
               
              
               SizedBox(height:20),
                    Padding(
              padding: const EdgeInsets.only(left:12.0),
              child: Text("Gender",style:GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color:Palette.theme1
              )),
            ),

            ChipsChoice.single(
              value: gender,
               onChanged: (val)=>setState(() {
                 gender = val;
               }), 
               choiceItems: C2Choice.listFrom(source: genderoption, value: (i,v)=>i, label:(i,v)=>v), 
                wrapped:true,
                choiceStyle: C2ChipStyle(
                  backgroundColor: Color.fromARGB(255, 220, 183, 183),
                  foregroundStyle: GoogleFonts.poppins(),
                  
                ),
                choiceCheckmark: true,
 
               ),
               GestureDetector(
                
                onTap:(){
                  setState(() {
              gender = -1;
            });
            
                },
                child:Container(
                  margin:EdgeInsets.only(left:40),
                  height:28,
                  width:92,
                  decoration:BoxDecoration(
                    color:Color.fromARGB(255, 244, 226, 226),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left:6),
                    child: Row(
                      children: [
                        Icon(Icons.cancel,size:20),
                        SizedBox(width:6),
                        Text("Clear",style:GoogleFonts.poppins(color:Palette.theme1,fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
               ),
               SizedBox(height:20),
              Padding(
              padding: const EdgeInsets.only(left:12.0),
              child: Text("Teaching Location",style:GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color:Palette.theme1
              )),
            ),

            ChipsChoice.single(
              value: teachingloaction,
               onChanged: (val)=>setState(() {
                teachingloaction = val;
               }), 
               choiceItems: C2Choice.listFrom(source: teaching_location, value: (i,v)=>i, label:(i,v)=>v), 
                wrapped:true,
                choiceStyle: C2ChipStyle(
                  backgroundColor: Color.fromARGB(255, 220, 183, 183),
                  foregroundStyle: GoogleFonts.poppins(),
                  
                ),
                choiceCheckmark: true,

               ),
        GestureDetector(
                
                onTap:(){
                  setState(() {
              teachingloaction = -1;
            });
            
                },
                child:Container(
                  margin:EdgeInsets.only(left:40,bottom:70),
                  height:28,
                  width:92,
                  decoration:BoxDecoration(
                    color:Color.fromARGB(255, 244, 226, 226),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left:6),
                    child: Row(
                      children: [
                        Icon(Icons.cancel,size:20,),
                        SizedBox(width:6),
                        Text("Clear",style:GoogleFonts.poppins(color:Palette.theme1,fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
               ),
            //   SizedBox(height:20),
            //   Padding(
            //   padding: const EdgeInsets.only(left:12.0),
            //   child: Text("Qualification",style:GoogleFonts.poppins(
            //       fontWeight: FontWeight.w500,
            //       fontSize: 20,
            //       color:Palette.theme1
            //   )),
            // ),

            // ChipsChoice.single(
            //   value: qualification,
            //    onChanged: (val)=>setState(() {
            //     qualification = val;
            //    }), 
            //    choiceItems: C2Choice.listFrom(source: qualificationoption, value: (i,v)=>i, label:(i,v)=>v), 
            //     wrapped:true,
            //       choiceStyle: C2ChipStyle(
            //       backgroundColor: Color.fromARGB(255, 220, 183, 183),
            //       foregroundStyle: GoogleFonts.poppins(),
                  
            //     ),
            //     choiceCheckmark: true,
                
                
 
            //    ),
               SizedBox(height:30),
                      // GestureDetector(
            
                      //                   onTap: (){
                      //                    if(experience!= -1 || gender!= -1 || teachingloaction!=-1) {
                      //                   // provider.fetchfilteredTeachers(context,getExperienceText(experience),getGenderText(gender));
                      //                 Navigator.push(
                      //                             context,
                      //                             MaterialPageRoute(builder: (context) =>FilterResult(),
                      //                             settings: RouteSettings(arguments:{
                      //                               'gender':getGenderText(gender),
                      //                               'experience':getExperienceText(experience),
                      //                               'teaching_location':getLocationText(teachingloaction),
                      //                               // 'qualification':getQualificationText(qualification),
                      
                      //                             }
                                                  
                                                  
                      //                             )
                      //                               ),
                      //                           );
        
        
                      //                    }else{
                      //                     Flushbar(
                      //                       message:"To apply filteration, you must select the field.",
                      //                       backgroundColor: const Color.fromARGB(255, 94, 18, 18),
                      //                       duration: Duration(seconds: 3),
                      //                       flushbarPosition: FlushbarPosition.TOP,
        
                      //                     ).show(context);
                      //                    }
                                         
                                      
                      //               } ,  
            
                                        
                      //                   child: Container(
                      //                     height:50,
                      //                     width:350,
                      //                     padding: EdgeInsets.all(5),
                      //                     decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(6),
                      //                     // border: Border.all(width: 0.7,color: Colors.black),
                      //                       color: Palette.theme1
                      //                     ),
                      //                     child:Center(child: Text.rich(TextSpan(children:[
                      //             TextSpan(text:"Apply  ",style:GoogleFonts.poppins(color:Colors.white,fontSize: 16)),
                      //             TextSpan(text:"Filter",style:GoogleFonts.poppins(color:Colors.green,fontSize:16)),

                      //                     ]))
                      //                     // ( Text("Apply Filter",style:GoogleFonts.poppins(color:Colors.white)))
                      //                     )
                      //                   ),
                      //                 ),
          ]),
        ),
      ),
      bottomSheet: Container(
        
        color:Colors.white,
        child: GestureDetector(
              
                                          onTap: (){
                                           if(experience!= -1 || gender!= -1 || teachingloaction!=-1) {
                                          // provider.fetchfilteredTeachers(context,getExperienceText(experience),getGenderText(gender));
                                        Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) =>FilterResult(),
                                                    settings: RouteSettings(arguments:{
                                                      'gender':getGenderText(gender),
                                                      'experience':getExperienceText(experience),
                                                      'teaching_location':getLocationText(teachingloaction),
                                                      // 'qualification':getQualificationText(qualification),
                        
                                                    }
                                                    
                                                    
                                                    )
                                                      ),
                                                  );
          
          
                                           }else{
                                            Flushbar(
                                              message:"To apply filteration, you must select the field.",
                                              backgroundColor: const Color.fromARGB(255, 94, 18, 18),
                                              duration: Duration(seconds: 3),
                                              flushbarPosition: FlushbarPosition.TOP,
          
                                            ).show(context);
                                           }
                                           
                                        
                                      } ,  
              
                                          
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              height:50,
                                              
                                              // width:350,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              // border: Border.all(width: 0.7,color: Colors.black),
                                                color: Palette.theme1
                                              ),
                                              child:Center(child: Text.rich(TextSpan(children:[
                                                                              TextSpan(text:"Apply  ",style:GoogleFonts.poppins(color:Colors.white,fontSize: 16)),
                                                                              TextSpan(text:"Filter",style:GoogleFonts.poppins(color:Colors.green,fontSize:16)),
                                                
                                              ]))
                                              // ( Text("Apply Filter",style:GoogleFonts.poppins(color:Colors.white)))
                                              )
                                            ),
                                          ),
                                        ),
      ),
    );
  }
}