import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/models/user_models/classsubjectmodel.dart';
import 'package:tutor_app/models/user_models/mapclasssubject.dart';
import 'package:tutor_app/providers/student_provider.dart';
import 'package:tutor_app/shared_preferences.dart/user_preferences.dart';
import 'package:tutor_app/student/enrollmentform.dart';

import '../Apis/teacherList.dart';
import '../models/user_models/studentmodel.dart';
import '../models/user_models/teacher_data.dart';
import '../models/user_models/timeSlot.dart';
import '../student/studentEnrollment.dart';
import '../utils/colors.dart';


class MapTutorDetailScreen extends StatefulWidget {
    final TeacherData teacher;

  MapTutorDetailScreen({required this.teacher});

  @override
  State<MapTutorDetailScreen> createState() => _MapTutorDetailScreen();
}

class _MapTutorDetailScreen extends State<MapTutorDetailScreen> {

  final userPreferences = UserPreferences();
  String user_type = '';

  int? studentId;
  bool isLoading = true;
  Student? profile;

  Classlist? _selectedClass;
  List<String> _selectedSubjects = [];

TeacherList teacherlist = TeacherList();
  @override
  void initState(){
    super.initState();
    timeSlots = widget.teacher.timeSlots;
        userPreferences.getUser().then((user) {
    
        setState(() {
          user_type = user.user_type?? '';
        });
      
    
   });  

    fetchData();

    // profile = null;
    // teacherlist.getAllTeacher();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // fetchData();
  // }

  Future<void>  fetchData()async{
    try{
    final studentProfileProvider = Provider.of<StudentProvider>(context,listen:false);
          final student = await userPreferences.getUser();
    // ignore: unnecessary_null_comparison
    if (student != null && student.user_type == 'student') {
      setState(() {
        studentId = student.id!;
      });
      } else {
      setState(() {
        studentId = null;
      });
    }
    await studentProfileProvider.fetchStudentProfile(studentId!);

    }catch(error){

    }finally{
      setState(() {
        isLoading = false;
        studentId = null;
      });
    }
  }


  //
  List<TimeSlot>? timeSlots;
  String? selectedTimeSlot;
  TimeOfDay? selectedstartTimeSlot;
  TimeOfDay? selectedendTimeSlot;
  String _formatTime(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}


  @override
  Widget build(BuildContext context) {
    final studentProfileProvider = Provider.of<StudentProvider>(context);
     profile = studentProfileProvider.studentProfile?? null;
  //   userPreferences.getUser().then((user) {
    
  //       setState(() {
  //         user_type = user.user_type?? '';
  //       });
      
    
  //  });  
     
    
    // print("<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>");
    // print(profile);
    // print("fdjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjd");
    MapClassSubject maplist = widget.teacher.mapclasssubject;
    List<Classlist> classlists = maplist.classlist;
    // print(classlists.length);

    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            // floatingActionButton: FloatingButton(),
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Positioned.fill(
                      top: 0,
                      
                      
                      child:
                      widget.teacher.image!.startsWith('http')
                      ? Image.network(widget.teacher.image!,fit:BoxFit.contain)
                      : Image.asset("assets/images/teacherimg.png")
                      ),
                ),
                    // child: Image.asset(
                    // widget.teacher.image!.path
                      // 'assets/images/d1.jpg',
                    // )
                    // ),
            
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
                    width: size.width * 1,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: SingleChildScrollView(
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
                          
                                    //     Row(children: [
                                    //     Icon(Icons.class_,size:20),
                                    //     SizedBox(width:16),
                                    //     Text('Teaching Grade: ',style: TextStyle(fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500)),
                          
                                    //     ],),
                                    //     SizedBox(height:2),
                                    //     Text('        ${widget.teacher.grade}',style: TextStyle(fontSize: 18,)),
                          
                                    //   SizedBox(height:15),
                          
                                    //   Row(children: [
                                    //   Icon(Icons.subject,size:20),
                                    //     SizedBox(width:16),
                                
                                    //     Text('Teaching subjects: ',style: TextStyle(fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500)),
                          
                                    //     ],),
                                    // SizedBox(height:2),
                                
                                    //   Text('        ${widget.teacher.subjects?.join(', ')}',style: TextStyle(fontSize: 18,)),
                    
                    
                                //..........................................................................................
                                //MultipleclassSubject
                    
                          //showing in dropdown
                          //         ListView.builder(
                          //   shrinkWrap: true,
                          //   itemCount:maplist.classlist.length,
                          //   itemBuilder: (context,index){
                            
                          //     Classlist classsubject = maplist.classlist[index];
                          //     // print(classsubject);
                          //     String subjectsString = classsubject.subjects.join(',');
                          //   return ListTile(
                          //     title: Text(classsubject.className),
                    
                          //     subtitle: Text(subjectsString),
                    
                    
                          //  );
                          // }
                          
                          // ),
                    
                                Column(
                                
                                  
                                children: [
                                Container(
                                margin:EdgeInsets.only(top:4),
                                child: InputDecorator(
                              decoration: InputDecoration(
                                border:OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                                contentPadding:const EdgeInsets.all(10),
                                ),
                    
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<Classlist>(
                                      value: _selectedClass,
                                      isExpanded:true,
                                      isDense: true,
                      hint: Text("Select Class",style:TextStyle(color:Colors.black)),
                    
                                      onChanged: (Classlist? newValue) {
                      setState(() {
                        _selectedClass = newValue;
                        
                        _selectedSubjects.clear();
                      });
                                      },
                                      
                                      items:classlists.map<DropdownMenuItem<Classlist>>((Classlist classSubject) {
                      return DropdownMenuItem<Classlist>(
                        value: classSubject,
                        child: Text(classSubject.className),
                      );
                                      }).toList(),
                                      style: TextStyle(color: Colors.black, fontSize: 19),
                                      icon: Icon(Icons.arrow_drop_down,size: 30,),
                                      underline: SizedBox(),      
                                    ),
                                  ),
                                ),
                                ),
                                SizedBox(height: 4),
                                if (_selectedClass != null)
                                Column(
                                  children: _selectedClass!.subjects.map<Widget>((subject) {
                                    return ListTile(
                                      title: Text(subject),
                                      leading: Theme(
                      data: ThemeData(
                                      checkboxTheme: CheckboxThemeData(
                      fillColor: MaterialStateProperty.all<Color>(Palette.theme1), 
                                       ),
                        ),
                      child: Checkbox(
                        value: _selectedSubjects.contains(subject),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              _selectedSubjects.add(subject);
                            } else {
                              _selectedSubjects.remove(subject);
                            }
                          });
                        },
                      ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                ]
                              ),
                    
                          
                                 
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
                    
                                      timeSlots == null || timeSlots!.isEmpty?  
                        Row(children: [
                      Icon(Icons.warning_outlined,color:Colors.red,size:20),
                      SizedBox(width:16),
                    
                      Text('No Time Slot available for teaching',style: TextStyle
                      (fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500,
                      
                      
                      )),
                          
                      ],):
                    
                        Row(children: [
                      Icon(Icons.access_time,size:20),
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
                        child:     
                        Text(
                        //  '${timeSlot.startTime!.substring(0,5)} - ${timeSlot.endTime!.substring(0,5)}',
                        '${_formatTime(timeSlot.startTime!)} - ${_formatTime(timeSlot.endTime!)}',
                                
                         style:TextStyle(color:Colors.black),
                        )
                                     
                        ),
                                     
                      );
                      
                      
                                      }
                                      
                                      ) , 
                                              
                                     SizedBox(height:40),
                                      timeSlots == null || timeSlots!.isEmpty? Center(
                                        child: 
                                        GestureDetector(
                                            onTap: (){
                                                Flushbar(
                                                    flushbarPosition: FlushbarPosition.TOP,
                                                    message: 'Sorry! No time slot available for teaching.',
                                                    backgroundColor:Colors.red,
                                                    duration: Duration(seconds: 3),
                                                    )..show(context);   
                    
                                            },
                                            child: Container(
                                              height:50,
                                              width:300,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              // border: Border.all(width: 0.7,color: Colors.black),
                                                color: const Color.fromARGB(255, 58, 65, 90)
                                              ),
                                              child:
                                                    
                                                  Center(child: Text('Enroll',style:TextStyle(color:Colors.white,fontSize: 16))),                                       
                                            ),
                                          ),
                                      ):
                    
