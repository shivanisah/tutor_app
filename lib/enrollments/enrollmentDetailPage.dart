import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutor_app/app_urls/app_urls.dart';
// import 'package:tutor_app/student/studentEnrollment.dart';

import '../models/user_models/enrolledStudentsmodel.dart';
// import '../models/user_models/teacher_data.dart';
// import '../utils/colors.dart';
import 'package:http/http.dart' as http;

import '../utils/colors.dart';


class EnrollmentDetailPage extends StatefulWidget{

  @override
  State<EnrollmentDetailPage> createState() => _EnrollmentaDetailPage();
}

class _EnrollmentaDetailPage extends State<EnrollmentDetailPage> {
  bool isUpdatingConfirmation = false;  
  bool isUpdatingCancellation= false;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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

  Future<void> updateCancellation(Enrollment enrollment, bool cancellation) async {
    setState(() {
      isUpdatingCancellation = true;

    });
    try{
    final url = Uri.parse(AppUrl.baseUrl+'/enrollments/${enrollment.id}/cancel/');
    final now = DateTime.now();
    final response = await http.post(url,
        body:{
      'cancelledDate':DateFormat('yyyy-MM-dd HH:mm:ss').format(now),
    }

    
    );

    if (response.statusCode == 200) {

  setState(() {
        enrollment.setCancellation(cancellation);
        enrollment.setCancellationDate(now);
      }); 
    final snackBar = SnackBar(content: Text('Enrollment Cancellation message has been sent successfully'),backgroundColor: Palette.theme1,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

         } 
         
         else {
      throw Exception('Failed to update cancellation');
    }
  }catch(error){

  }finally{
    setState(() {
      isUpdatingCancellation = false;
    });
  }
  }
  Future<void> showCancellationConfirmationDialog(Enrollment enrollment)async{
    return showDialog<void>(
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          title:Text("Request Rejection"),
          content:Text("Are you sure you want to Reject the Enrollment Request?"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                updateCancellation(enrollment,true);
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

    Future<void> showConfirmationDialog(Enrollment enrollment)async{
    return showDialog<void>(
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          title:Text("Request Accept"),
          content:Text("Are you sure you want to Accept the Enrollment Request?"),
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


  @override
  Widget build(BuildContext context) {
    
    Enrollment enrollment = ModalRoute.of(context)!.settings.arguments as Enrollment;
    String formattedStartTime = enrollment.startTime?? '';
    String formattedEndTime = enrollment.endTime?? '';
    List<String>? subjectsString = enrollment.subjects?? [];

    return Scaffold(

      appBar:AppBar(

      ),

      body:SingleChildScrollView(
        child: Container(
          padding:EdgeInsets.only(top:20,left:10),
          margin: EdgeInsets.only(left:20,right:20,top:40,bottom:30),
          height:580,
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
                              Icon(Icons.call,size:18),
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
                              Text(subjectsString.join(','),style:TextStyle(fontSize: 16)),
                              ]), 
                      SizedBox(height:12),  
                       Row(children: [
                              Icon(Icons.date_range,size:18),
                              SizedBox(width:10),

                              Text("Requested teaching date: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text('${enrollment.tuition_joining_date}',style:TextStyle(fontSize: 16)),
                              ]),     
                     SizedBox(height:12),  
                       Row(children: [
                            Icon(Icons.punch_clock_rounded,size:18),
                              SizedBox(width:10),

                              Text("Requested teaching time: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text('${formattedStartTime.substring(0,5)} - ${formattedEndTime.substring(0,5)}',style:TextStyle(fontSize: 16)),
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
                            Icon(Icons.call,size:18),
                              SizedBox(width:10),

                              Text("Contact Number: ",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                              Text('${enrollment.parents_number}',style:TextStyle(fontSize: 16)),
                              ]),     



            

                      SizedBox(height:60),
                      Divider(thickness:2,endIndent: 10,),
      
            Padding(
              padding: const EdgeInsets.only(left:20.0,right:20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
            
                enrollment.confirmation
                      ? Text("Accepted")
                      : 
   
                          SizedBox(
                            width:130,
                            child: ElevatedButton(
                              onPressed: () {
                                // updateConfirmation(enrollment, true);
                              showConfirmationDialog(enrollment);

                              },
                              child: isUpdatingConfirmation?CircularProgressIndicator(color:Colors.white):Text("Accept"),
                            ),
                          ),
                              enrollment.cancellation
                      ? Text("Rejected")
                      : 
                          
                          SizedBox(
                            width:130,
                            child: ElevatedButton(
                              onPressed: () {
                                // updateCancellation(enrollment, true);
                                showCancellationConfirmationDialog(enrollment);
                              },
                              child: isUpdatingCancellation?CircularProgressIndicator(color:Colors.white):Text("Reject"),
                            ),
                          ),
              ],),
            ),
                            
          ]),
        
        ),
      ),

    );



    


  }

}
