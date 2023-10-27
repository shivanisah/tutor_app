// import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/Apis/teacherList.dart';
import 'package:tutor_app/models/user_models/searchmodel.dart';
import 'package:tutor_app/providers/auth_provider.dart';
import 'package:tutor_app/providers/classSubjectprovider.dart';
import 'package:tutor_app/providers/enrollmentlist_provider.dart';
import 'package:tutor_app/providers/finaltimeslot_provider.dart';
import 'package:tutor_app/providers/student_provider.dart';
import 'package:tutor_app/providers/teacherProfileprovider.dart';
import 'package:tutor_app/providers/teacherlistprovider.dart';
import 'package:tutor_app/providers/timeSlot_provider.dart';
import 'package:tutor_app/shared_preferences.dart/user_preferences.dart';
import 'package:tutor_app/startScreens/splashScreen.dart';
import 'package:tutor_app/startScreens/startPage.dart';
import 'package:tutor_app/utils/colors.dart';
// import 'package:tutor_app/providers/googlemapPage.dart';

// import 'FirstScreen/Home.dart';
// import 'FirstScreen/teacher_search.dart';

void main() {
  
  runApp(
    const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
            providers: [
        ChangeNotifierProvider(create: (_)=>AuthProvider ()),
        ChangeNotifierProvider(create: (_)=>UserPreferences ()),
        ChangeNotifierProvider(create: (_)=>EnrollmentProvider ()),
        ChangeNotifierProvider(create: (_)=>TeacherProfileProvider ()),
        ChangeNotifierProvider(create: (_)=>TimeSlotProvider ()),
        ChangeNotifierProvider(create: (_)=>StudentProvider ()),
        ChangeNotifierProvider(create: (_)=>FinalTimeSlotProvider ()),
        ChangeNotifierProvider(create: (_)=>TeacherListProvider()),
        ChangeNotifierProvider(create: (_)=>ClassSubjectProvider()),



      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes:{
          '/splash' :(context) => SplashScreen()
        },
        title: 'Tutor App',
        theme: ThemeData(
          primarySwatch: Palette.theme,
        ),
        home:  AccountPage(),
      ),
    );
  }
}
