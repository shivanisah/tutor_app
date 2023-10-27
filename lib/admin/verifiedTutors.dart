import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/admin/verifiedTutorDetailPage.dart';
import 'package:tutor_app/models/user_models/teacher_data.dart';
import 'package:tutor_app/providers/teacherProfileprovider.dart';
import 'package:tutor_app/utils/colors.dart';




class VerifiedTutorList extends StatefulWidget{
  @override
  State<VerifiedTutorList> createState() => _VerifiedTutorListState();
}

class _VerifiedTutorListState extends State<VerifiedTutorList> {
bool isLoading = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
    // final teacherProvider = Provider.of<TeacherProfileProvider>(context, listen: false);
    // teacherProvider.fetchVerifiedTeacherList();
  }

 Future<void> fetchData() async{
  try{
    final teacherProvider = Provider.of<TeacherProfileProvider>(context,listen:false);
    await teacherProvider.fetchVerifiedTeacherList();
  }catch(error){

  }finally{
    setState(() {
      isLoading = false;
    });
  }
 }

   List<TeacherData> sortDate(List<TeacherData> enrollments) {
    enrollments.sort((a, b) {
      DateTime aDate = a.verification_date !=null?DateTime.parse(a.verification_date!):DateTime(0);
      DateTime bDate = b.verification_date !=null?DateTime.parse(b.verification_date!):DateTime(0);
      return bDate.compareTo(aDate);
    });

    return enrollments;
  }  

  @override
  Widget build(BuildContext context) {
    final teacherProvider = Provider.of<TeacherProfileProvider>(context);
    final teachers = teacherProvider.verifiedTeacher;
    final sortedData = sortDate(teachers);




    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        
        child:isLoading?Padding(
          padding: const EdgeInsets.only(top:150),
          child: Center(
            child:CircularProgressIndicator(),
          ),
        ):teachers.isEmpty?Center(
          child: Container(
            margin:EdgeInsets.only(top:200),
            child:Text("No verified teachers found")),
        ): 
       Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                        SizedBox(height:40),
            Padding(
              padding: const EdgeInsets.only(left:15.0,bottom:9),
              child: Text(
                 'Verified Teachers',
                 style:  GoogleFonts.poppins(
                  
                fontSize:  25,
                    fontWeight:  FontWeight.w500,
                    height:  1.0,
                  color:  Color(0xff000000),
                  
                  )
              ),
            ),
            // SizedBox(height:6),
            // Padding(
            //   padding: const EdgeInsets.only(left:11.0),
            //   child: Text(
            //      'Here, the lists of requested students',
            //      style:  GoogleFonts.poppins(
                  
            //     fontSize:  12,
            //         // fontWeight:  FontWeight.w600,
            //         height:  1.5,
            //       color:  Color(0xff000000),
                  
            //       )
            //   ),
            // ),           
            
            Container(
            
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sortedData.length,
                // itemCount: sortedEnrollments.length,

                itemBuilder: (context, index) {
                  final teacher = sortedData[index];
                  // final enrollment = sortedEnrollments[index];
                  // final isConfirmed = confirmedEnrollmentIds.contains(enrollment.id);
                  return
                   Container(
                    margin:EdgeInsets.only(left:20,top:10,bottom:10,right:20),
                    padding:EdgeInsets.only(top:10),
                    height:150,
                    
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(6),
                                                      boxShadow:[
                                    BoxShadow(
                                      color: Color.fromARGB(255, 188, 187, 187),
            
                                      blurRadius:3,
                                      offset:Offset(0,3),
                                    ),
                                    BoxShadow(
                                      color:Colors.white,
                                      offset:Offset(-3,0),
                                    ),
                                    BoxShadow(
                                        color:Colors.white,
                                      offset:Offset(3,0),
                                    ),
                                  ]
            
                        ),
                        child:Column(
                          children: [
                            Row(children: [
                              SizedBox(width:5),
                              Icon(Icons.account_circle_rounded,size:30,color:Palette.theme1),
                              SizedBox(width:10),
                              Text(teacher.fullName),
                              ]),
                              SizedBox(height:10),
                              
                              Row(
        
                                children: [
                                SizedBox(width:7),
        
                            Icon(Icons.call,size:20,color:Palette.theme1),

                              SizedBox(width:10),
                              Text(teacher.phoneNumber),
                                  SizedBox(width:150),
                                  GestureDetector(
                                    onTap: () {

                                    List<String>? subjectsString = teacher.subjects;
                                    print(subjectsString);
                                      TeacherData verified_teacher = TeacherData(
                                          fullName: teacher.fullName,
                                          phoneNumber: teacher.phoneNumber,
                                          email:teacher.email,
                                          gender: teacher.gender,
                                          address:teacher.address,

                                          education: teacher.education,
                                          teaching_experience: teacher.teaching_experience,
                                          teaching_location: teacher.teaching_location,
                                          id:teacher.id,
                                          grade:teacher.grade,
                                          subjects:subjectsString?? [],
                                          verification_status: teacher.verification_status,
                                          certificate: teacher.certificate,
                                          block:teacher.block,


                                      );
                                      
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => VerifiedTutorDetailPage(profile:teacher),
                                        settings: RouteSettings(arguments: verified_teacher)
                                        ),
                                      );
                                    },
                                    child: Icon(Icons.arrow_forward_ios_outlined),
                                    // Text("View Info",style: TextStyle(color:Palette.theme1,fontSize: 16,fontWeight: FontWeight.w500),)
                                      
                                    ),
                                ],
                              ),
                              SizedBox(height:10),
                            Row(children: [
                              SizedBox(width:7),
                              Icon(Icons.calendar_month,size:20,color:Palette.theme1),
                              SizedBox(width: 10),
                              Text(
                             'Regitration Date: ${teacher.date_joined?.year}-${teacher.date_joined?.month.toString().padLeft(2, '0')}-${teacher.date_joined?.day.toString().padLeft(2, '0')}'
                                ),
                              
                              ]),
                              SizedBox(height:10),
                               Row(
        
                                children: [
                                SizedBox(width:7),
        
                            Icon(Icons.calendar_today_rounded,size:20,color:Colors.green),
                              SizedBox(width:10),
                              Text(  
                             'Verified on: ${teacher.verification_date != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(teacher.verification_date!)) : ''}',                              
                              
                              ),
                                ]),
        
                              
                          
                          ],
                        )
                  );
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


    


  }


