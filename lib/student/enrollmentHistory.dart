import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/models/user_models/enrolledStudentsmodel.dart';
import 'package:tutor_app/providers/enrollmentlist_provider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../models/user_models/timeSlot.dart';

class EnrollmentHistory extends StatefulWidget{
  @override
  State<EnrollmentHistory> createState() => _EnrollmentHistoryState();
}

class _EnrollmentHistoryState extends State<EnrollmentHistory> {


  bool isLoading = true;
  int? studentId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  
  Future<void> fetchData() async{
    try{
    final provider = Provider.of<EnrollmentProvider>(context, listen: false);
    studentId = ModalRoute.of(context)!.settings.arguments as int;
    await provider.enrollmentHistory(studentId);

    }catch(error){

    }finally{
      setState(() {
        isLoading = false;
      });
    }

  }

  List<Enrollment> sortEnrollments(List<Enrollment> enrollments) {
    enrollments.sort((a, b) {
      final aDateTime = DateTime(a.dateJoined!.year, a.dateJoined!.month, a.dateJoined!.day, a.time!.hour, a.time!.minute, a.time!.second);
      final bDateTime = DateTime(b.dateJoined!.year, b.dateJoined!.month, b.dateJoined!.day, b.time!.hour, b.time!.minute, b.time!.second);
      return bDateTime.compareTo(aDateTime);
    });

    return enrollments;
  } 
  String _formatTime(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
} 

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EnrollmentProvider>(context);
    final datalist = provider.enrollhistory;
    final sortedData = sortEnrollments(datalist);



    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        
        child:isLoading?Padding(
          padding: const EdgeInsets.only(top:150),
          child: Center(child:CircularProgressIndicator()),
        ):datalist.isEmpty?Center(
          child: Container(
            margin:EdgeInsets.only(top:200),
            child:Text("No history record found")),
        ): 
       Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                        SizedBox(height:40),
            Padding(
              padding: const EdgeInsets.only(left:15.0,bottom:9),
              child: Text(
                 'Enrollment',
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
                physics: NeverScrollableScrollPhysics(),
                itemCount: sortedData.length,

                itemBuilder: (context, index) {
                  final data = sortedData[index];
                  List<String>? subjectsString = data.subjects?? [];
                  // String formattedStartTime = data.startTime?? '';
                  // String formattedEndTime = data.endTime?? '';
                  
                  List<TimeSlot>? slot= data.timelsots;
                  
                  return
                   Container(
                    margin:EdgeInsets.only(left:20,top:10,bottom:10,right:20),
                    padding:EdgeInsets.only(top:18,left:10,),
                    height:250,
                    
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
                              Text("Teacher Name :",
                              style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                  //  height:  1.5,
                                   fontWeight: FontWeight.w500,
                                   color: Palette.theme1,

                                     )
                                     ),
                              // Icon(Icons.account_circle_rounded,size:30,color:Palette.theme1),
                              SizedBox(width:6),
                              Text(data.teacher_name?? '',
                                style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                   fontWeight: FontWeight.w400,

                                     )

                              ),
                              ]),
                              SizedBox(height:6),
                              Row(children: [
                              SizedBox(width:5),
                              // Icon(Icons.account_circle_rounded,size:30,color:Palette.theme1),
                              Text("Teaching Class :",
                                  style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                  //  height:  1.5,
                                   fontWeight: FontWeight.w500,
                                   color: Palette.theme1,

                                     )

                              ),
                              SizedBox(width:6),
                              Text(data.grade?? '',
                              style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                   fontWeight: FontWeight.w400,

                                     )
                              ),
                              ]),
                              SizedBox(height:6),
                              Row(children: [
                              SizedBox(width:5),
                              // Icon(Icons.account_circle_rounded,size:30,color:Palette.theme1),
                              Text("Subjects :",
                                    style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                  //  height:  1.5,
                                   fontWeight: FontWeight.w500,
                                   color: Palette.theme1,

                                     )

                              ),
                              SizedBox(width:6),
                              Expanded(
                                child: Text(subjectsString.join(','),
                                style:  GoogleFonts.poppins(
                              
                                     fontSize:  15,
                                     fontWeight: FontWeight.w400,
                              
                                       )
                                ),
                              ),
                              ]),
                              SizedBox(height:6),
                              Row(children: [
                              SizedBox(width:5),
                              // Icon(Icons.account_circle_rounded,size:30,color:Palette.theme1),
                              Text("Student Name :",
                                  style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                  //  height:  1.5,
                                   fontWeight: FontWeight.w500,
                                   color: Palette.theme1,

                                     )

                              ),
                              SizedBox(width:6),

                              Text(data.students_name?? ''),
                              ]),
                              SizedBox(height:6),
                            Row(children: [
                              SizedBox(width:5),
                              // Icon(Icons.account_circle_rounded,size:30,color:Palette.theme1),
                              Text("Teaching Location :",
                                  style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                   height:  1.5,
                                   fontWeight: FontWeight.w500,
                                   color: Palette.theme1,

                                     )

                              ),
                              SizedBox(width:6),
                              Text(data.teaching_location?? '',
                              style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                   fontWeight: FontWeight.w400,

                                     )
                              ),
                              ]),
                              SizedBox(height:6),
                            Row(children: [
                              SizedBox(width:5),
                              // Icon(Icons.account_circle_rounded,size:30,color:Palette.theme1),
                              Text("Teaching Time :",
                                  style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                  //  height:  1.5,
                                   fontWeight: FontWeight.w500,
                                   color: Palette.theme1,

                                     )

                              ),
                              SizedBox(width:6),
                              for(TimeSlot slots in slot!)
                            Text('${_formatTime(slots.startTime!)} - ${_formatTime(slots.endTime!)}',
                              // Text('${formattedStartTime} - ${formattedEndTime}',
                              style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                   fontWeight: FontWeight.w400,

                                     )
                              ),
                              
                              ]),
                              SizedBox(height:6),

                              Row(children: [
                                SizedBox(width:5),

                                Text("Requested on :",
                                  style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                  //  height:  1.5,
                                   fontWeight: FontWeight.w500,
                                   color: Palette.theme1,

                                     )

                                ),
                              // Icon(Icons.calendar_month,size:24,color:Palette.theme1),
                              SizedBox(width: 6),
                              Text(
                             '${data.dateJoined?.year}-${data.dateJoined?.month.toString().padLeft(2, '0')}-${data.dateJoined?.day.toString().padLeft(2, '0')}'
                                ,style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                   fontWeight: FontWeight.w400,

                                     )),
                              
                              ]),
                                SizedBox(height:6),

                              Row(children: [
                                SizedBox(width:5),

                                Text("Enrollment for :",
                                  style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                  //  height:  1.5,
                                   fontWeight: FontWeight.w500,
                                   color: Palette.theme1,

                                     )

                                ),
                              // Icon(Icons.calendar_month,size:24,color:Palette.theme1),
                              SizedBox(width: 6),
                              Text(data.enrollment_for?? '',

                                style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                   fontWeight: FontWeight.w400,

                                     )),
                              
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


