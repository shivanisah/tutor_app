

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tutor_app/models/user_models/classsubjectmodel.dart';
import 'package:tutor_app/tutor/tutorDetailScreen.dart';

import '../Apis/teacherList.dart';


import '../models/user_models/teacher_data.dart';
import '../models/user_models/timeSlot.dart';
import '../providers/teacherlistprovider.dart';
import '../utils/colors.dart';



class FilterResult extends StatefulWidget{
  @override
  State<FilterResult> createState() => _FilterResultState();
}

class _FilterResultState extends State<FilterResult> {
  // String api = "http://192.168.1.83:8000/teacher/";
    
  @override
  void initState(){

    super.initState();
    fetchlist(context);

  }

  Future<void> fetchlist(BuildContext context) async{
    try{
      final teacherProvider = Provider.of<TeacherListProvider>(context,listen:true);
      final arguments = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;

      final selectedgender = arguments['gender'] as String?;
      final selectedteachingexperience = arguments['experience'] as String?;
      final selectedteachinglocation = arguments['teaching_location'] as String?;
      final selectedqualification = arguments['qualification'] as String?;

      await teacherProvider.fetchfilteredTeachers(context,selectedteachingexperience,selectedgender,selectedteachinglocation);
    }catch(e){
      print('Error fetching teacher data: $e');
    }
  }


