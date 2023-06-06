import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tutor_app/location/teacherinfoWindow.dart';
import 'package:tutor_app/tutor/tutorDetailPage.dart';

import '../app_urls/app_urls.dart';
import '../models/user_models/searchmodel.dart';
import '../models/user_models/teacher_data.dart';
import '../student/studentEnrollment.dart';
import '../utils/colors.dart';

class TeacherMapPage extends StatefulWidget {
  final String className;
  final List<String> subjects;

  const TeacherMapPage({super.key, required this.className, required this.subjects});
  
  @override
  _TeacherMapPageState createState() => _TeacherMapPageState();
}

class _TeacherMapPageState extends State<TeacherMapPage> {
  List<Map<String, dynamic>> teachers = [];
  Set<Marker> markers = {};
  Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  Future<void> getCurrentLocationAndFindTeachers(String selectedClassSubject, List<String> selectedSubjects) async {
    // Check if location services are enabled
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

  //   if (!serviceEnabled) {
  //     // Location services are disabled, handle this case
  //     showDialog(
  //   context: context,
  //   builder: (BuildContext context) => AlertDialog(
  //     title: Text('Location Services Disabled'),
  //     content: Text('Please enable location services to use this feature.'),
  //     actions: [
  //       ElevatedButton(
  //         child: Text('OK'),
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //       ),
  //     ],
  //   ),
  // );
  
  //     return;
  //   }

    // Check for permission to access the location
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      // Location permission is permanently denied, handle this case
            showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Location Permission Denied Forever'),
          content: Text('You have denied location permission forever. Please go to your device settings and enable location access for this app.'),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

      return;
    }
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Location permission is denied, request it

      showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Location Permission Denied'),
      content: Text('Please enable location permission in your device settings to use this feature.'),
      actions: [
        ElevatedButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
      // permission = await Geolocator.requestPermission();
      // if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
      //   // Location permission is denied, handle this case
      //   return;
      // }
    }
    print(".....................................");
print(selectedClassSubject);
print(selectedSubjects);
    // Get the current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double latitude = position.latitude;
    double longitude = position.longitude;

    // Make a POST request to the Django view
    var url = Uri.parse(AppUrl.findteacherinmap);
    var response = await http.post(
      url,
      body: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'class':selectedClassSubject,
        'subjects':selectedSubjects.join(','),

        

      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        teachers = List<Map<String, dynamic>>.from(data['teachers']);
        markers = _createMarkers(teachers);
      });

      // Animate the marker motion
      if (_mapController.isCompleted) {
        GoogleMapController controller = await _mapController.future;
        markers.forEach((marker) async {
          LatLng target = marker.position;
          controller.animateCamera(CameraUpdate.newLatLng(target));
          await Future.delayed(Duration(seconds: 1)); // Adjust the delay as per your preference
        });
      }
    } else {
      // Handle the error response...
    }
  }

  Set<Marker> _createMarkers(List<Map<String, dynamic>> teachers) {
    Set<Marker> markers = {};
    teachers.forEach((teacher) {
      String name = teacher['name'];
      String grade = teacher['grade'];
      String email = teacher['email'];
      int id = teacher['id'];
      String phone_number = teacher['phone_number'];
      double latitude = double.parse(teacher['latitude']);
      double longitude = double.parse(teacher['longitude']);
      // List<String> subjects = teacher['subjects'].cast<String>();


      Marker marker = Marker(
        markerId: MarkerId(name),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: name,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),

        onTap:(){
          _showTeacherInfo(context, name, grade,email,id,phone_number);
        }
      );

      markers.add(marker);
    });
    return markers;
  }
  void _showTeacherInfo(BuildContext context, String name, String grade,String email,int id,String phone_number) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
  ),

    builder: (BuildContext context) {
      return Container(
        height:150,
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Name: $name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text('Email: $email'),
                SizedBox(height: 4.0),
                // Text('Subjects: ${subjects.join(", ")}'),
                                                  SizedBox(height:20),
                                    GestureDetector(
                                        onTap: (){
                                        TeacherData teacher = TeacherData(
                                          
                                                            fullName:name,
                                                            grade: grade,
                                                            email:email,
                                                            id:id,
                                                            phoneNumber: phone_number


                                                          );
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=>TutorDetailPage(teacher:teacher)));
          
          
                                        },
                                        child: Container(
                                          height:50,
                                          width:120,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          // border: Border.all(width: 0.7,color: Colors.black),
                                            color: Palette.theme1
                                          ),
                                          child:
                                                
                                              Center(child: Text('View Details',style:TextStyle(color:Colors.white,fontSize: 16))),                                       
                                        ),
                                      ),
          
              ],
            ),
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Map'),
      ),
      body: Column(
        children: [
          Expanded(
            
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(27.7172, 85.3240),                        
                  zoom: 12,             
              ),
              markers: markers,
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              // Other map configuration options...
            ),
          ),
      ElevatedButton(
      onPressed: () {
        getCurrentLocationAndFindTeachers(widget.className, widget.subjects);
      },
      child: Text('Click Here'),
      ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: teachers.length,
          //     itemBuilder: (context, index) {
          //       String name = teachers[index]['name'];
          //       double latitude = double.parse(teachers[index]['latitude']);
          //       double longitude = double.parse(teachers[index]['longitude']);
          //       String grade= teachers[index]['grade'];
      
          //       return Card(
          //         child: ListTile(
          //           title: Text(name),
          //           subtitle: Text('Latitude: $latitude, Longitude: $longitude.Grade:$grade'),
          //           // Other card content...
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
