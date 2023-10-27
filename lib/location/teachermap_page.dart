import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tutor_app/FirstScreen/teachersearch.dart';
import 'package:tutor_app/models/user_models/classsubjectmodel.dart';
import 'package:tutor_app/models/user_models/mapclasssubject.dart';
import 'package:tutor_app/tutor/tutorDetailScreen.dart';

import '../app_urls/app_urls.dart';
import '../models/user_models/teacher_data.dart';
import '../models/user_models/timeSlot.dart';
import '../tutor/maptutordetailscreen.dart';
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

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
            showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Location Permission Denied Forever'),
          content: Text('You have denied location permission forever. Please go to your device settings and enable location access for this app.'),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                            Geolocator.openLocationSettings();

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
            Geolocator.openLocationSettings();
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
    print('Response Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');
  if(response.statusCode==405){
            showDialog(
          context:context,
          builder:(BuildContext context)=>AlertDialog(
            title:Text("No Nearby Teachers Found"),
            content:Text("Sorry, there are no nearby teachers available as per your search result"),
            actions: [
              ElevatedButton(
                child:Text('OK'),
                onPressed:(){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MyClassSubjectPage()));
                }
              )
            ],
          )
        );

  }
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if(data.containsKey('message') && data['message'] == 'No nearby teachers found'){
        showDialog(
          context:context,
          builder:(BuildContext context)=>AlertDialog(
            title:Text("No Nearby Teachers Found"),
            content:Text("Sorry, there are no nearby teachers available as per your search result"),
            actions: [
              ElevatedButton(
                child:Text('OK'),
                onPressed:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>MyClassSubjectPage()));
                }
              )
            ],
          )
        );

      }
    
      else{
      setState(() {
        teachers = List<Map<String, dynamic>>.from(data['teachers']);
        markers = _createMarkers(teachers);
      });

      }
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
      String jsonResponse = teacher['classlist'];

      // print("response $jsonResponse");
      Map<String, dynamic> teacherData = jsonDecode(jsonResponse);
      List<dynamic> classList = teacherData['classlist'];

// Map<String, dynamic> teacherData = jsonDecode(teacher['classlist']);
      
      List<TimeSlot> timeSlots = List<TimeSlot>.from(teacher['time_slots'].map((slot) => TimeSlot.fromJson(slot)));
      // List<MapClassSubject> classSubjectlist = List<MapClassSubject>.from(teacherData.map((e)=>MapClassSubject.fromMap(e)));
      dynamic classSubjectlist = MapClassSubject.fromMap(teacherData);

      String name = teacher['name'];
      String? grade = teacher['grade'];
      String email = teacher['email'];
      int id = teacher['id'];
      String phone_number = teacher['phone_number'];
      String? address = teacher['address'];
      String? teaching_location = teacher['teaching_location'];
      String? teaching_experience = teacher['teaching_experience'];
      String? gender = teacher['gender'];
      String? education = teacher['education'];
      String? subjects = teacher['subjects'];
      String? image    = teacher['image'];  
      
      // print(timeSlots);
      // print(teacher['classlist']); 
      print(classSubjectlist);
      double latitude = double.parse(teacher['latitude']);
      double longitude = double.parse(teacher['longitude']);
// String jsonResponse = teacher['classlist'];
// print("response $jsonResponse");
// Map<String, dynamic> teacherData = jsonDecode(jsonResponse);
// print("data:$teacherData");

// List<dynamic> classList = teacherData['classlist'];
// for (var classData in classList) {
//   String className = classData['class_name'];
//   List<dynamic> subject = classData['subjects'];
//   print('Class Name: $className');
//   for(String getsubject in subject){
//     print("Subjects: $getsubject");
//   }
  
// }
      Marker marker = Marker(
        markerId: MarkerId(name),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: name,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),

        onTap:(){
          _showTeacherInfo(context, name, grade ?? '',email,id,phone_number,address ?? '',teaching_location ??'',
          
          teaching_experience?? '',gender?? '',education ??'',subjects ?? '',image,timeSlots,classSubjectlist);
        }
      );

      markers.add(marker);
    });
    return markers;
  }
  void _showTeacherInfo(BuildContext context, String name, String? grade,String email,int id,String phone_number,String? address,
                        String? teaching_location,String? teaching_experience,String? gender,String? education,String? subjects, String? image, 
                        List<TimeSlot> timeSlots, classSubjectlist, 
  ) {
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
                                          List<String>? subjectsList = subjects?.split(',');
                                          String? finalImage;
                                          image!=null?finalImage = AppUrl.baseUrl+image:finalImage="assets/images/d1.jpg";
                                        TeacherData teacher = TeacherData(
                                          
                                                            fullName:name,
                                                            grade: grade ?? '',
                                                            email:email,
                                                            id:id,
                                                            phoneNumber: phone_number,
                                                            address:address,
                                                            teaching_experience: teaching_experience,
                                                            teaching_location: teaching_location,
                                                            education: education,
                                                            gender:gender,
                                                            subjects:subjectsList,
                                                            image:finalImage,
                                                            timeSlots: timeSlots,
                                                            mapclasssubject: classSubjectlist,


                                                          );
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=>MapTutorDetailScreen(teacher:teacher)));
          
          
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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color:Palette.theme1),
        title: Text('Teacher Map'),
      ),
      body: Column(
        children: [
          SizedBox(height:20),
          Expanded(
            
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(26.4565, 87.2834),                        
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
