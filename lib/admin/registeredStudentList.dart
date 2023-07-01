import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../providers/student_provider.dart';




class RegisteredStudentList extends StatefulWidget{
  @override
  State<RegisteredStudentList> createState() => _RegisteredStudentListState();
}

class _RegisteredStudentListState extends State<RegisteredStudentList> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    studentProvider.fetchRegisteredStudentList();
  }


  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final students = studentProvider.registeredStudent;



    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        
        child:students.isEmpty?Center(
          child: Container(
            margin:EdgeInsets.only(top:200),
            child:Text("No registered students found")),
        ): 
       Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                        SizedBox(height:40),
            Padding(
              padding: const EdgeInsets.only(left:15.0,bottom:9),
              child: Text(
                 'Registered Students',
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
                itemCount: students.length,
                // itemCount: sortedEnrollments.length,

                itemBuilder: (context, index) {
                  final student = students[index];
                  // final enrollment = sortedEnrollments[index];
                  // final isConfirmed = confirmedEnrollmentIds.contains(enrollment.id);
                  return
                   Container(
                    margin:EdgeInsets.only(left:20,top:10,bottom:10,right:20),
                    padding:EdgeInsets.only(top:10),
                    height:100,
                    
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
                              Text(student.email?? ''),
                              ]),
                              SizedBox(height:10),
                            Row(children: [
                              SizedBox(width:7),
                              Icon(Icons.calendar_month,size:24,color:Palette.theme1),
                              SizedBox(width: 10),
                              Text(
                             'Regitration Date: ${student.date_joined?.year}-${student.date_joined?.month.toString().padLeft(2, '0')}-${student.date_joined?.day.toString().padLeft(2, '0')}'
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


