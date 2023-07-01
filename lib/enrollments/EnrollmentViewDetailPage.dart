import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/utils/colors.dart';

import '../models/user_models/enrolledStudentsmodel.dart';
import '../providers/enrollmentlist_provider.dart';
import 'package:http/http.dart' as http;



class EnrollmentStudentDetailPage extends StatefulWidget{
  @override
  State<EnrollmentStudentDetailPage> createState() => _EnrollmentStudentDetailPage();
}

class _EnrollmentStudentDetailPage extends State<EnrollmentStudentDetailPage> {
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
Future<void> updateConfirmation(Enrollment enrollment, bool confirmation) async {
    final url = Uri.parse('http://192.168.1.71:8000/enrollments/${enrollment.id}/confirm/');
    final response = await http.post(url);

    if (response.statusCode == 200) {

setState(() {
        enrollment.setConfirmation(confirmation);
        if (confirmation) {
          confirmedEnrollmentIds.add(enrollment.id!);
        } else {
          confirmedEnrollmentIds.remove(enrollment.id!);
        }
      });    } else {
      // Error handling
      throw Exception('Failed to update confirmation');
    }
  }
  @override
  Widget build(BuildContext context) {

final enrollmentProvider = Provider.of<EnrollmentProvider>(context);
    final enrollments = enrollmentProvider.enrollments;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin:EdgeInsets.only(top: 60),

        child: ListView.builder(
          itemCount: enrollments.length,
          itemBuilder: (context, index) {
            final enrollment = enrollments[index];
            final isConfirmed = confirmedEnrollmentIds.contains(enrollment.id);
            return
             Container(
              margin:EdgeInsets.only(left:20,top:10,bottom:10,right:20),
              height:60,
              
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
                  child:Row(children: [
                    SizedBox(width:5),
                    Text(enrollment.students_name?? ''),
                    SizedBox(width:80),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ()),
                        // );
                      },
                      child: Text("View Info",style: TextStyle(color:Palette.theme1,fontSize: 16,fontWeight: FontWeight.w500),)
                        
                      ),
                    
                enrollment.confirmation
        ? Text("Confirmed")
        : Visibility(
            visible: !isConfirmed,
            child: ElevatedButton(
              onPressed: () {
                updateConfirmation(enrollment, true);
              },
              child: Text("Confirm"),
            ),
          ),
                  ],)
            );
            
            // ListTile(
            //   title: Text(enrollment.students_name?? ''),
            //   subtitle: Text('Confirmation: ${enrollment.confirmation ? 'True' : 'False'}'),
            //   trailing: 
            // enrollment.confirmation
            //       ? Text("Confirmed")
            //       : isConfirmed ?null
            //           // ? ElevatedButton(
            //           //     onPressed: () {
            //           //       updateConfirmation(enrollment, false);
            //           //     },
            //           //     child: Text("Unconfirm"),
            //           //   )
            //           : ElevatedButton(
            //               onPressed: () {
            //                 updateConfirmation(enrollment, true);
            //               },
            //               child: Text("Confirm"),
            //             ),
            // );
          },
        ),
      ),
    );
  }


    


  }


