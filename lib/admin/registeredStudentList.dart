import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/app_urls/app_urls.dart';
import 'package:tutor_app/models/user_models/studentmodel.dart';
import 'package:tutor_app/utils/colors.dart';

import '../providers/student_provider.dart';
import 'package:http/http.dart' as http;




class RegisteredStudentList extends StatefulWidget{
  @override
  State<RegisteredStudentList> createState() => _RegisteredStudentListState();
}

class _RegisteredStudentListState extends State<RegisteredStudentList> {


  bool isLoading = true;
  bool isblocked= false;  

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
    // final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    // studentProvider.fetchRegisteredStudentList();
  }

  
  Future<void> fetchData() async{
    try{
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    await studentProvider.fetchRegisteredStudentList();

    }catch(error){

    }finally{
      setState(() {
        isLoading = false;
      });
    }

  }
    List<Student> sortDate(List<Student> studentsdata) {
    studentsdata.sort((a, b) {
      final aDateTime = DateTime(a.date_joined!.year, a.date_joined!.month, a.date_joined!.day, );
      final bDateTime = DateTime(b.date_joined!.year, b.date_joined!.month, b.date_joined!.day,);
      return bDateTime.compareTo(aDateTime);
    });

    return studentsdata;
  } 

    Future<void> blockUser(Student student, bool block) async {
    setState(() {
      isblocked = true;
    });
    try{
    final url = Uri.parse(AppUrl.baseUrl+'/blockUser/${student.id}');
    
    final response = await http.post(url
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {

      setState(() {
              student.setBlockedUser(block);

            }); 
    final snackBar = SnackBar(content: Text('User blocked and message sent to user'),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

         } 
         
         else {
      throw Exception('Failed to block user');
    }
  }catch(error){

  }finally{
    setState(() {
      isblocked = false;
    });
  }
  }
 
     Future<void> UnblockUser(Student student, bool block) async {
    setState(() {
      isblocked = true;
    });
    try{
    final url = Uri.parse(AppUrl.baseUrl+'/UnblockUser/${student.id}');
    
    final response = await http.post(url
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {

      setState(() {
              student.setUnBlockedUser(block);

            }); 
    final snackBar = SnackBar(content: Text('User active and message sent to user'),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

         } 
         
         else {
      throw Exception('Failed to unblock user');
    }
  }catch(error){

  }finally{
    setState(() {
      isblocked = false;
    });
  }
  }

    Future<void> showBlockingDialog(Student student)async{
    return showDialog<void>(
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          title:Text("Block User"),
          content:Text("Are you sure you want to block?"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                blockUser(student,true);
              },
              child:Text('Yes')
            ),
            TextButton(
              onPressed:(){
                Navigator.of(context).pop();
              },
              child:Text('Cancel'),
            ),
          ],

        );
      }
    );
  }
      Future<void> showUnBlockDialog(Student student)async{
    return showDialog<void>(
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          title:Text("UnBlock User"),
          content:Text("Are you sure you want to active the blocked user?"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                UnblockUser(student,false);
              },
              child:Text('Yes')
            ),
            TextButton(
              onPressed:(){
                Navigator.of(context).pop();
              },
              child:Text('Cancel'),
            ),
          ],

        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final students = studentProvider.registeredStudent;
    final sortedData = sortDate(students);



    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        
        child:isLoading?Padding(
          padding: const EdgeInsets.only(top:150),
          child: Center(child:CircularProgressIndicator()),
        ):students.isEmpty?Center(
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
                itemCount: sortedData.length,
                // itemCount: sortedEnrollments.length,

                itemBuilder: (context, index) {
                  final student = sortedData[index];
                  // final enrollment = sortedEnrollments[index];
                  // final isConfirmed = confirmedEnrollmentIds.contains(enrollment.id);
                  return
                   Container(
                    margin:EdgeInsets.only(left:20,top:10,bottom:10,right:20),
                    padding:EdgeInsets.only(top:10),
                    height:88,
                    
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
                            Row( 
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,                    
                              children: [ 

                              Row(
                                children: [
                              SizedBox(width:5),

                               Icon(Icons.account_circle_rounded,size:30,color:Palette.theme1),
                              SizedBox(width:10),

                                  Text(student.email?? ''),
                                ],
                              ),
    //                          GestureDetector(
    //                           child:Icon(Icons.more_horiz,),
    //                           onTap: () {
    //                             PopupMenuButton(
    //   itemBuilder: (BuildContext context) {
    //     return [
    //       PopupMenuItem(
    //         child: Text("Block"),
    //         value: "block",
    //       ),
    //     ];
    //   },
    // );
    //                           },
    //                          )
                              //   student.block == false?
                              // GestureDetector(child:Text("Block"),
                              // onTap:() {
                              //   showBlockingDialog(student);
                              // },):GestureDetector(child:Text("Blocked"))

                              ]),
                              SizedBox(height:10),
                            Row(children: [
                              SizedBox(width:7),
                              Icon(Icons.calendar_month,size:24,color:Palette.theme1),
                              SizedBox(width: 10),
                              Text(
                             'Regitration Date: ${student.date_joined?.year}-${student.date_joined?.month.toString().padLeft(2, '0')}-${student.date_joined?.day.toString().padLeft(2, '0')}'
                                ),
                                SizedBox(width:20),
                                student.block == false?
                              GestureDetector(child:Text("Block"),
                              onTap:() {
                                showBlockingDialog(student);
                              },):GestureDetector(child:Text("Unblock"),
                              onTap:(){
                                showUnBlockDialog(student);
                              }
                              )
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


