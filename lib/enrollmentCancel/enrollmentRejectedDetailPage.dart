import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tutor_app/app_urls/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:tutor_app/student/studentEnrollment.dart';

import '../models/user_models/enrolledStudentsmodel.dart';
// import '../models/user_models/teacher_data.dart';
// import '../utils/colors.dart';

import '../models/user_models/timeSlot.dart';
import '../utils/colors.dart';
import 'package:http/http.dart' as http;

class EnrollmentRejectedDetailPage extends StatefulWidget{

  @override
  State<EnrollmentRejectedDetailPage> createState() => _EnrollmentRejectedDetailPage();
}

class _EnrollmentRejectedDetailPage extends State<EnrollmentRejectedDetailPage> {
  bool isUpdatingConfirmation = false;
    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
   Future<void> callnumber(String? number) async{
    await launchUrl(Uri(scheme:'tel',path:number));

  }
  Future<void> callparentsnumber(String? number) async{
    await launchUrl(Uri(scheme:'tel',path:number));

  }


  Future<void> updateConfirmation(Enrollment enrollment, bool confirmation) async {
    setState(() {
      isUpdatingConfirmation = true;
    });
    try{
    final url = Uri.parse(AppUrl.baseUrl+'/enrollments/${enrollment.id}/confirm/');
    final now = DateTime.now();
    final response = await http.post(url,
        body:{
      'confirmedDate':DateFormat('yyyy-MM-dd HH:mm:ss').format(now),
    }

    );

    if (response.statusCode == 200) {

      setState(() {
              enrollment.setConfirmation(confirmation);
              enrollment.setConfirmationDate(now);

            }); 
    final snackBar = SnackBar(content: Text('Enrollment Confirmation message has been sent successfully'),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

         } 
         
         else {
      throw Exception('Failed to update confirmation');
    }
  }catch(error){

  }finally{
    setState(() {
      isUpdatingConfirmation = false;
    });
  }
  }

    Future<void> showConfirmationDialog(Enrollment enrollment)async{
    return showDialog<void>(
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          title:Text("Enrollment Accept"),
          content:Text("Are you sure you want to Accept the Enrollment ?"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                updateConfirmation(enrollment,true);
              },
              child:Text('Yes')
            ),
            TextButton(
              onPressed:(){
                Navigator.of(context).pop();
              },
              child:Text('No'),
            ),
          ],

        );
      }
    );
  }


