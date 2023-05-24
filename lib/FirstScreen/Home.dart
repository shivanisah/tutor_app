
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tutor_app/FirstScreen/search.dart';
import 'package:tutor_app/FirstScreen/teacherList.dart';
import 'package:tutor_app/FirstScreen/teachersearch.dart';

import 'appBar.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget{
  @override

  Widget build(BuildContext context){
    return
      Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child:AppB(),
          ),



          body:SafeArea(

            child: SingleChildScrollView(
              child: Column(
                children: [
                  
                  MyClassSubjectPage(),
                  Container(
                    // height:215,
                    // color:Colors.blue,
                    // child: ListView.separated(
                    //     itemCount:20,
                    //     separatorBuilder:(context,index){
                    //       return SizedBox(width:1.7);
                    //     },
                    //     scrollDirection:Axis.horizontal,
                    //     itemBuilder:(context,index){
                    //       return Container(
                    //           height:200,
                    //           width:150,
                    //           // color:Colors.red,
                    //           margin:EdgeInsets.all(8),
                    //           decoration:BoxDecoration(
                    //               color:Colors.white,
                    //               borderRadius:BorderRadius.circular(20),
                    //               boxShadow:[
                    //                 BoxShadow(
                    //                   // color:Color(0xFFe8e8e8),
                    //                   color: Color.fromRGBO(87, 87, 87, 1).withOpacity(0.25),
                    //                   blurRadius:5.0,
                    //                   offset:Offset(5,5),
                    //                 )
                    //               ]
                    //           ),
                    //           child:Column(
                    //               children:[
                    //                 Container(
                    //                     height:120,
                    //                     decoration:BoxDecoration(
                    //                         borderRadius:BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20)),
                    //                         image:DecorationImage(
                    //                           image:AssetImage("assets/images/d1.jpg"),
                    //                         )
                    //                     )
                    //                 ) ,
                    //                 Container(
                    //                     padding:EdgeInsets.all(7),
                    //                     decoration:BoxDecoration(

                    //                     ),
                    //                     child:Column(
                    //                       crossAxisAlignment:CrossAxisAlignment.start,
                    //                       // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text("Name"),
                    //                         SizedBox(height:6),
                    //                         Text("Faculty Roll"),
                    //                         SizedBox(height:6),
                    //                         Row(
                    //                             mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    //                             children:[
                    //                               Text("Rs"),
                    //                               Text("Rs"),
                    //                             ])
                    //                       ],)
                    //                 )
                    //               ]

                    //           )
                    //       );

                    //     }
                    // ),

                  ),

                  // button for getting students current location
                  // SizedBox(height:30),

            //         ElevatedButton(
            // onPressed:()
            // // getCurrentLocationAndFindTeachers,
            // {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) =>TeacherMapPage()),
            //   );

            // },
            //           child: Text('Find Nearby Teachers'),
            //         ),
                  SizedBox(height:30),
                  Container(
                      height:50,
                      width:400,
                      margin:EdgeInsets.only(left:10,right:10),
                      padding:EdgeInsets.only(left:10,top:10),
                      // width:20,
                      // color:Colors.blue,
                      decoration:BoxDecoration(
                          color:Colors.white,
                          borderRadius:BorderRadius.circular(8),
                          boxShadow:[
                            BoxShadow(
                              offset: Offset(1, 1),
                              spreadRadius: 0,
                              blurRadius: 2,
                              color: Color.fromRGBO(0, 0, 0, 1).withOpacity(0.25),
                            ),
                            BoxShadow(
                              offset: Offset(-1, -1),
                              spreadRadius: 0,
                              blurRadius: 2,
                              color: Color.fromRGBO(0, 0, 0, 1).withOpacity(0.25),
                            )
                            // BoxShadow(
                            //   color:Colors.grey,
                            //   blurRadius:3,
                            //   offset:Offset(0,3),
                            // ),
                          ]
                      ),
                      child:Text("Best Tutors",style:TextStyle(
                          fontSize:20,fontStyle:FontStyle.italic,
                          fontWeight: FontWeight.w400
                      ),)
                  ),
                  SizedBox(height:12),

                  TeachersList(),
                ],
              ),
            ),
          )
      ) ;

  }

void getCurrentLocationAndFindTeachers() async {
  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are disabled, handle this case
    return;
  }

  // Check for permission to access the location
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    // Location permission is permanently denied, handle this case
    return;
  }
  if (permission == LocationPermission.denied) {
    // Location permission is denied, request it
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
      // Location permission is denied, handle this case
      return;
    }
  }

  // Get the current position
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  double latitude = position.latitude;
  double longitude = position.longitude;

  // Make a POST request to the Django view
  var url = Uri.parse('http://192.168.1.81:8000/find_teachers/');
  var response = await http.post(
    url,
    body: {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    },
  );

  if (response.statusCode == 200) {
  } else {
  }
}
}