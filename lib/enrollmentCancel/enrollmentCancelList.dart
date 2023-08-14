import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../models/user_models/enrolledStudentsmodel.dart';
import '../providers/enrollmentlist_provider.dart';

import 'enrollmentRejectedDetailPage.dart';



class RejectedStudentsList extends StatefulWidget{
  @override
  State<RejectedStudentsList> createState() => _RejectedStudentsList();
}

class _RejectedStudentsList extends State<RejectedStudentsList> {
  int? teacherId;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
    // final enrollmentProvider = Provider.of<EnrollmentProvider>(context, listen: false);
    // teacherId = ModalRoute.of(context)!.settings.arguments as int;
    // enrollmentProvider.fetchRejectedEnrollments(teacherId!);
  }

  Future<void> fetchData()async{
    try{
          final enrollmentProvider = Provider.of<EnrollmentProvider>(context, listen: false);
    teacherId = ModalRoute.of(context)!.settings.arguments as int;
   await enrollmentProvider.fetchRejectedEnrollments(teacherId!);

    }catch(error){

    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }
    List<Enrollment> sortEnrollments(List<Enrollment> enrollments) {
    enrollments.sort((a, b) {
      DateTime aDate = a.cancelledDate !=null?DateTime.parse(a.cancelledDate!):DateTime(0);
      DateTime bDate = b.cancelledDate !=null?DateTime.parse(b.cancelledDate!):DateTime(0);
      return bDate.compareTo(aDate);
    });

    return enrollments;
  }  


  @override
  Widget build(BuildContext context) {

  final enrollmentProvider = Provider.of<EnrollmentProvider>(context);
  final enrollments = enrollmentProvider.rejectedEnrollments;
  final sortedEnrollments = sortEnrollments(enrollments);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        
        child:isLoading?Padding(
          padding: const EdgeInsets.only(top:150),
          child: Center(child: CircularProgressIndicator(),),
        ):enrollments.isEmpty?Center(child: Container(
          margin:EdgeInsets.only(top:200),
          child:Text("No Rejected Enrollments"))) :
        
        Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
          SizedBox(height:40),
            Padding(
              padding: const EdgeInsets.only(left:15.0,bottom:9),
              child: Text(
                 'Rejected Enrollments',
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
                itemCount: sortedEnrollments.length,
                itemBuilder: (context, index) {
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
                             'Rejected on: ${enrollment.cancelledDate != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(enrollment.cancelledDate!)) : ''}',                              
                              
                            
                       
                              
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
                                                                              startTime: enrollment.startTime,
                                                                              endTime:enrollment.endTime,
                                                                              cancelledDate:enrollment.cancelledDate,
                                                                              confirmedDate: enrollment.confirmedDate,
                                                                              subjects: enrollment.subjects,
                                                                        );
                                      
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EnrollmentRejectedDetailPage(),
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


