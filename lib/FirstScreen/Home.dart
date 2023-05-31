
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tutor_app/FirstScreen/search.dart';
import 'package:tutor_app/FirstScreen/teacherList.dart';
import 'package:tutor_app/FirstScreen/teachersearch.dart';
import 'package:tutor_app/utils/colors.dart';

import '../screens/auth_screens/login.dart';
import '../screens/auth_screens/teacherSignUpscreen.dart';
import '../shared_preferences.dart/user_preferences.dart';
import 'appBar.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget{


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  Widget build(BuildContext context){
    final user = ModalRoute.of(context)!.settings.arguments as String?;
    Size size = MediaQuery.of(context).size;
    return
      SafeArea(
        child: Scaffold(
            appBar: 
            
            PreferredSize(
              preferredSize: const Size.fromHeight(160),
              child:Container(
                height: 170,
                decoration: BoxDecoration(
                color:Palette.theme1,
      
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      color: Palette.theme1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
IconButton(
            icon:Icon(Icons.menu),
            color: Colors.white,
            onPressed:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Login()),
              );

            }

        ),   
                                 Text('Tutor App',style:TextStyle(
                                fontSize: 20,
                                fontWeight:FontWeight.w500,
                                fontStyle:FontStyle.italic,
                                color:Colors.white,
                                         )
                                               ),
            //  user == null?Text("Welcome",style: TextStyle(color:Colors.white),): 
            //  Text("Hello $user,",style: TextStyle(color:Colors.white),),
                                                            
                              // Text("Hello ")

                              IconButton(
                                        icon:Icon(Icons.logout),
                                        color: Colors.white,
                                        onPressed:(){
                                              UserPreferences().removeUser();
                                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Login(),)) ;
                                        }

                                    ),   



                            // Icon(Icons.settings,color:Colors.white),
                        ],
                      ),
                    ),
                    SizedBox(height:18),
                    // AppB(),
      
                    GestureDetector(
                      onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyClassSubjectPage(),));
                      },
                      child: Container(
                        // height:size.height*0.1,
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal:15),
                        padding: EdgeInsets.all(15),
                        decoration:BoxDecoration(
                                    color:Colors.white,
                          
                                      borderRadius: BorderRadius.circular(35)
                                    ),
                        // color:Colors.black,
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text("Search Tutor's as per grade and subject's"),
                          Icon(Icons.search)
                        ],)
                        
                      ),
                    )
                  ],
                ),
              ),
              
            ),
      
      
      
      
      
            body:SafeArea(
      
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    
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
            ),
      //   bottomNavigationBar:CurvedNavigationBar(
      //   backgroundColor: Colors.white,
      //   // color:Colors.deepPurple.shade400,
      //   color:Colors.deepPurple.shade400,

      //   animationDuration: Duration(milliseconds: 300),
      //   onTap:(index){

      //   },
      //   items: [
      //   Icon(Icons.home,color:Colors.white),
      //   Icon(Icons.favorite,color:Colors.white),
      //   Icon(Icons.settings,color:Colors.white),


        

      //  ],)
 
        ),
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