String _formatTime(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
} 

  @override
  Widget build(BuildContext context) {
    Enrollment enrollment = ModalRoute.of(context)!.settings.arguments as Enrollment;
    // String formattedStartTime = enrollment.startTime?? '';
    // String formattedEndTime = enrollment.endTime?? '';
    List<String>? subjectsString = enrollment.subjects?? [];
    List<TimeSlot>? slots = enrollment.timelsots;
    


    return Scaffold(

      appBar:AppBar(

      ),

      body:SingleChildScrollView(
        child: Container(
          padding:EdgeInsets.only(top:20,left:10,right:10),
          margin: EdgeInsets.only(left:20,right:10,top:40,bottom:30),
          height:665,
          width:350,
          
          // color:Colors.blue,
          decoration:BoxDecoration(
            borderRadius:BorderRadius.circular(20),
            // border:Border.all(color:Colors.blueGrey,width: 2),
            
            color:Colors.white,
                    boxShadow:[
                                BoxShadow(
                                  color: Colors.grey,
      
                                  blurRadius:3,
                                  offset:Offset(0,1),
                                ),
                              ]
      
          ),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(children: [
              Icon(Icons.account_circle_rounded,size:90,color:Palette.theme1),
              SizedBox(width:10),
              Column(
                crossAxisAlignment:CrossAxisAlignment.start,
      
                children: [
                Text('${enrollment.students_name}',style:TextStyle(fontSize: 20)),
                SizedBox(height:6),
                Text(enrollment.students_email?? '',style:TextStyle(fontSize: 15)),
                // Text('${enrollment.students_email}',style:TextStyle(fontSize: 15)),

      
              ],)
      
            ],),
            Divider(thickness: 2,color:Colors.blueGrey,indent:5,endIndent: 10,),
            SizedBox(height:7),
            Row(children: [
                              Icon(Icons.face,size:18),
                              SizedBox(width:10),
                              Text("Gender: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text(enrollment.gender?? '',style:TextStyle(fontSize: 16)),
                              ]),

            SizedBox(height:12),
                        Row(children: [
                              Icon(Icons.place_rounded,size:18),
                              SizedBox(width:10),

                              Text("Address: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text(enrollment.address?? '',style:TextStyle(fontSize: 16)),
                              ]),
     
            SizedBox(height:12),  
                        Row(children: [
                            // Container(
                            //   color: Colors.blue,
                            //   child: IconButton(onPressed:(){
                            //     print(enrollment.students_number);
                            //       callnumber(enrollment.students_number);
                            //   } , 
                            //   icon:Icon(Icons.call),
                            //   iconSize: 6,
                            //   ),
                            // ),
                            GestureDetector(
                              child:Icon(Icons.call,size: 20,color:Color.fromARGB(255, 5, 85, 8)),
                              onTap:(){
                                callnumber(enrollment.students_number);
                              }
                            ),
                              SizedBox(width:10),

                              Text("Phone Number: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text(enrollment.students_number?? '',style:TextStyle(fontSize: 16)),
                              ]),
     
                      SizedBox(height:12),  
                       Row(children: [
                              Icon(Icons.school,size:18),
                              SizedBox(width:10),

                              Text("Grade: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text(enrollment.grade?? '',style:TextStyle(fontSize: 16)),
                              ]),  

                    SizedBox(height:12),  
                       Row(children: [
                             Icon(Icons.bookmarks,size:18),
                              SizedBox(width:10),

                              Text("Subjects: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              ]), 
                              Row(
                                children: [
                                  SizedBox(width: 26),
                                  Expanded(child: Text(subjectsString.join(','),style:TextStyle(fontSize: 16))),
                                ],
                              ),

                      SizedBox(height:12),  
                       Row(children: [
                              Icon(Icons.date_range,size:18),
                              SizedBox(width:10),

                              Text("Requested teaching date: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text('${enrollment.tuition_joining_date}',style:TextStyle(fontSize: 16)),
                              ]),     
                     SizedBox(height:12),  
                       Row(children: [
                            Icon(Icons.access_time,size:18),
                              SizedBox(width:10),

                              Text("Requested teaching time: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              for(TimeSlot slot in slots!)
                              Text('${_formatTime(slot.startTime!)} - ${_formatTime(slot.endTime!)}',
                              style:  GoogleFonts.poppins(

                                   fontSize:  15,
                                   fontWeight: FontWeight.w400,

                                     )
                              ),
                              // Text('${formattedStartTime.substring(0,5)} - ${formattedEndTime.substring(0,5)}',style:TextStyle(fontSize: 16)),
                              ]),
                      SizedBox(height:12),  

                      enrollment.confirmation?
                       
                       Row(children: [
                            Icon(Icons.check_circle_sharp,size:18,color:Color.fromARGB(255, 5, 85, 8)),
                              SizedBox(width:10),

                              Text("Confirmed on: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text(  
                             '${enrollment.confirmedDate != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(enrollment.confirmedDate!)) : ''}',                              
                              
                              ),
                              ]):
                       Row(children: [
                            Icon(Icons.check_circle_sharp,size:18,),
                              SizedBox(width:10),

                              Text("Confirmation: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text( "Not Confirmed Yet" )
                              
                              
                              ]),



                      SizedBox(height:12),  
                       Row(children: [
                            Icon(Icons.cancel,size:18,color:const Color.fromARGB(255, 182, 70, 62)),
                              SizedBox(width:10),

                              Text("Rejected on: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text(  
                             '${enrollment.cancelledDate != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(enrollment.cancelledDate!)) : ''}',                              
                              
                              ),
                              ]),     
            
    
                      SizedBox(height:10),
                      Divider(endIndent: 10,),
                      Text("Parents Detail",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color:Palette.theme1)),
                      SizedBox(height:12),  
                       Row(children: [
                            Icon(Icons.face,size:18),
                              SizedBox(width:10),

                              Text("Name: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text('${enrollment.parents_name}',style:TextStyle(fontSize: 16)),
                              ]), 

                     SizedBox(height:12),  
                       Row(children: [
                            GestureDetector(
                              child:Icon(Icons.call,size: 20,color:Color.fromARGB(255, 5, 85, 8)),
                              onTap:(){
                                callparentsnumber(enrollment.parents_number);
                              }
                            ),
                            
                              SizedBox(width:10),

                              Text("Contact Number: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text('${enrollment.parents_number}',style:TextStyle(fontSize: 16)),
                              ]),     



            

                      SizedBox(height:60),
                      Divider(thickness:2,endIndent: 10,),
                       enrollment.confirmation
                      ? Text('')
                      : 
   
                          SizedBox(
                            width:130,
                            child: ElevatedButton(
                              onPressed: () {
                               showConfirmationDialog(enrollment);

                                // updateConfirmation(enrollment, true);
                              },
                              child: isUpdatingConfirmation?CircularProgressIndicator(color:Colors.white):Text("Change Status"),
                            ),
                          ),

      
                            
          ]),
        
        ),
      ),

    );



    


  }
  

}
