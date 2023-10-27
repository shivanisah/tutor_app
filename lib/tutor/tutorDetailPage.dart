import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user_models/teacher_data.dart';
import '../utils/colors.dart';


class TutorDetailPage extends StatefulWidget{
  TutorDetailPage({required this.teacher});

  final TeacherData teacher;

  @override
  State<TutorDetailPage> createState() => _TutorDetailpage();
}

class _TutorDetailpage extends State<TutorDetailPage> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        // bottomSheet: Container(
        //   padding: EdgeInsets.all(15),
        //   color: Colors.white,
        //   child:                                           GestureDetector(
        //                                       onTap: (){
        //                                          Navigator.push(
        //                                           context,
        //                                           MaterialPageRoute(builder: (context) =>StudentEnrollment(),
        //                                           settings: RouteSettings(arguments:widget.teacher)
        //                                             ),
        //                                         );
                                              
                                              
        //                                       },
        //                                       child: Container(
        //                                         height:50,
        //                                         width:300,
        //                                         padding: EdgeInsets.all(5),
        //                                         decoration: BoxDecoration(
        //                                         borderRadius: BorderRadius.circular(6),
        //                                         // border: Border.all(width: 0.7,color: Colors.black),
        //                                           color: Palette.theme1
        //                                         ),
        //                                         child:
                                                      
        //                                             Center(child: Text('Enroll',style:TextStyle(color:Colors.white,fontSize: 16))),                                       
        //                                       ),
        //                                     ),

        // ),
        // appBar:AppBar(
        //   elevation: 0,
        //   foregroundColor: Colors.white,
    
        // ),
    
        body:Container(
        
          // margin: EdgeInsets.only(left:20,right:20,top:40,bottom:30),
          height:900,
          
          // color:Colors.blue,
          
          child: Stack(
            
            children: [
            ClipRRect(
              child: Image.asset('assets/images/d1.jpg',fit: BoxFit.cover,width: 360,height: 290,),
            ),
            // Container(
            //   height:250,
            //   decoration:BoxDecoration(
            //                 // color: Palette.theme1,
            
            //     borderRadius:BorderRadius.only(topRight:Radius.circular(16),topLeft: Radius.circular(16)),
            
            
            //   ),
            
            //   // color:Colors.white,
            //                     child:  Center(
            //                       child: Container( 
            //                         height:250,
            //                         width:320,
            //                                                     // height:140,
            //                       // width:200,
            //                       decoration:BoxDecoration(
            //                           // borderRadius:BorderRadius.only(bottomLeft:Radius.circular(30),topRight:Radius.circular(16)),
                                      
            //                           image:DecorationImage(
                                        
                                        
                                        
            //                             image:AssetImage("assets/images/d1.jpg"),
                                                                
                                                                
            //                                   // image: widget.teacher.image != null
            //                                   //   ? NetworkImage(widget.teacher.image!.path,) 
            //                                   //   : const AssetImage("assets/images/d1.jpg") as ImageProvider<Object>,                 
            //                                    fit:BoxFit.cover,
                                               
                                               
            //                                   //  alignment: Alignment.topCenter,
            //                           )
                                                                
            //                       ),
            //                       // child:CircleAvatar(backgroundImage: AssetImage("assets/images/d1.jpg"),
            //                       // radius:70
            //                       // )
            //                                                 ),
            //                     ),
            
            //               //       Center(
            //               //     child: ClipOval(
            //               // child:    SizedBox(
            //               //    width:128,
            //               //       height:128,
            //               //   child: AspectRatio(
            //               //               aspectRatio: 1.0,
            //               //       child:widget.teacher.image!=null?Image.file(widget.teacher.image!,fit:BoxFit.cover,
            //               //       width:128,
            //               //       height:128,
            //               //       alignment: Alignment.topCenter,
            //               //       ):
                                
                              
            //               //       Image.asset('assets/images/d1.jpg',                                     
            //               //        fit:BoxFit.cover,
            //               //       width:128,
            //               //       height:128,
            //               //       alignment: Alignment.topCenter,
            //               //     ),
            //               //                         ),
            //               //                    ),
            //               //     ),
            //               //   ),
            
              
            // ),
          
          Positioned(
            top:15,
            left: 15
            ,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: CircleAvatar(backgroundColor: Colors.white,radius:24,child: Icon(Icons.arrow_back),))),
          
          
          
            Positioned(
              top: 240,
              child: SingleChildScrollView(
                child: Container(
                  padding:EdgeInsets.only(left:10,right:10),
                  width:360,
                  // color:Colors.green,
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30)),
                  ),
                    
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:20),
                        Text( widget.teacher.fullName,style:TextStyle(fontSize: 25,color:Palette.fontcolor)),
                        // SizedBox(height: 6),
                        SizedBox(height:10),
                        Row(children: [
                        Icon(Icons.face,size:20),
                              SizedBox(width:10),
                      Text('${widget.teacher.gender}',style: TextStyle(fontSize: 18,)),
    
                            
                            
                        ],),
                            
                        SizedBox(height:15),

                        Row(children: [
                        Icon(Icons.place_rounded,size:20),
                              SizedBox(width:10),
                            
                        Text('City: ',style: TextStyle(fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500,
                        )),
                            
                            
                        ],),
                        SizedBox(height:2),
                        Text('      ${widget.teacher.address}',style: TextStyle(fontSize: 18,)),
                            
                        SizedBox(height:15),
                        Row(children: [
                          Icon(Icons.school,size:20),
                                  SizedBox(width:10),
                            
                        Text('Education: ',style: TextStyle(fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500)),
                            
                        ],),
                        SizedBox(height:2),
                        Text('      ${widget.teacher.education}',style: TextStyle(fontSize: 18,)),
                            
                            
                        SizedBox(height:15),
                            
                        Row(children: [
                        Icon(Icons.timeline_rounded,size:20),
                        SizedBox(width:10),
                            
                        Text('Teaching Experience: ',style: TextStyle(fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500)),
                            
                        ],),
                        SizedBox(height:2),
                        Text('       ${widget.teacher.teaching_experience}',style: TextStyle(fontSize: 18,)),
                            
                            
                        SizedBox(height:15),
                            
                        Row(children: [
                        Icon(Icons.book_sharp,size:20),
                        SizedBox(width:10),
                        Text('Teaching Grade: ',style: TextStyle(fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500)),
                            
                        ],),
                        SizedBox(height:2),
                        Text('       ${widget.teacher.grade}',style: TextStyle(fontSize: 18,)),
                            
                      SizedBox(height:15),
                            
                      Row(children: [
                      Icon(Icons.book_sharp,size:20),
                        SizedBox(width:10),

                        Text('Teaching subjects: ',style: TextStyle(fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500)),
                            
                        ],),
                    SizedBox(height:2),

                      Text('      ${widget.teacher.subjects?.join(', ')}',style: TextStyle(fontSize: 18,)),
                            
                      SizedBox(height:16),
                            
                            
                      Row(children: [
                        Icon(Icons.house,size:20),
                        SizedBox(width:10),

                        Text('Teaching Location: ',style: TextStyle
                        (fontSize: 18,color:Palette.theme1,fontWeight:FontWeight.w500,
                        
                        
                        )),
                            
                        ],),
                        SizedBox(height:2),
                      Text('       ${widget.teacher.teaching_location}',style: TextStyle(fontSize: 18,)),
  
                    
                                        SizedBox(height:40),
                                        Center(
                                          child: 
                                          GestureDetector(
                                              onTap: (){
                                                //  Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(builder: (context) =>StudentEnrollment(profile),
                                                //   settings: RouteSettings(arguments:widget.teacher)
                                                //     ),
                                                // );
                                              
                                              
                                              },
                                              child: Container(
                                                height:50,
                                                width:300,
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
                                        ),
                    
                                          
                    
                  ],)
                    
                ),
              ),
            ),
          ]),
        
        ),
    
      ),
    );



    


  }
}
