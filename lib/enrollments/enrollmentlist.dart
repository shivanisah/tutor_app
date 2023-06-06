import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_models/enrolledStudentsmodel.dart';
import '../providers/enrollmentlist_provider.dart';
import 'package:http/http.dart' as http;



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
      body: Container(
        margin:EdgeInsets.only(top: 60),

        child: ListView.builder(
          itemCount: enrollments.length,
          itemBuilder: (context, index) {
            final enrollment = enrollments[index];
            final isConfirmed = confirmedEnrollmentIds.contains(enrollment.id);
            return Container(
                  decoration: BoxDecoration(
                    // border:BorderRadius(Radius.circular(8))
                  ),
            );
            
            // ListTile(
            //   title: Text(enrollment.students_name?? ''),
            //   subtitle: Text('Confirmation: ${enrollment.confirmation ? 'True' : 'False'}'),
            //   trailing: enrollment.confirmation
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


