import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../models/user_models/teacher_data.dart';
import '../models/user_models/timeSlot.dart';
import '../student/studentEnrollment.dart';
import '../utils/colors.dart';


class TutorDetailScreen extends StatefulWidget {
    final TeacherData teacher;

  TutorDetailScreen({required this.teacher});

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreen();
}

class _TutorDetailScreen extends State<TutorDetailScreen> {
  List<TimeSlot>? timeSlots;
  String? selectedTimeSlot;
  TimeOfDay? selectedstartTimeSlot;
  TimeOfDay? selectedendTimeSlot;
  @override
  void initState(){
    super.initState();
    timeSlots = widget.teacher.timeSlots;
  }
  String _formatTime(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            // floatingActionButton: FloatingButton(),
            body: SingleChildScrollView(
              child: SizedBox(
                height: 920,
                width: size.width * 1,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        child: Image.asset(
                          'assets/images/d1.jpg',
                        )),

        Positioned(
            top:15,
            left: 15,
            
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: CircleAvatar(backgroundColor: Colors.white,radius:24,child: Icon(Icons.arrow_back),))),

                    Positioned(
                      top: 240,
                      bottom: 0,
                      child: Container(
                        padding:EdgeInsets.only(left:20,right:10),
                        height: 250,
                        width: size.width * 1,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                                SizedBox(height:20),
                        Text( widget.teacher.fullName,style:TextStyle(fontSize: 25,color:Palette.fontcolor)),
                        SizedBox(height: 6),
                        SizedBox(height:10),
                        Row(children: [
                        Icon(Icons.person_3_sharp,size:20),
                              SizedBox(width:16),
                      Text('${widget.teacher.gender}',style: TextStyle(fontSize: 18,)),
    
                            
                            
                        ],),
                            
                        SizedBox(height:15),

                        Row(children: [
                        Icon(Icons.place_rounded,size:20),
                              SizedBox(width:16),
                            
                        Text('City: ',style: TextStyle(fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500,
                        )),
                            
                        Text('${widget.teacher.address}',style: TextStyle(fontSize: 18,)),
   
                        ],),
                        SizedBox(height:2),
                            
                        SizedBox(height:15),
                        Row(children: [
                          Icon(Icons.school,size:20),
                                  SizedBox(width:16),
                            
                        Text('Education: ',style: TextStyle(fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500)),
                            
                        ],),
                        SizedBox(height:2),
                        Text('        ${widget.teacher.education}',style: TextStyle(fontSize: 18,)),
                            
                            
                        SizedBox(height:15),
                            
                        Row(children: [
                        Icon(Icons.timeline_rounded,size:20),
                        SizedBox(width:16),
                            
                        Text('Teaching Experience: ',style: TextStyle(fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500)),
                            
                        ],),
                        SizedBox(height:2),
                        Text('        ${widget.teacher.teaching_experience}',style: TextStyle(fontSize: 18,)),
                            
                            
                        SizedBox(height:15),
                            
                        Row(children: [
                        Icon(Icons.book_sharp,size:20),
                        SizedBox(width:16),
                        Text('Teaching Grade: ',style: TextStyle(fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500)),
                            
                        ],),
                        SizedBox(height:2),
                        Text('        ${widget.teacher.grade}',style: TextStyle(fontSize: 18,)),
                            
                      SizedBox(height:15),
                            
                      Row(children: [
                      Icon(Icons.book_sharp,size:20),
                        SizedBox(width:16),

                        Text('Teaching subjects: ',style: TextStyle(fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500)),
                            
                        ],),
                    SizedBox(height:2),

                      Text('        ${widget.teacher.subjects?.join(', ')}',style: TextStyle(fontSize: 18,)),
                            
                      SizedBox(height:16),
                            
                            
                      Row(children: [
                        Icon(Icons.house,size:20),
                        SizedBox(width:16),

                        Text('Teaching Location: ',style: TextStyle
                        (fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500,
                        
                        
                        )),
                            
                        ],),
                                              SizedBox(height:2),
                      Text('        ${widget.teacher.teaching_location}',style: TextStyle(fontSize: 18,)),
                      SizedBox(height:16),
                          Row(children: [
                        Icon(Icons.timer,size:20),
                        SizedBox(width:16),

                        Text('Select Time Slot: ',style: TextStyle
                        (fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500,
                        
                        
                        )),
                            
                        ],),

            SizedBox(height:13),

       GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        mainAxisExtent:MediaQuery.of(context).size.height*0.06,

        ),
       itemCount:widget.teacher.timeSlots?.length ?? 0,
        itemBuilder: (context,index){
          TimeSlot timeSlot = widget.teacher.timeSlots![index];
          return 
          GestureDetector(
            onTap:(){
              setState(() {
                // selectedTimeSlot = '${timeSlot.startTime!.substring(0,5)} - ${timeSlot.endTime!.substring(0,5)}';
                //       print(selectedTimeSlot); 
                selectedstartTimeSlot = timeSlot.startTime; 
                selectedendTimeSlot = timeSlot.endTime;             
                
              });
            },
            child:Container(
              padding :EdgeInsets.only(left:10,top:12,right:4),
              // margin:EdgeInsets.only(right:10),
                    //  height:20,
                      //  width:350,
                    //  padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                    color: selectedstartTimeSlot == timeSlot.startTime &&
        selectedendTimeSlot == timeSlot.endTime
        ? Color.fromARGB(255, 25, 132, 29)
        
        : Palette.theme1,
                      width: 2,
                      style: BorderStyle.solid,
                      
                      
                      ),
                                boxShadow:[
                                    BoxShadow(
                                      color: Color.fromARGB(255, 188, 187, 187),
      
                                      blurRadius:2,
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

                    
                    // color: selectedTimeSlot == '${timeSlot.startTime!.substring(0,5)} - ${timeSlot.endTime!.substring(0,5)}'? Colors.green:Palette.theme1
                    // color: selectedTimeSlot == '${timeSlot.startTime!} - ${timeSlot.endTime!}'? Colors.green:Palette.theme1
        //             color: selectedstartTimeSlot == timeSlot.startTime &&
        // selectedendTimeSlot == timeSlot.endTime
        // ? Colors.green
        // : Palette.theme1,

            
            ),
            child:     Text(
            //  '${timeSlot.startTime!.substring(0,5)} - ${timeSlot.endTime!.substring(0,5)}',
            '${_formatTime(timeSlot.startTime!)} - ${_formatTime(timeSlot.endTime!)}',

             style:TextStyle(color:Colors.black),
            )
       
            ),
       
          );
          
          
        }
        
        ) , 

  
                    
                                        SizedBox(height:40),
                                        Center(
                                          child: 
                                          GestureDetector(
                                              onTap: (){
                                            final formattedStartTime = _formatTime(selectedstartTimeSlot!);
                                             final formattedEndTime = _formatTime(selectedendTimeSlot!);
       

                                                 Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) =>StudentEnrollment(),
                                                  settings: RouteSettings(arguments:{
                                                    'teacher':widget.teacher,
                                                    // 'selectedTimeSlot':selectedTimeSlot,
                                                    'selectedstartTimeSlot':formattedStartTime,
                                                    'selectedendTimeSlot':formattedEndTime,
                                                  }
                                                  
                                                  
                                                  )
                                                    ),
                                                );
                                              
                                              
                                              },
                                              child: Container(
                                                height:50,
                                                width:300,
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                // border: Border.all(width: 0.7,color: Colors.black),
                                                  color: Palette.theme1
                                                ),
                                                child:
                                                      
                                                    Center(child: Text('Enroll',style:TextStyle(color:Colors.white,fontSize: 16))),                                       
                                              ),
                                            ),
                                        ),
                    

                        
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // bottomSheet: const GroupOderButton()
            )
            );
  }
}
