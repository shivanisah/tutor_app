import 'package:flutter/material.dart';
import 'package:tutor_app/admin/admindrawer.dart';
import 'package:tutor_app/admin/registeredStudentList.dart';
import 'package:tutor_app/admin/registeredTutors.dart';
// import 'package:tutor_app/admin/verifiedTutorDetailPage.dart';
import 'package:tutor_app/admin/verifiedTutors.dart';
import 'package:tutor_app/utils/colors.dart';


class AdminMainPage extends StatefulWidget{
  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer:AdminDrawer(),
      appBar: AppBar(),
      body: 
      Padding(
        padding: const EdgeInsets.only(top:70),
        child: Column(children: [
          Row(children: [
      
            GestureDetector(
              onTap:(){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisteredTutorList()));

              },
              child:Container(
                height:size.height*0.22,
                width: size.width*0.39,
                margin:EdgeInsets.only(left:22),
                decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset:Offset(0,7),
                      blurRadius: 10,
                      color:Colors.black.withOpacity(0.3),
      
                    )
                  ]
                ),
               child:Column(
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                      Icon(Icons.people,color:Palette.theme1,size:28),
                      SizedBox(height:5),
                      Text('Registered ',style:TextStyle(color:Colors.black,fontSize:16)),
                      SizedBox(height:size.height*0.006),
                      Text('Tutors',style:TextStyle(color:Colors.black,fontSize:16))

               ],) 
              )
            ),
            SizedBox(width:size.width*0.04),
                        GestureDetector(
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisteredStudentList()));
              },
              child:Container(
                height:size.height*0.22,
                width: size.width*0.39,
                margin:EdgeInsets.only(left:22),
                decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset:Offset(0,7),
                      blurRadius: 10,
                      color:Colors.black.withOpacity(0.3),
      
                    )
                  ]
                ),
               child:Column(
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                      Icon(Icons.people,color:Palette.theme1,size:28),
                      SizedBox(height:5),
                      Text('Registered ',style:TextStyle(color:Colors.black,fontSize:16)),
                      SizedBox(height:size.height*0.006),
                      Text('Students',style:TextStyle(color:Colors.black,fontSize:16))
               ],) 
              )
            )

          ],),
        SizedBox(height:size.height*0.06),
                    Row(children: [
      
            GestureDetector(
              onTap:(){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>VerifiedTutorList()));

              },
              child:Container(
                height:size.height*0.22,
                width: size.width*0.39,
                margin:EdgeInsets.only(left:22),
                decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset:Offset(0,7),
                      blurRadius: 10,
                      color:Colors.black.withOpacity(0.3),
      
                    )
                  ]
                ),
               child:Column(
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                      Icon(Icons.people,color:Palette.theme1,size:28),
                      SizedBox(height:5),
                      Text('Verified Tutors',style:TextStyle(color:Colors.black,fontSize:16))
               ],) 
              )
            ),
            // SizedBox(width:size.width*0.04),
            //             GestureDetector(
            //   onTap:(){
            //   },
            //   child:Container(
            //     height:size.height*0.22,
            //     width: size.width*0.39,
            //     margin:EdgeInsets.only(left:22),
            //     decoration:BoxDecoration(
            //       color:Colors.white,
            //       borderRadius:BorderRadius.circular(10),
            //       boxShadow: [
            //         BoxShadow(
            //           offset:Offset(0,7),
            //           blurRadius: 10,
            //           color:Colors.black.withOpacity(0.3),
      
            //         )
            //       ]
            //     ),
            //    child:Column(
            //     mainAxisAlignment:MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //           Icon(Icons.people,color:Palette.theme1,size:28),
            //           SizedBox(height:5),
            //           Text('Students',style:TextStyle(color:Colors.black,fontSize:16))
            //    ],) 
            //   )
            // )

          ],)

        ],),
      )

    );



    


  }

}
