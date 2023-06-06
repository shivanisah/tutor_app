import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:tutor_app/student/studentEnrollment.dart';

import '../models/user_models/teacher_data.dart';
import '../utils/colors.dart';


class TutorDetailPage extends StatefulWidget{
  final TeacherData teacher;

  TutorDetailPage({required this.teacher});
  @override
  State<TutorDetailPage> createState() => _TutorDetailpage();
}

class _TutorDetailpage extends State<TutorDetailPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(

          // title:Text("Welcome Tutor"),
      ),

      body:Container(
        margin: EdgeInsets.only(left:20,right:20,top:40,bottom:30),
        height:600,
        
        // color:Colors.blue,
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(8),
          color:Colors.white,
                  boxShadow:[
                              BoxShadow(
                                color: Colors.grey,

                                blurRadius:3,
                                offset:Offset(0,3),
                              ),
                              // BoxShadow(
                              //   color:Colors.white,
                              //   offset:Offset(-5,0),
                              // ),
                              // BoxShadow(
                              //     color:Colors.white,
                              //   offset:Offset(5,0),
                              // ),
                            ]

        ),
        child: Column(children: [
          Container(
            height:200,
            color:Colors.white,
                              child:  Container( 
                                                            height:140,
                              // width:200,
                              decoration:BoxDecoration(
                                  borderRadius:BorderRadius.only(topLeft:Radius.circular(8),topRight:Radius.circular(8)),
                                  
                                  image:DecorationImage(
                                    
                                    // image:AssetImage("assets/images/d1.jpg"),


                                          image: widget.teacher.image != null
                                            ? NetworkImage(widget.teacher.image!.path) 
                                            : const AssetImage("assets/images/d1.jpg") as ImageProvider<Object>,                 
                                           fit:BoxFit.cover,
                                           
                                           alignment: Alignment.topCenter,
                                  )

                              ),
                              // child:CircleAvatar(backgroundImage: AssetImage("assets/images/d1.jpg"),
                              // radius:70
                              // )
                            ),

                        //       Center(
                        //     child: ClipOval(
                        // child:    SizedBox(
                        //    width:128,
                        //       height:128,
                        //   child: AspectRatio(
                        //               aspectRatio: 1.0,
                        //       child:widget.teacher.image!=null?Image.file(widget.teacher.image!,fit:BoxFit.cover,
                        //       width:128,
                        //       height:128,
                        //       alignment: Alignment.topCenter,
                        //       ):
                              
                            
                        //       Image.asset('assets/images/d1.jpg',                                     
                        //        fit:BoxFit.cover,
                        //       width:128,
                        //       height:128,
                        //       alignment: Alignment.topCenter,
                        //     ),
                        //                         ),
                        //                    ),
                        //     ),
                        //   ),

            
          ),
          Container(
            height:356,
            // color:Colors.green,
            decoration:BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(60.0),topRight: Radius.circular(60)),
            color:Colors.white,
            ),

            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text('Full Name: ${widget.teacher.fullName}'),
                  Text('Gender: ${widget.teacher.gender}'),
                  Text('City: ${widget.teacher.address}'),

                  Text('Education: ${widget.teacher.education}'),
                  Text('Teaching Experience: ${widget.teacher.teaching_experience}'),
                  Text('Teaching Grade: ${widget.teacher.grade}'),

                  Text('Teaching Location: ${widget.teacher.teaching_location}'),
                  // Text('Teaching Location: ${widget.teacher.teaching_location}'),



                                  SizedBox(height:20),
                                  GestureDetector(
                                      onTap: (){
                                         Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>StudentEnrollment(),
                                          settings: RouteSettings(arguments:widget.teacher)
                                            ),
                                        );


                                      },
                                      child: Container(
                                        height:50,
                                        width:80,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        // border: Border.all(width: 0.7,color: Colors.black),
                                          color: Palette.theme1
                                        ),
                                        child:
                                              
                                            Center(child: Text('Enroll',style:TextStyle(color:Colors.white,fontSize: 16))),                                       
                                      ),
                                    ),

            ],)

          ),
        ]),
      
      ),

    );



    


  }

}
