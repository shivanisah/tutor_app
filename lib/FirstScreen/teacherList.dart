
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tutor_app/screens/auth_screens/studentSignUpScreen.dart';

import '../Apis/teacherList.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/colors.dart';



class TeachersList extends StatefulWidget{
  @override
  State<TeachersList> createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  // String api = "http://192.168.1.83:8000/teacher/";
    TeacherList teacherlist =TeacherList();

  @override
  void initState(){
        // teacherlist.getAllTeacher();

    super.initState();

  }
  @override
  Widget build(BuildContext context){
    return Container(

      // height:400,
      // color:Colors.grey,
      child: FutureBuilder<List<dynamic>>(
        future:teacherlist.getAllTeacher(),
        builder:(BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
          print(snapshot.data);
          if(snapshot.hasData){
            return       GridView.builder(
              // scrollDirection:Axis.vertical,
                physics:NeverScrollableScrollPhysics(),
                shrinkWrap:true,
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,
                  mainAxisExtent:MediaQuery.of(context).size.height*0.45,

                ),
                itemCount:snapshot.data?.length,
                itemBuilder:(context,i){

                  return GestureDetector(
                    onTap:(){
                      // Navigator.push(
                      //        context,
                      //       MaterialPageRoute(builder: (context) =>Student()),
                      //       );
                    },
                    child: Container(
                        // height:500,
                        margin:EdgeInsets.only(right:14,left:10,top:5,bottom:13),
                        // margin:EdgeInsets.all(5),
                        // width:160,
                        // color:Colors.red,
                        // child:  Text("hfurht"),
                        decoration:BoxDecoration(
                            color:Colors.white,
                            borderRadius:BorderRadius.circular(8),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.grey,

                                blurRadius:5,
                                offset:Offset(0,5),
                              ),
                              BoxShadow(
                                color:Colors.white,
                                offset:Offset(-5,0),
                              ),
                              // BoxShadow(
                              //     color:Colors.white,
                              //   offset:Offset(5,0),
                              // ),
                            ]
                        ),

                        child:Column(
                          children: [
                            Container(
                              height:140,
                              // width:200,
                              decoration:BoxDecoration(
                                  borderRadius:BorderRadius.only(topLeft:Radius.circular(8),topRight:Radius.circular(8)),
                                  
                                  image:DecorationImage(
                                    
                                    // image:AssetImage("assets/images/d1.jpg"),


                                          image: snapshot.data![i]["image"] != null
                                            ? NetworkImage(snapshot.data![i]["image"])
                                            : const AssetImage("assets/images/d1.jpg") as ImageProvider<Object>,                 
                                           fit:BoxFit.cover,
                                           
                                           alignment: Alignment.topCenter,
                                  )

                              ),
                              // child:CircleAvatar(backgroundImage: AssetImage("assets/images/d1.jpg"),
                              // radius:70
                              // )
                            ),
                            // Divider(color: Colors.black12,),
                            // SizedBox(height:10),
                            Container(
                                width:200,
                                padding: EdgeInsets.all(8),
                                // color:Colors.red,
                                child:Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(snapshot.data![i]['full_name']),
                                    SizedBox(height:5),

                                    Text(snapshot.data![i]["phone_number"]),

                                    SizedBox(height:5),

                                    // Text(snapshot.data![i]["gender"]),


                                    Text(snapshot.data![i]["email"]),

                                    SizedBox(height:8),

                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentSignUp()));

                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        // border: Border.all(width: 0.7,color: Colors.black),
                                          color: Palette.theme1
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(width:6),
                                            Text('View Details',style:TextStyle(color:Colors.white)),
                                            SizedBox(width:8),
                                         Icon(Icons.arrow_circle_right,color:Colors.white),
                                    
                                          ],
                                        ),
                                      ),
                                    ),
                                  

                                  ],)
                            )
                          ],
                        )
                    ),
                  );
                }
            );

          }else{
            return const Center(
              child:Text("No data found")
            );

          }
        }

      )







    );
  }
}
