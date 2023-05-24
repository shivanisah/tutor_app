import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tutor_app/providers/auth_provider.dart';
// import 'package:tutor_app/providers/googlemapPage.dart';

import 'FirstScreen/Home.dart';
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
        // ChangeNotifierProvider<TeacherMapPage>(create: (_)=>TeacherMapPage ()),
        // Provider<Completer<GoogleMapController>>(create: (_) => Completer<GoogleMapController>()),

      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  Home(),
      ),
    );
  }
}