                                      Center(
                                        child: 
                                        GestureDetector(
                                            onTap: (){
                                     if(user_type!='student'){
                                          Flushbar(
                                            margin:EdgeInsets.all(15),
                                            borderRadius: BorderRadius.circular(8),
                                            flushbarPosition: FlushbarPosition.TOP,
                                            message: 'You must login as Student to get Enrolled',
                                            backgroundColor: Colors.red,
                                            duration:Duration(seconds:3),                   
                                          ).show(context);
                                        }
                    
                                        else if(_selectedClass==null){
                                          Flushbar(
                                            margin:EdgeInsets.all(15),
                                            borderRadius: BorderRadius.circular(8),
                                            flushbarPosition: FlushbarPosition.TOP,
                                            message: 'You must select your class and subject',
                                            backgroundColor: Colors.red,
                                            duration:Duration(seconds:3),                   
                                          ).show(context);
                                        }
                                        else if(_selectedSubjects.isEmpty){
                                          Flushbar(
                                            margin:EdgeInsets.all(15),
                                            borderRadius: BorderRadius.circular(8),
                                            flushbarPosition: FlushbarPosition.TOP,
                                            message: 'You must select Subject',
                                            backgroundColor: Colors.red,
                                            duration:Duration(seconds:3),                   
                                          ).show(context);
                                        }
                    
                    
                                              
                                              else{
                                
                    
                                          final formattedStartTime = _formatTime(selectedstartTimeSlot!);
                                           final formattedEndTime = _formatTime(selectedendTimeSlot!);
                                           final selectedclass = _selectedClass?.className;
                                           final selectedsubjects = _selectedSubjects;
                                              profile?.name==null? 
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) =>StudentEnrollment(),
                                                settings: RouteSettings(arguments:{
                                                  'teacher':widget.teacher,
                                                  // 'selectedTimeSlot':selectedTimeSlot,
                                                  'selectedstartTimeSlot':formattedStartTime,
                                                  'selectedendTimeSlot':formattedEndTime,
                                                  'selectedClass':selectedclass,
                                                  'selectedSubject':selectedsubjects,
                                                }
                                                
                                                
                                                )
                                                  ),
                                              ):
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) =>StudentEnrollDataForm(profile!),
                                                settings: RouteSettings(arguments:{
                                                  'teacher':widget.teacher,
                                                  // 'selectedTimeSlot':selectedTimeSlot,
                                                  'selectedstartTimeSlot':formattedStartTime,
                                                  'selectedendTimeSlot':formattedEndTime,
                                                  'selectedClass':selectedclass,
                                                  'selectedSubject':selectedsubjects,
                    
                                                }
                                                
                                                
                                                )
                                                  ),
                                              );
                    
                                            
                                              }  
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
                ),
              ],
            ),
            // bottomSheet: const GroupOderButton()
            )
            );
  }
}
