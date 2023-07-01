import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/enrollmentConfirm/confirmedStudentsdetailpage.dart';
import 'package:tutor_app/utils/colors.dart';

import '../models/user_models/enrolledStudentsmodel.dart';
import '../providers/enrollmentlist_provider.dart';



class ConfirmStudentList extends StatefulWidget{
  @override
  State<ConfirmStudentList> createState() => _ConfirmStudentList();
}

class _ConfirmStudentList extends State<ConfirmStudentList> {
  int? teacherId;
  bool isLoading = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final enrollmentProvider = Provider.of<EnrollmentProvider>(context, listen: false);
    teacherId = ModalRoute.of(context)!.settings.arguments as int;
    enrollmentProvider.fetchConfirmEnrollments(teacherId!);
  }
List<Enrollment> sortEnrollments(List<Enrollment> enrollments) {
    enrollments.sort((a, b) {
      DateTime aDate = a.confirmedDate !=null?DateTime.parse(a.confirmedDate!):DateTime(0);
      DateTime bDate = b.confirmedDate !=null?DateTime.parse(b.confirmedDate!):DateTime(0);
      return bDate.compareTo(aDate);
    });

    return enrollments;
  }  

  @override
  Widget build(BuildContext context) {

  final enrollmentProvider = Provider.of<EnrollmentProvider>(context);
  final enrollments = enrollmentProvider.confirmedEnrollments;
  final sortedEnrollments = sortEnrollments(enrollments);


    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: enrollments.isEmpty?Center(
          child: Container(
            margin:EdgeInsets.only(top:200),
            child:Text("No Enrolled Students")))
        :Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
          SizedBox(height:40),
            Padding(
              padding: const EdgeInsets.only(left:15.0,bottom:9),
              child: Text(
                 'Enrolled Students',
                 style:  GoogleFonts.poppins(
                  
                fontSize:  25,
                    fontWeight:  FontWeight.w500,
                    height:  1.0,
                  color:  Color(0xff000000),
                  
                  )
              ),
            ),

            Container(
      
              child: ListView.builder(
                shrinkWrap: true,
                physics:NeverScrollableScrollPhysics(),
                // itemCount: enrollments.length,
                itemCount:sortedEnrollments.length,
                itemBuilder: (context, index) {
                  // final enrollment = enrollments[index];
                final enrollment = sortedEnrollments[index];

                  

                  return
                   Container(
                    margin:EdgeInsets.only(left:20,top:10,bottom:10,right:20),
                    padding:EdgeInsets.only(top:20),
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
                              Text(enrollment.students_name ?? ''),                              
                            ],),
                            SizedBox(height:10),
                                                          Row(
        
                                children: [
                                SizedBox(width:7),
        
                            Icon(Icons.calendar_today_rounded,size:20,color:Palette.theme1),
                              SizedBox(width:10),
                              Text(  
                             'Confirmed on: ${enrollment.confirmedDate != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(enrollment.confirmedDate!)) : ''}',                              
                              
                              ),
        
                                  SizedBox(width:80),
                                  GestureDetector(
                                    onTap: () {
                                                                          Enrollment student = Enrollment(
                                                                              students_name: enrollment.students_name,
                                                                              students_number:enrollment.students_number,
                                                                              parents_name:enrollment.parents_name,
                                                                              parents_number:enrollment.parents_number,
                                                                              address:enrollment.address,
                                                                              gender:enrollment.gender,
                                                                              grade:enrollment.grade,
                                                                              id:enrollment.id,
                                                                              teacher_id: enrollment.teacher_id,
                                                                              student_id: enrollment.student_id,
                                                                              confirmation: enrollment.confirmation,
                                                                              cancellation: enrollment.cancellation,
                                                                              students_email: enrollment.students_email,
                                                                              tuition_joining_date: enrollment.tuition_joining_date,
                                                                              requested_teaching_time: enrollment.requested_teaching_time,
                                                                              startTime: enrollment.startTime,
                                                                              endTime:enrollment.endTime,
                                                                              confirmedDate:enrollment.confirmedDate,

                                                                        );
                                      
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EnrollmentConfirmedDetailPage(),
                                        settings: RouteSettings(arguments: student)
                                        ),
                                      );
                                    },
                                    child: Icon(Icons.arrow_forward_ios_outlined),
                                    // Text("View Info",style: TextStyle(color:Palette.theme1,fontSize: 16,fontWeight: FontWeight.w500),)
                                      
                                    ),
                                ],
                              ),

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