  @override
  Widget build(BuildContext context){
      final arguments = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;

      final selectedgender = arguments['gender'] as String?;
      final selectedteachingexperience = arguments['experience'] as String?;
      final selectedteachinglocation = arguments['teaching_location'] as String?;
      final selectedqualification = arguments['qualification'] as String?;

    final teacherProvider = Provider.of<TeacherListProvider>(context,listen:false);
    return Scaffold(
     backgroundColor: Color(0xFFF5F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Palette.theme1)
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:20.0),
        child: FutureBuilder<List<dynamic>>(
          future:teacherProvider.fetchfilteredTeachers(context,selectedteachingexperience,selectedgender,selectedteachinglocation),
          builder:(BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
           if(snapshot.hasData){
              return  SingleChildScrollView(
                child: ListView.builder(
                    physics:NeverScrollableScrollPhysics(),
                    shrinkWrap:true,
                    // gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,
                    // // childAspectRatio: .9,
                    //   mainAxisExtent:MediaQuery.of(context).size.height*0.5,
                  
                    // ),
                    itemCount:snapshot.data?.length,
                    itemBuilder:(context,i){
                      List<GradeSubjectsModel>? classlists = List<GradeSubjectsModel>.from(snapshot.data![i]['classlist'].map((cslist) => GradeSubjectsModel.fromJson(cslist)));

                      return GestureDetector(
                        onTap:(){
                        },
                        child: Container(
                            margin:EdgeInsets.only(right:14,left:10,top:5,bottom:13),
                            decoration:BoxDecoration(
                                color:Colors.white,
                                borderRadius:BorderRadius.circular(8),
                            ),
                  
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Container(
                                  height:140,
                                  width:140,
                                  decoration:BoxDecoration(
                                      borderRadius:BorderRadius.only(topLeft:Radius.circular(8),topRight:Radius.circular(8)),
                  
                                      
                                      image:DecorationImage(
                                        
                                        // image:AssetImage("assets/images/d1.jpg"),
                                        // fit:BoxFit.cover
                                      
                  
                                              image: snapshot.data![i]["image"] != null
                                                ? 
                                                NetworkImage(snapshot.data![i]["image"])
                                                : const AssetImage("assets/images/teacherimg.png") as ImageProvider<Object>,                 
                                               fit:BoxFit.cover,
                                               
                                               alignment: Alignment.topCenter,
                                      )
                                      
                  
                                  ),
                  
                  
                  
                  
                  
                  
                  
                                  // child:CircleAvatar(backgroundImage: AssetImage("assets/images/d1.jpg"),
                                  // radius:70
                                  // )
                                ),
                                // Divider(color: Colors.black12,),
                                // SizedBox(height:10),
                                Container(
                                    // width:200,
                                    padding: EdgeInsets.all(8),
                                    // color:Colors.red,
                                    child:Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Text("Aayush Shah"),
                                        Text(snapshot.data![i]['full_name'],style:GoogleFonts.poppins()),
                                        SizedBox(height:5),
                                        Text(snapshot.data![i]["gender"],style:GoogleFonts.poppins()),
                                        SizedBox(height:5),
                                        Text(snapshot.data ?[i]["address"]?? '',style:GoogleFonts.poppins()),
                  
                                        SizedBox(height:5),
                  Row(
                    children: [
                      for(final classname in classlists)
                      Text.rich(TextSpan(children: [
                        TextSpan(text:classname.class_name?? '',style:GoogleFonts.poppins(
                          fontWeight: FontWeight.w500
                        )),
                        TextSpan(text:', ',style:GoogleFonts.poppins())

                      ]))
                      // Text(classname.class_name?? '',
                      //   style:  GoogleFonts.poppins(
                        // fontSize:  16,
                        // fontWeight:  FontWeight.w500,
                        // height:  1.5,
                        // color: Colors.black,
                          // ),         
                      // ),

                    ],
                  ),

                  
                  
                  
                                        SizedBox(height:8),
                  
                                        GestureDetector(
                                          onTap: () {
                                            // List<TimeSlot> timeSlots = (snapshot.data![i]['time_slots'] as List)
                                            //           .map((slot) => TimeSlot.fromJson(slot))
                                            //           .toList();
                                            // print(timeSlots);
                                            // print(timeSlots);
                                            TeacherData teacher = TeacherData(
                                                                fullName: snapshot.data![i]['full_name'],
                                                                phoneNumber: snapshot.data![i]['phone_number'],
                                                                address: snapshot.data![i]['address'],
                                                                email: snapshot.data![i]['email'],
                                                                id: snapshot.data![i]['id'] ,
                                                                image: snapshot.data![i]["image"] ?? "assets/images/d1.jpg",
                    
                                                                education: snapshot.data![i]['education'],
                                                                teaching_experience: snapshot.data![i]['teaching_experience'],
                                                                teaching_location: snapshot.data![i]['teaching_location'],
                                                                about_me: snapshot.data![i]['about_me'],
                                                                gender: snapshot.data![i]['gender'],
                                                                // grade: snapshot.data![i]['grade'],
                                                                // subjects:subjectsList,
                                                                timeSlots: List<TimeSlot>.from(snapshot.data![i]['time_slots'].map((slot) => TimeSlot.fromJson(slot))),
                                                                classSubjectlist: List<GradeSubjectsModel>.from(snapshot.data![i]['classlist'].map((cslist) => GradeSubjectsModel.fromJson(cslist))),
                                                                // timeSlots: timeSlots
                                                              );
                                            Navigator.push(context,MaterialPageRoute(builder: (context)=>TutorDetailScreen(teacher:teacher)));
                  
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            width:100,
                                            decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            // border: Border.all(width: 0.7,color: Colors.black),
                                              color: Palette.theme1
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(width:6),
                                                Text('View Details',style:TextStyle(color:Colors.white,fontSize: 12)),
                                                // SizedBox(width:8),
                                            //  Icon(Icons.arrow_circle_right,color:Colors.white),
                                        
                                              ],
                                            ),
                                          ),
                                        ),
                                      
                  
                                      ],)
                                )
                              ],
                            )
                        ),
                      );
                    }
                ),
              );
          
            }
      
      
            // else if(teacherProvider.filteredteacherlist.isEmpty){
            // const Center(
            //     child:Text('No Results found',style:TextStyle(color:Colors.black))
            //   );
            // }
            // else if (!snapshot.hasData){
            //   return Center(child: Text("No Results Found"));
            // }
      
            else{
              return const Center(
                child:CircularProgressIndicator()
              );
          
            }
          }
          
        ),
      ),
    );
  }
}
