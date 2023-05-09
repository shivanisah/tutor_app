
import 'dart:developer';

import 'package:flutter/material.dart';

import '../Apis/teacherList.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;



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
                  mainAxisExtent:280,

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
                        height:400,
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
                              width:200,
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
                            SizedBox(height:20),
                            Container(
                                width:200,
                                // color:Colors.red,
                                child:Column(
                                  // crossAxisAlignment:CrossAxisAlignment.start,
                                  // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(snapshot.data![i]['full_name']),
                                    SizedBox(height:10),

                                    Text(snapshot.data![i]["phone_number"]),

                                    SizedBox(height:10),

                                    Text(snapshot.data![i]["gender"]),

                                    SizedBox(height:10),

                                    Text(snapshot.data![i]["address"]),

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
