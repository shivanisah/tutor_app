import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../screens/auth_screens/teacherSignUpscreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body:
       Center(
        child: ElevatedButton(
          onPressed: () {
            showTutorRegistrationFlushbar(context);
          },
          child: Text('Register as a tutor'),
        ),
      ),
    );
  }

  void showTutorRegistrationFlushbar(BuildContext context) {
    Flushbar(
      title: 'Register as a tutor',
      message: 'Do you want to register as a tutor?',
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 5),
      icon: Icon(Icons.info_outline, color: Colors.white),
      mainButton: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => TutorRegistration()),
          );
        },
        child: Text('Yes'),
      ),
    )..show(context);
  }
}
