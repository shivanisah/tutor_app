import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:tutor_app/enrollments/EnrollmentViewDetailPage.dart';
import 'package:tutor_app/enrollments/enrollmentDetailPage.dart';
import 'package:tutor_app/utils/colors.dart';

import '../models/user_models/enrolledStudentsmodel.dart';
import '../providers/enrollmentlist_provider.dart';



class EnrollmentList extends StatefulWidget{
  @override
  State<EnrollmentList> createState() => _EnrollmentListState();
}

class _EnrollmentListState extends State<EnrollmentList> {
  int? teacherId;
  bool isConfirmationSent = false;
  Set<int> confirmedEnrollmentIds = {};
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final enrollmentProvider = Provider.of<EnrollmentProvider>(context, listen: false);
    teacherId = ModalRoute.of(context)!.settings.arguments as int;
    enrollmentProvider.fetchEnrollments(teacherId!);
  }
// Future<void> updateConfirmation(Enrollment enrollment, bool confirmation) async {
//     final url = Uri.parse('http://192.168.1.71:8000/enrollments/${enrollment.id}/confirm/');
//     final response = await http.post(url);

//     if (response.statusCode == 200) {

// setState(() {
//         enrollment.setConfirmation(confirmation);
//         if (confirmation) {
//           confirmedEnrollmentIds.add(enrollment.id!);
//         } else {
//           confirmedEnrollmentIds.remove(enrollment.id!);
//         }

//       });    
//       } 
//       else 
//       {
//       throw Exception('Failed to update confirmation');
//     }
//   }

List<Enrollment> sortEnrollments(List<Enrollment> enrollments) {
    enrollments.sort((a, b) {
      final aDateTime = DateTime(a.dateJoined!.year, a.dateJoined!.month, a.dateJoined!.day, a.time!.hour, a.time!.minute, a.time!.second);
      final bDateTime = DateTime(b.dateJoined!.year, b.dateJoined!.month, b.dateJoined!.day, b.time!.hour, b.time!.minute, b.time!.second);
      return bDateTime.compareTo(aDateTime);
    });

    return enrollments;
  }  
  @override
  Widget build(BuildContext context) {
// double width = MediaQuery.of(context).size.width;
// double height = MediaQuery.of(context).size.height;


final enrollmentProvider = Provider.of<EnrollmentProvider>(context);
    final enrollments = enrollmentProvider.enrollments;

    final sortedEnrollments = sortEnrollments(enrollments);


    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        
        child:enrollments.isEmpty?Center(
          child: Container(
            margin:EdgeInsets.only(top:200),
            child:Text("No enrollment requests found")),
        ): 
        Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                        SizedBox(height:40),
            Padding(
              padding: const EdgeInsets.only(left:15.0,bottom:9),
              child: Text(
                 'Requested Students',
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
                // itemCount: enrollments.length,
                itemCount: sortedEnrollments.length,

                itemBuilder: (context, index) {
                  // final enrollment = enrollments[index];
                  final enrollment = sortedEnrollments[index];
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
                              Text(enrollment.students_name?? ''),
                              // Text(enrollment.dateJoined.toString()),                   
                              ]),
                              SizedBox(height:10),
                              
                              Row(
        
                                children: [
                                SizedBox(width:7),
        
                            Icon(Icons.calendar_today_rounded,size:20,color:Palette.theme1),
                              SizedBox(width:10),
                              Text(  
                             'Requested on: ${enrollment.dateJoined?.year}-${enrollment.dateJoined?.month.toString().padLeft(2, '0')}-${enrollment.dateJoined?.day.toString().padLeft(2, '0')}'
                              
                              
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
                                                                        );
                                      
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EnrollmentDetailPage(),
                                        settings: RouteSettings(arguments: student)
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
                              Icon(Icons.punch_clock,size:20,color:Palette.theme1),
                              SizedBox(width: 10),
                              Text('Requested time: ${enrollment.time?.hour.toString().padLeft(2, '0')}:${enrollment.time?.minute.toString().padLeft(2, '0')}:${enrollment.time?.second.toString().padLeft(2, '0')}'),
                              
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


