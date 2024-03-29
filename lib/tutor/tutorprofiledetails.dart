import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/admin/teachercertificate.dart';
import 'package:tutor_app/tutor/tutorWidgets/classsubject.dart';
import 'package:tutor_app/tutor/update/tutorprofileUpdate.dart';
import 'package:tutor_app/tutor/update/tutorteachingInfo.dart';
import 'package:tutor_app/utils/colors.dart';

import '../FirstScreen/Home.dart';
import '../models/user_models/classsubjectmodel.dart';
import '../providers/teacherProfileprovider.dart';
import '../shared_preferences.dart/user_preferences.dart';





class TutorProfileDetailPage extends StatefulWidget{
  @override
  State<TutorProfileDetailPage> createState() => _TutorProfileDetailPageState();
}

class _TutorProfileDetailPageState extends State<TutorProfileDetailPage> {
  bool isLoading = true;
  int? teacherId;
  final userPreferences = UserPreferences();
  String user_type = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  Future<void>  fetchData()async{
    try{
    final teacherProfileProvider = Provider.of<TeacherProfileProvider>(context);
    teacherId = ModalRoute.of(context)!.settings.arguments as int;
    await teacherProfileProvider.fetchTeacherProfile(teacherId!);

    }catch(error){

    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

      userPreferences.getUser().then((teacher) {
      setState(() {
          user_type = teacher.user_type?? '';
      });
    });  


  final teacherProfileProvider = Provider.of<TeacherProfileProvider>(context);
  final profile = teacherProfileProvider.teacherProfile;
  List<String>? subjectsString = profile?.subjects?? [];
  List<GradeSubjectsModel>? classsubject = profile?.classSubjectfinallist;
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.height;

  // print('Image URL: ${profile!.image}');


  return Scaffold(

    backgroundColor: Color(0xFFF5F7F9),
    appBar: AppBar(backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            leading:IconButton(icon:Icon(Icons.arrow_back),
            
            onPressed:() {
              Navigator.push(context,MaterialPageRoute(builder: (context) => Home(),
              settings:RouteSettings(arguments:user_type)
              ));
            },
            )
    ),
    body:SingleChildScrollView(
      child: Column(
        children: [
               Container(
                margin:EdgeInsets.only(left:14,top:20,bottom:10,right:14),
                padding:EdgeInsets.only(top:10,left:10,bottom:12),
                // height:height*0.3,
                width:width,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(8),
                  color: Colors.white,           
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      isLoading?Center(child:CircularProgressIndicator()):profile==null?Text("Profile Not Found"):

                        SizedBox(height:2),
                      Text("Personal Details",
                style:  GoogleFonts.poppins(
                fontSize:  20,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color:  Color(0xff000000),
                  ),

                      ),
                      SizedBox(height:10),
                Row(
                  children: [
                    Text(profile!.fullName +', ',
                    style:  GoogleFonts.poppins(
                    fontSize:  16,
                    fontWeight:  FontWeight.w400,
                    height:  1.5,
                    color:  Color(0xff000000),
                      ),
                          ),
                    Text(profile.gender?? '',
                    style:  GoogleFonts.poppins(
                    fontSize:  16,
                    fontWeight:  FontWeight.w400,
                    height:  1.5,
                    color:  Color(0xff000000),
                      ),

                          ),

                  ],
                ),
                    SizedBox(height:10),

                    Row(
                      children: [
                        Text(profile.phoneNumber,
                        style:  GoogleFonts.poppins(
                        fontSize:  16,
                        fontWeight:  FontWeight.w400,
                        height:  1.5,
                        color:  Color(0xff000000),
                          ),
                        ),
                        SizedBox(width:width*0.23),
                        GestureDetector(
                          onTap:(){
                      Navigator.push(                
                        context,MaterialPageRoute(builder: (context) => TeacherProfileUpdate(profile),
                        )
                        
                        );

                          },
                          child:Icon(Icons.edit_square,color:Palette.theme1)
                        )
                      ],
                    ),
                    SizedBox(height:10),

                    Text(profile.email,
                    style:  GoogleFonts.poppins(
                    fontSize:  16,
                    fontWeight:  FontWeight.w400,
                    height:  1.5,
                    color:  Color(0xff000000),
                      ),
                    ),
                    SizedBox(height:10),

                    Text(profile.address?? '',
                    style:  GoogleFonts.poppins(
                    fontSize:  16,
                    fontWeight:  FontWeight.w400,
                    height:  1.5,
                    color:  Color(0xff000000),
                      ),
                    ),


 
                    ],)
                  ),
    

                   Container(
                margin:EdgeInsets.only(left:14,top:10,bottom:10,right:14),
                padding:EdgeInsets.only(top:10,left:10,bottom:12),

                // height:height*0.55,
                width:width,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(8),
                  color: Colors.white,           
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      // ignore: unnecessary_null_comparison
                      isLoading?Center(child:CircularProgressIndicator()):profile==null?const Text("Profile Not Found"):

                SizedBox(height:2),
                Text("Teaching Details",
                style:  GoogleFonts.poppins(
                fontSize:  20,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color:  Color(0xff000000),
                  ),
              ),
              SizedBox(height:10),
              Text("Education",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Text(profile.education?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),

              SizedBox(height:14),
              Row(
                children: [
                  Text("Teaching Experience",
                    style:  GoogleFonts.poppins(
                    fontSize:  16,
                    fontWeight:  FontWeight.w500,
                    height:  1.5,
                    color: const Color.fromARGB(221, 83, 79, 79),
                      ),
                  ),
                    SizedBox(width:width*0.13),
                        GestureDetector(
                          onTap:(){
                      Navigator.push(                
                        context,MaterialPageRoute(builder: (context) => TeacherTeachingInfoUpdate(profile),
                        )
                        
                        );

                          },
                          child:Icon(Icons.edit_square,color:Palette.theme1)
                        )


                ],
              ),
              Text(profile.teaching_experience?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),
              SizedBox(height:14),
              Text("Teaching Location",
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: const Color.fromARGB(221, 83, 79, 79),
                  ),
              ),
              Text(profile.teaching_location?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w500,
                height:  1.5,
                color: Colors.black,
                  ),
              ),

              SizedBox(height:14),
              classsubject!.isEmpty?
              Row(
                children: [
                  Text("Add Your Teaching Class ",                    
                  style:  GoogleFonts.poppins(
                        fontSize:  16,
                        fontWeight:  FontWeight.w700,
                        height:  1.5,
                        color: Palette.theme1,
                          ),
                    ),
                    SizedBox(width:4),
                        GestureDetector(
                    onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => RetrieveClassSubject(),
                                settings:RouteSettings(arguments: teacherId)

                ),
                );
              },
                          child:Icon(Icons.add_circle_outlined,color:Palette.theme1)
                        )

                ],
              )
                
                :Row(
                children: [
                  Text("Teaching Class and Subjects",
                    style:  GoogleFonts.poppins(
                    fontSize:  16,
                    fontWeight:  FontWeight.w500,
                    height:  1.5,
                    color: const Color.fromARGB(221, 83, 79, 79),
                      ),
                  ),
                  // SizedBox(width:width*0.05),
                  //       GestureDetector(
                  //         onTap:(){
                  //     Navigator.push(                
                  //       context,MaterialPageRoute(builder: (context) => TeacherTeachingInfoUpdate(profile),
                  //       )
                        
                  //       );

                  //         },
                  //         child:Icon(Icons.edit_square,color:Palette.theme1)
                  //       )


                ],
              ),
              
              for(final classname in classsubject!)
                  Column(children: [
              Row(
                children: [
                  Text(classname.class_name?? '',
                    style:  GoogleFonts.poppins(
                    fontSize:  16,
                    fontWeight:  FontWeight.w500,
                    height:  1.5,
                    color: Colors.black,
                      ),         
                  ),
                  SizedBox(width:10),
              Text(classname.subject_name?.join(',')?? '',
                style:  GoogleFonts.poppins(
                fontSize:  16,
                fontWeight:  FontWeight.w400,
                height:  1.5,
                color: Colors.black,
                  ),         
              ),


                ],
              ),

                  ],),
              SizedBox(height:14),
              Row(
                children: [
                  Text("View Your Educational Certificate",                    
                  style:  GoogleFonts.poppins(
                        fontSize:  16,
                        fontWeight:  FontWeight.w700,
                        height:  1.5,
                        color: Palette.theme1,
                          ),
                    ),
                    SizedBox(width:6),
                        GestureDetector(
                    onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => TeacherCertificate(profile),

                ),
                );
              },
                          child:Icon(Icons.visibility,color:Palette.theme1)
                        )

                ],
              )

            

            



 
                    ],)
                  ),

        ],
      ),
    )
  );

  }
}


